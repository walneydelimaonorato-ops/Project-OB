extends Node3D
var HUD_Prompt: String = "Rest"

func _ready() -> void:
	pass # Replace with function body.

func HUD_Element():
	return HUD_Prompt

func Interact():
	if Global.Player_Data.Player_Perms.Can_Rest == true:
		SignalBus.emit_signal("Menu_Setting", "Rest")
		%AudioStreamPlayer2D.play()
		PlayerSaveManager.Write_Save()
		Global.Player_Data.Current_Camera = %"Rest Camera"
		Global.Player_Data.Current_Camera.make_current()
	else:
		pass
