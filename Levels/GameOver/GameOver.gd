extends Control


func _ready():
	GameManager.connect("game_over", _on_game_manager_game_over)
	hide()


func _on_retry_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_game_manager_game_over():
	get_tree().paused = true
	show()

