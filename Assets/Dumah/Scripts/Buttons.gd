extends Node

func _process(delta: float) -> void:
	Inputs()

func Inputs():
	if Input.is_action_just_pressed(PLY_Input.Un_Tool_Alternive):
		print("ass")
