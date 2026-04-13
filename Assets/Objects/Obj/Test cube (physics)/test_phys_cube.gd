extends Node3D
var HUD_Prompt: String = "TST Modular Choice Prompt"
@onready var player: CharacterBody3D = $"../Player"


func _ready() -> void:
	pass # Replace with function body.

func HUD_Element():
	return HUD_Prompt

func Iteraction():
	print(player)
