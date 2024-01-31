extends CharacterBody2D

class_name Player2
signal update_hud(value)
signal facing_direction_changed(facing_right:bool)
#Movement
const SPEED = 200.0
var HEALTH = 100.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_attacking: bool = false
var wallet = 0

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine = $CharacterStateMachine
func _ready():
	animation_tree.active = true
	$HealthBar.value = HEALTH
		
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	animation_tree.set("parameters/move/blend_position", direction)
	if direction != 0  && state_machine.check_if_can_move(): #&& is_attacking == false
		velocity.x = direction * SPEED
		#Flip character depending on the direction they're running
		sprite.flip_h = velocity.x < 0
		emit_signal("facing_direction_changed", !sprite.flip_h)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	
func _input(event):	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		attack()
				
				
func attack():
	is_attacking = true
	#$AnimatedSprite2D.animation = "attack"
	
func addCoin(value):
	wallet += value
	emit_signal("update_hud", wallet)

func hit(value):
	HEALTH -= value
	$HealthBar.value = HEALTH
	#showHitLabel(value)
