extends Node

var player

func use_slot_data(slot_data: SlotData)-> void:
	slot_data.item_data.use(player)

func equip_slot_data(slot_data: SlotData)-> void:
	slot_data.item_data.equip(player)
	
func un_equip_slot_data(slot_data: SlotData)-> void:
	slot_data.item_data.un_equip(player)
