extends ItemData
class_name ItemDataEquip

const StatTypeEnum = preload("res://Character/Common/StatTypeEnum.gd")
const EQUIPMENT_TYPE = preload("res://Misc/Inventory/Enums/EquipmentType.gd")
@export var health:int = 0
@export var armor:int = 0
@export var attack:int = 0
@export var magic:int = 0
@export var movement_speed:int = 0
@export var type:EQUIPMENT_TYPE.EQUIPMENT_TYPE


func equip(target) -> void:
	if health != 0:
		target.player_base_stats.increase_base_stat(health,StatTypeEnum.STAT.HEALTH)
	if armor != 0:
		target.player_base_stats.increase_base_stat(armor,StatTypeEnum.STAT.ARMOR)
	if attack != 0:
		target.player_base_stats.increase_base_stat(attack,StatTypeEnum.STAT.ATTACK)
	if magic != 0:
		target.player_base_stats.increase_base_stat(magic,StatTypeEnum.STAT.MAGIC)
	if movement_speed != 0:
		target.player_base_stats.increase_base_stat(movement_speed,StatTypeEnum.STAT.MOVEMENT_SPEED)

func un_equip(target) -> void:
	if health != 0:
		target.player_base_stats.decrease_base_stat(health,StatTypeEnum.STAT.HEALTH)
	if armor != 0:
		target.player_base_stats.decrease_base_stat(armor,StatTypeEnum.STAT.ARMOR)
	if attack != 0:
		target.player_base_stats.decrease_base_stat(attack,StatTypeEnum.STAT.ATTACK)
	if magic != 0:
		target.player_base_stats.decrease_base_stat(magic,StatTypeEnum.STAT.MAGIC)
	if movement_speed != 0:
		target.player_base_stats.decrease_base_stat(movement_speed,StatTypeEnum.STAT.MOVEMENT_SPEED)
