extends Node3D

var HUD_Prompt: String = "Rest"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func HUD_Element():
	return HUD_Prompt
