extends Node2D

var player_near: bool = false
var opened: bool = false

const MIN_X =  10.0
const MAX_X = 150.0
const MIN_Y = -80.0
const MAX_Y =  80.0

var COIN_SCENE = preload("res://Misc/Coin/Coin.tscn")
		

func _input(event):
	if event.is_action_pressed("attack") and player_near and not opened:
		opened = true
		$AnimatedSprite2D.play("open")
		drop_items()
	

func drop_items():
	var coins = []
	
	for i in range(5):
		coins.append(COIN_SCENE.instantiate())
		add_child(coins[i])
	
	
	
	for coin in coins:
		var tween = create_tween()
		var direction = 1 if randi() % 2 == 0 else -1
		var randomX = randf_range(-100, 100);
		var goal = coin.position + Vector2(randf_range(MIN_X, MAX_X), randf_range(MIN_Y, MAX_Y)) * direction	
		
		tween.tween_property(coin, "scale", Vector2(2,2), 0)
		tween.tween_property(coin,"position", Vector2(randomX,-30),0.2).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)

		tween.tween_property(coin,"position", Vector2(randomX,-1),.3).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(coin,"position", Vector2(randomX,0),.3).set_trans(Tween.TRANS_BOUNCE)

		
	
func _on_body_entered(body):
	if body.is_in_group('Player'):
		player_near = true 


func _on_body_exited(body):
	player_near = false
