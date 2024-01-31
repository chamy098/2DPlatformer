extends ItemData
class_name ItemDataConsumable

@export var heal_value: int
@export var increase_movement: float = 0.0
@export var duration:float = 0.0

func use(target) -> void:
	if heal_value != 0:
		target.heal(heal_value)
	if increase_movement != 0:
		target.increase_movement_speed(increase_movement, duration)
