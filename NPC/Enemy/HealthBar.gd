extends ProgressBar

class_name  EnemyHealthBar

func flip(facing_right:bool):
	if facing_right:
		fill_mode = 1
	else:
		fill_mode = 0

