extends Resource
class_name PlayerStats

signal update_stats
const StatTypeEnum = preload("res://Character/Common/StatTypeEnum.gd")
@export var base_health: int
@export var base_armor: int
@export var base_attack: int
@export var base_magic: int
@export var base_movement_speed: int
 
func increase_base_stat(value:int, stat:StatTypeEnum.STAT):
	match stat:
		StatTypeEnum.STAT.HEALTH:
			base_health += value
			print("Increased health by", value)
		StatTypeEnum.STAT.ARMOR:
			base_armor += value
			print("Increased armor by", value)
		StatTypeEnum.STAT.ATTACK:
			base_attack += value
			print("Increased attack by", value)
		StatTypeEnum.STAT.MAGIC:
			base_magic += value
			print("Increased magic by", value)
		StatTypeEnum.STAT.MOVEMENT_SPEED:
			base_movement_speed += value
			print("Increased movement speed by", value)
	update_stats.emit()

func decrease_base_stat(value:int, stat:StatTypeEnum.STAT):
	match stat:
		StatTypeEnum.STAT.HEALTH:
			base_health -= value
			print("Decreased health by", value)
		StatTypeEnum.STAT.ARMOR:
			base_armor -= value
			print("Decreased armor by", value)
		StatTypeEnum.STAT.ATTACK:
			base_attack -= value
			print("Decreased attack by", value)
		StatTypeEnum.STAT.MAGIC:
			base_magic -= value
			print("Decreased magic by", value)
		StatTypeEnum.STAT.MOVEMENT_SPEED:
			base_movement_speed -= value
			print("Decreased movement speed by", value)
	update_stats.emit()
	
func get_stat() -> PlayerStats:
	return self
