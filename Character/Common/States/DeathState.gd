extends State





func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == 'death'):
		get_tree().change_scene_to_file("res://Levels/GameOver/GameOver.tscn")



