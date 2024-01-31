extends Area2D

@export var HEALTH_VALUE = 15
@export var slot_data = SlotData
@onready var sprite_2d = $Sprite2D


func _ready():
	sprite_2d.texture = slot_data.item_data.texture

func _physics_process(delta):
	sprite_2d.rotate(delta)
	
func _on_body_entered(body):
	if body.is_in_group('Player'):
		if body.inventory_data.pick_up_slot_data(slot_data):
			var tween = create_tween()
			tween.tween_property(self,"position", position + Vector2(0,-30),0.5)
			tween.tween_property(self,"modulate:a", 0.0,0.5)
			tween.tween_callback(self.queue_free)
