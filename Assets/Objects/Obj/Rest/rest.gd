extends Node3D
var HUD_Prompt: String = "Rest"

func _ready() -> void:
	pass # Replace with function body.

func HUD_Element():
	return HUD_Prompt

func Interact():
	%AudioStreamPlayer2D.play()
	PlayerSaveManager.Write_Save()

func Take_Damage():
	print("buttlivk")
