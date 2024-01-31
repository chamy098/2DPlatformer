extends State
class_name Enemy_Hurt_State

@export var walk_state:State
@export var walk_animation: String = "move"
@export var attack_state:State
@export var attack_animation: String = "attack"
@export var dead_state:State
@export var death_animation: String = "death"

func init_signals():
	animation_tree.connect("animation_finished",_on_animation_tree_animation_finished)
	
func _on_animation_tree_animation_finished(anim_name):
	if anim_name == 'hurt':
		if(character.getHealth() <= 0):
			dead()
		elif(character.enemyDetected()): 
			attack()
		else:
			walk()	
		
func walk():
	next_state = walk_state
	playback.travel(walk_animation)

func attack():
	next_state = attack_state
	playback.travel(attack_animation)
	
func dead():
	next_state = dead_state
	playback.travel(death_animation)
	character.disableCollision(true)

	




