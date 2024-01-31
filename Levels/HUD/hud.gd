extends CanvasLayer

@export var player: CharacterBody2D
const HUD = preload("res://Levels/HUD/Hud_enum.gd")

@onready var coin_hud = $CoinHud
@onready var player_hud = $PlayerHud

func _ready():
	player.update_hud.connect(update_HUD)
	player.player_base_stats.update_stats.connect(init_base_stats)
	init_base_stats()
	
func get_player():
	return player
	
func init_base_stats() -> void: 
	var player_stats = player.player_base_stats.get_stat()
	update_HUD(player_stats.base_health,HUD.STATUS.UPDATE_MAX_HEALTH )
	update_HUD(player_stats.base_armor,HUD.STATUS.UPDATE_MAX_ARMOR )

func update_HUD(value,stat: HUD.STATUS):
	match stat:
		HUD.STATUS.UPDATE_COIN:
			coin_hud.setCoins(value)
		HUD.STATUS.UPDATE_HEALTH:
			player_hud.setHealth(value)
		HUD.STATUS.UPDATE_ARMOR:
			player_hud.setArmor(value)
		HUD.STATUS.UPDATE_MANA:
			player_hud.setMana(value)
		HUD.STATUS.UPDATE_MAX_HEALTH:
			player_hud.setMaxHealth(value)
		HUD.STATUS.UPDATE_MAX_ARMOR:
			player_hud.setMaxArmor(value)
		HUD.STATUS.UPDATE_MAX_MANA:
			player_hud.setMaxMana(value)


