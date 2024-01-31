extends InventoryData
class_name InventoryDataEquip
const EQUIPMENT_TYPE = preload("res://Misc/Inventory/Enums/EquipmentType.gd")
func drop_slot_data(grabbed_slot_data: SlotData,index:int)-> SlotData:
	if not grabbed_slot_data.item_data is ItemDataEquip:
		return grabbed_slot_data
	if grabbed_slot_data.item_data.type != index: # index 0 helmet, 1chest, 2weapon and so on.
		return grabbed_slot_data
	PlayerManager.equip_slot_data(grabbed_slot_data)
	return super.drop_slot_data(grabbed_slot_data,index)
	
func drop_single_slot_data(grabbed_slot_data: SlotData,index:int)-> SlotData:
	if not grabbed_slot_data.item_data is ItemDataEquip:
		return grabbed_slot_data
		
	return super.drop_single_slot_data(grabbed_slot_data,index)

#Grab equipment that's in the equipment inventory
func grab_slot_data(index:int):
	#Reduce the values before
	PlayerManager.un_equip_slot_data(slot_datas[index])	
	return super.grab_slot_data(index)
