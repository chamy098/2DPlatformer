extends Node2D

const PickUp = preload("res://Misc/Pick_Up_Item/PickUpItem.tscn")
@onready var player: CharacterBody2D = $Knight
@onready var inventory_interface = $Hud/InventoryInterface
@onready var hot_bar_inventory = $Hud/HotBarInventory

func _ready():
	player.toggle_inventory.connect(toggle_inventory_interface)
	inventory_interface.set_player_inventory_data(player.inventory_data)
	inventory_interface.set_equip_inventory_data(player.equip_inventory_data)
	hot_bar_inventory.set_inventory_data(player.inventory_data)

func toggle_inventory_interface():
	inventory_interface.visible = not inventory_interface.visible
	if inventory_interface.visible:
		hot_bar_inventory.hide()
	else:
		hot_bar_inventory.show()


func _on_inventory_interface_drop_slot_data(slot_data):
	var pick_up = PickUp.instantiate()
	pick_up.slot_data = slot_data
	pick_up.position = player.get_drop_position()
	add_child(pick_up)
