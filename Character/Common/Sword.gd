extends Area2D

@export var player:Player
var damage = 0;

func _ready():
	monitoring = false
	

func _input(event):	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		monitoring = true
		await get_tree().create_timer(.1).timeout
		monitoring = false
		
func _on_body_entered(body):
	if body.is_in_group('Enemy'):
		damage = player.ATTACK
		body.hit(damage)
