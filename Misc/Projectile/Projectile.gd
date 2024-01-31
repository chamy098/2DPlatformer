extends Node2D

class_name Projectile
var SPEED = -100.0
const TTL = 1.1 #TTL is 3 sec
var explode_time = 0.3

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var hit_box = $HitBox
@onready var timer = $Timer

var sprite_frames:SpriteFrames

func _ready():
	animated_sprite_2d.sprite_frames = sprite_frames
	set_as_top_level(true)
	animated_sprite_2d.play("fly")
	timer.connect("timeout",explode)
	timer.start(TTL)

func set_projectile(frames:SpriteFrames):
	sprite_frames = frames

func set_explode_time(time:float):
	explode_time = time
	
func flip(is_right:bool):
	
	if is_right:
		SPEED = abs(SPEED)
		scale.x = abs(scale.x)  *  -1
	else:
		SPEED = abs(SPEED) * -1
		scale.x = abs(scale.x)

func _physics_process(delta):
	position.x += SPEED * delta


func _on_hit_box_body_entered(body):
	animated_sprite_2d.play("explode")
	await get_tree().create_timer(.3).timeout
	if body.is_in_group('Player'):
		body.hit(10)
	queue_free()

func explode():
	animated_sprite_2d.play("explode")
	await get_tree().create_timer(explode_time).timeout
	queue_free()
