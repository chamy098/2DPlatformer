extends CollisionShape2D


func _on_player_facing_direction_changed(facing_right:bool):
	if facing_right:
		position.x = 25
	else:
		position.x = -25
