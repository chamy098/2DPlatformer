extends State



func init_signals():
	animation_tree.connect("animation_finished",_on_animation_tree_animation_finished)
	
func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == 'death'):
		character.clearObject()
