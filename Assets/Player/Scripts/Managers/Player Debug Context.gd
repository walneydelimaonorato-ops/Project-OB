extends Node

func _ready() -> void:
	pass # Replace with function body.



func health_button_pressed() -> void:
	var Health_Edit: int = 00
	Health_Edit = int(%"Health Edit".text)
	
	if Health_Edit < 0:
		Global.Player_Data.Health -= Health_Edit
	elif Health_Edit > 0:
		Global.Player_Data.Health += Health_Edit
	else:
		pass
