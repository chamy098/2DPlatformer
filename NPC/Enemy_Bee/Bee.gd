extends CharacterBody2D

class_name Damageable1

@export var HEALTH = 100
@export var SPEED = -50
@export var SPEED_MULTIPLIER = 1


var facing_right = false
var walking = true
var is_attacking = false
var HitLabel = preload("res://Levels/HUD/Hit_Label/HitLabel.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$EnemyHealthBar.value = HEALTH


func _physics_process(delta):
	if walking == true:
		if !$RaycastDown.is_colliding() && !is_attacking: #This looks on Y axis
			flip()	
		if $RaycastFoward.is_colliding() && !is_attacking: #This looks on X axis
			flip()
		velocity.x = SPEED * SPEED_MULTIPLIER
		move_and_slide()
	

func flip():
	facing_right = !facing_right
	scale.x = abs(scale.x) *  -1
	$EnemyHealthBar.flip(facing_right)
	if facing_right:
		SPEED = abs(SPEED * SPEED_MULTIPLIER)
	else:
		SPEED = abs(SPEED * SPEED_MULTIPLIER) * -1

func hit(value):
	HEALTH -= value
	$EnemyHealthBar.value = HEALTH
	showHitLabel(value)
	if HEALTH <= 0:
		queue_free()

func showHitLabel(value):
	var label = HitLabel.instantiate()
	label.text = str(value)
	if facing_right:
		label.scale.x = -1
	else:
		label.scale.x = 1
	add_child(label)
	var tween = create_tween()

	if facing_right:
		tween.tween_property(label,"position", Vector2(3,-30),0.5)
	else:
		tween.tween_property(label,"position", Vector2(-3,-20),0.5)
		
	await get_tree().create_timer(.3).timeout
	remove_child(label)
	
func enemyDetected():
	#NPC detected the enemy (player) and will attack
	if $RaycastVision.is_colliding() :
		is_attacking = true
		SPEED_MULTIPLIER = 2
	#check if we were attacking before
	elif is_attacking:
		is_attacking = false
		SPEED_MULTIPLIER = 1
	return is_attacking

