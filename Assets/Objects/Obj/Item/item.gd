extends Node3D
var HUD_Prompt: String = "Pickup"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func HUD_Element():
	return HUD_Prompt

func Iteraction():
	%AudioStreamPlayer2D.play()
