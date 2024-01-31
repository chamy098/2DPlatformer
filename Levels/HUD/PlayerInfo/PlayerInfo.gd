extends PanelContainer

@export var character: CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var timer = $AnimatedSprite2D/Timer
@onready var health_label = $TextureRect/HealthLabel
@onready var attack_label = $TextureRect/AttackLabel
@onready var magic_label = $TextureRect/MagicLabel
@onready var speed_label = $TextureRect/SpeedLabel
@onready var shield_label = $TextureRect/ShieldLabel
const Hud = preload("res://Levels/HUD/hud.gd")
var animation_playing = false

func _ready():
	timer.start()
	update_stats()
	character.player_base_stats.update_stats.connect(update_stats)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer.is_stopped() && !animation_playing:
		animation_playing = true
		animated_sprite_2d.play("idle")
		


func _on_animated_sprite_2d_animation_finished():
	timer.start()
	animation_playing = false
	

func update_stats():
	var player_stats = character.player_base_stats.get_stat()
	health_label.text = str(player_stats.base_health)
	shield_label.text = str(player_stats.base_armor)
	attack_label.text = str(player_stats.base_attack)
	magic_label.text = str(player_stats.base_magic)
	speed_label.text = str(player_stats.base_movement_speed)
