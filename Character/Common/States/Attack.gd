extends State

@export var return_state: State
@export var return_animation_node: String = "move"



func _on_animation_tree_animation_finished(anim_name):
	next_state = return_state
	playback.travel(return_animation_node)



