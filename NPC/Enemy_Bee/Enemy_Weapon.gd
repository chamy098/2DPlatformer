extends Area2D

@export var DAMAGE = 50;

@onready var timer: Timer = $AttackTimer

var player_body: CharacterBody2D

func _ready():
	self.connect("body_entered",_on_body_entered)
	self.connect("body_exited",_on_body_exited)
	timer.connect("timeout",_on_attack_timer_timeout)

func _on_body_entered(body):
	if body.is_in_group('Player') && player_body == null:
		timer.start()
		player_body = body
		player_body.hit(DAMAGE)
		

func _on_body_exited(body):
	if body.is_in_group('Player'):
		timer.stop()
		player_body = null
	
func _on_attack_timer_timeout():
	if player_body != null:
		player_body.hit(DAMAGE)
