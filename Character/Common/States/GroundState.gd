extends State

class_name GroundState
@export var JUMP_VELOCITY = -300.0
@export var air_state:State
@export var jump_animation: String = "jump_start"
@export var attack_state:State
@export var attack_animation: String = "attack1"
@export var hurt_animation: String = "hurt"
@export var death_state:State
@export var death_animation: String = "death"

func state_process(delta):
	if(!character.is_on_floor()):
		next_state = air_state
		
		
func state_input(event: InputEvent):
	var direction = Input.get_axis("left", "right")

	if(event.is_action_pressed("jump")):
		jump()

	if(event.is_action_pressed("attack")):
		attack()

func jump():
	character.velocity.y = JUMP_VELOCITY
	next_state = air_state
	playback.travel(jump_animation)
	
func attack():
	next_state = attack_state
	playback.travel(attack_animation)
	
func _on_knight_damage_taken(currentHealth):
	if currentHealth > 0 :
		playback.travel(hurt_animation)
	else :
		#We dead bro
		playback.travel(death_animation)
		next_state = death_state
		
		
