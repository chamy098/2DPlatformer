extends CharacterBody2D
var HitLabel = preload("res://Levels/HUD/Hit_Label/HitLabel.tscn")
@export var HEALTH = 100
@export var SPEED = -50
@export var SPEED_MULTIPLIER = 1

signal damage_taken(currentHealth)

var current_speed = SPEED
var facing_right = true
var is_attacking = false

@onready var animation_tree: AnimationTree = $AnimationTree
# Called when the node enters the scene tree for the first time.
func _ready():
	$EnemyHealthBar.value = HEALTH


func _physics_process(delta):
	if(HEALTH > 0):
		if !$RaycastDown.is_colliding() && !is_attacking: #This looks on Y axis
			flip()	
		if $RaycastFoward.is_colliding() && !$RaycastFoward.get_collider().is_in_group('Player') && !is_attacking: #This looks on X axis
			flip()
		velocity.x = current_speed * SPEED_MULTIPLIER
		move_and_slide()
	

func flip():
	facing_right = !facing_right
	scale.x = abs(scale.x) *  -1
	$EnemyHealthBar.flip(facing_right)
	if facing_right:
		current_speed = abs(SPEED * SPEED_MULTIPLIER)
	else:
		current_speed = abs(SPEED * SPEED_MULTIPLIER) * -1

func hit(value):
	HEALTH -= value
	$EnemyHealthBar.value = HEALTH
	showHitLabel(value)
	emit_signal("damage_taken", HEALTH)

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
	#NPC detected the enemy (player) and will increase movement speed
	if $RaycastVision.is_colliding() && $RaycastVision.get_collider().is_in_group('Player'):
		SPEED_MULTIPLIER = 2
	else:
		SPEED_MULTIPLIER = 1
	#The player is in range, start attacking
	if $RaycastAttack.is_colliding() && $RaycastAttack.get_collider().is_in_group('Player'):
		is_attacking = true
	else:
		is_attacking = false
	return is_attacking


func getHealth():
	return HEALTH

func disableCollision(disabled):
	$CollisionShape2D.disabled = disabled
	$Weapon/DamageArea.disabled = disabled
	
func clearObject():
	queue_free()
