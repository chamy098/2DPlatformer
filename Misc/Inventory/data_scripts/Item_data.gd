extends Resource
class_name ItemData


@export var name: String = ""
@export_multiline var description: String = ""
@export var stackable: bool = false
@export var texture: AtlasTexture


func use(target) -> void:
	pass

func equip(target) -> void:
	pass
	
func un_equip(target) -> void:
	pass
