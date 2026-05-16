extends Area3D

var New_Map: String

@export_enum("Train Station") var Selected_Map: String

func _ready() -> void:
	match Selected_Map:
		"Train Station":
			New_Map = "uid://c47b70iv613lg"


func area_entered(area: Area3D) -> void:
	Global.Next_Scene = New_Map
	get_tree().change_scene_to_packed(Global.Load_New)
