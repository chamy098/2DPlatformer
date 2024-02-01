extends Control

@export var game_manager: GameManager

var save_path = "user://variable.save"
var var1 = "Test"
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	game_manager.connect("toggle_game_paused", _on_game_manager_toggle_game_paused)

func _on_game_manager_toggle_game_paused(is_paused:bool):
	if is_paused:
		show()
	else:
		hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_resume_pressed():
	game_manager.game_paused = false


func _on_exit_pressed():
	get_tree().quit()


func _on_save_pressed():
	var file = FileAccess.open(save_path,FileAccess.WRITE)
	file.store_var(var1)
	file.store_var("test2")


func _on_load_pressed():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path,FileAccess.READ)
		var1 = file.get_var()
		print(var1)
		
