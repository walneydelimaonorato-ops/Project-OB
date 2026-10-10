extends Node

func on_return() -> void:
	ExtSigBus.emit_signal("Viggnette", true)
	#await get_tree().create_timer(1.5).timeout
	#GLOBAL.Next_Scene = Map.List["TEST 0"]
	#get_tree().change_scene_to_packed(GLOBAL.Load_New)
