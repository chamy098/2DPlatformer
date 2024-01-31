extends CanvasLayer

@onready var label = $Label


func setCoins(value) -> void:
	label.text = str(value)
