extends State

class_name Enemy_Attack_State

@export var walk_state:State
@export var walk_animation: String = "move"

func state_process(delta):
	if(!character.enemyDetected()):
		walk()

func walk():
	next_state = walk_state
	playback.travel(walk_animation)


	

