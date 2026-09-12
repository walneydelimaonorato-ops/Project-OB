extends Node3D
var HUD_Prompt: String = "Interact"

func _ready() -> void:
	pass

func HUD_Element():
	return HUD_Prompt

func Interact():
	SignalBus.emit_signal("Menu_Setting", "Keys")
