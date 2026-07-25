extends Node

func _ready() -> void:
	print_rich("[color=#ffdf00]Interaction Manager Working[/color]")
	SignalBus.Interaction_Manager_Request.connect(Interaction_Sorter)
	SignalBus.Interaction_Prompt_Manager.connect(Interaction_Prompt_Manager)

func Interaction_Sorter(Interaction: String, Address: String, Param1: String, Param2: String):
	match Interaction:
		"Dialogue":
			SignalBus.emit_signal("NPC_Dialogue", Param1, Param2)
		"Object":
			pass
		"Item":
			pass

func Interaction_Prompt_Manager():
	pass
