extends State

class_name Enemy_Walk_State

@export var attack_state:State
@export var attack_animation: String = "attack"
@export var hurt_state:State
@export var hurt_animation: String = "hurt"
@export var dead_state:State
@export var death_animation: String = "death"

func init_signals():
	character.connect("damage_taken",_on_damage_taken)
	
func state_process(delta):
	if(character.enemyDetected()):
		attack()
					
func attack():
	next_state = attack_state
	playback.travel(attack_animation)


func _on_damage_taken(currentHealth):
	if currentHealth > 0:
		next_state = hurt_state
		playback.travel(hurt_animation)
	else:
		next_state = dead_state
		playback.travel(death_animation)

