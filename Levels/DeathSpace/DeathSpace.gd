extends Area2D



func _on_body_entered(body):
	#We dead bro
	if body.is_in_group('Player'):
		get_tree().change_scene_to_file("res://Levels/GameOver/GameOver.tscn")
