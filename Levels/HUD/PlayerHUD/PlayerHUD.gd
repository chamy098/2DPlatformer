extends PanelContainer

@onready var health_bar = $HBoxContainer/Health/ProgressBar
@onready var mana_bar = $HBoxContainer/Mana/ProgressBar
@onready var mana_label = $HBoxContainer/Mana/ProgressBar/Label
@onready var health_label = $HBoxContainer/Health/ProgressBar/Label
@onready var armor_bar = $HBoxContainer/Armor/ProgressBar
@onready var armor_label = $HBoxContainer/Armor/ProgressBar/Label

@onready var mana_timer = $HBoxContainer/Mana/ProgressBar/Timer

func _ready():
	mana_timer.connect("timeout",restore_mana)
	mana_timer.start()
	
func setHealth(value) -> void:
	health_bar.value = value
	health_label.text = str(value)+ "/" +str(health_bar.max_value)

func setArmor(value) -> void:
	armor_bar.value = value
	armor_label.text = str(value)+ "/" +str(armor_bar.max_value)
	
func setMana(value) -> void:
	mana_bar.value = value
	mana_label.text = str(value)+ "/" +str(mana_bar.max_value)


func setMaxHealth(value) ->void:
	health_bar.max_value = value
	var parts = health_label.text.split("/")
	health_label.text = parts[0]+ "/" +str(value)

func setMaxArmor(value) ->void:
	armor_bar.max_value = value
	var parts = armor_label.text.split("/")
	armor_label.text = parts[0]+ "/" +str(value)
	
func setMaxMana(value) ->void:
	mana_bar.max_value = value
	
func restore_mana():
	if mana_bar.value < mana_bar.max_value:
		mana_bar.value += 1
		mana_label.text = str(mana_bar.value)+ "/" +str(mana_bar.max_value)
	
