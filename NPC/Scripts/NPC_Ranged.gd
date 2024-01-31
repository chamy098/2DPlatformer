extends CharacterBody2D
var HitLabel = preload("res://Levels/HUD/Hit_Label/HitLabel.tscn")
@export var HEALTH = 100
@export var SPEED = -50
@export var FIRE_RATE = 1
@export var projectile_frames: SpriteFrames

signal damage_taken(currentHealth)

var current_speed = SPEED
var facing_right = true
var is_attacking = false

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var fire_rate = $FireRate
@onready var projectile = preload("res://Misc/Projectile/Projectile.tscn")
@onready var shoot_position = $ShootPosition

# Called when the node enters the scene tree for the first time.
func _ready():
	$EnemyHealthBar.value = HEALTH
	fire_rate.wait_time = FIRE_RATE
	fire_rate.connect("timeout",_on_fire_rate_timeout)


func _physics_process(delta):
	if(HEALTH > 0 && !is_attacking):
		if !$RaycastDown.is_colliding() && !is_attacking: #This looks on Y axis
			flip()	
		if $RaycastFoward.is_colliding() && !$RaycastFoward.get_collider().is_in_group('Player') && !is_attacking: #This looks on X axis
			flip()
		velocity.x = current_speed
		move_and_slide()
	elif is_attacking:
		velocity.x = 0
		
	
	

func flip():
	facing_right = !facing_right
	scale.x = abs(scale.x) *  -1
	$EnemyHealthBar.flip(facing_right)
	if facing_right:
		current_speed = abs(SPEED)
	else:
		current_speed = abs(SPEED) * -1

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
	#The player is in range, start attacking
	if $RaycastAttack.is_colliding() && $RaycastAttack.get_collider().is_in_group('Player'):
		is_attacking = true
		if(fire_rate.is_stopped()):
			shot()
			fire_rate.start()
	else:
		is_attacking = false
		fire_rate.stop()
	return is_attacking


func shot():
	var k = projectile.instantiate()
	k.set_projectile(projectile_frames)
	k.set_explode_time(0.9)
	k.flip(facing_right)
	k.position = shoot_position.global_position
	get_parent().add_child(k)

func getHealth():
	return HEALTH

func disableCollision(disabled):
	$CollisionShape2D.disabled = disabled
	
func clearObject():
	queue_free()


func _on_fire_rate_timeout():
	shot()
