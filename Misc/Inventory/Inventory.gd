extends PanelContainer

const Slot = preload("res://Misc/Inventory/slot/Slot.tscn")

@onready var item_grid:GridContainer = $MarginContainer/ItemGrid
@onready var sprite_2d = $Sprite2D

@export var background_texture: Texture2D

func _ready():
	sprite_2d.texture = background_texture
	

func set_inventory_data(inventory_data: InventoryData):
	inventory_data.inventory_updated.connect(populate_item_grid)
	populate_item_grid(inventory_data)
	
func populate_item_grid(inventory_data: InventoryData) -> void:
	for child in item_grid.get_children():
		child.queue_free()
	
	for slot_data in inventory_data.slot_datas:
		var slot = Slot.instantiate()
		item_grid.add_child(slot)
		slot.slot_clicked.connect(inventory_data.on_slot_clicked)

		if slot_data:
			slot.set_slot_data(slot_data)
