extends CharacterBody2D

class_name Damageable
var health = 100

var walkRange = 300
var speed = -20
var facing_right = false
var walking = true
var snail_hidden = false

var HitLabel = preload("res://Levels/HUD/Hit_Label/HitLabel.tscn")

signal direction_changed
# Called when the node enters the scene tree for the first time.
func _ready():
	$HealthBar.value = health


func _physics_process(delta):
	if walking == true:
		if !$RayCast2D.is_colliding() && is_on_floor(): #This looks on Y axis
			flip()	
		if $RayCast2D2.is_colliding() && is_on_floor(): #This looks on X axis
			flip()
		velocity.x = speed
		$AnimatedSprite2D.play("walk")
		move_and_slide()
	

func flip():
	facing_right = !facing_right
	scale.x = abs(scale.x) *  -1
	$HealthBar.flip(facing_right)
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1


func _on_hidden_timer_timeout():
	$AnimatedSprite2D.play("show")
	await get_tree().create_timer(1).timeout
	snail_hidden = false
	walking = true


func hit(value):
	health -= value
	$HealthBar.value = health
	showHitLabel(value)
	if health <= 0:
		$AnimatedSprite2D.play("dead")
		await get_tree().create_timer(.5).timeout
		queue_free()
	if snail_hidden == false:
		walking = false
		$AnimatedSprite2D.play("hide")
		snail_hidden = true
		$HiddenTimer.start()
	else:
		$HiddenTimer.start() #Restart timer

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
	
