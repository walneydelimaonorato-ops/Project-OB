extends Node

func _ready() -> void:
	BugBus.emit_signal("Report", "Player", "Interaction Manager Working")
	IntSigBus.Interaction_Manager_Request.connect(Interaction_Sorter)
	IntSigBus.Interaction_Prompt_Manager.connect(Interaction_Prompt_Manager)

func Interaction_Sorter(Interaction: String, Address: String, Param1: String, Param2: String):
	match Interaction:
		"Dialogue":
			IntSigBus.emit_signal("NPC_Dialogue", Param1, Param2)
		"Object":
			IntSigBus.emit_signal("Object_Interaction", Param1, Param2)
		"Item":
			pass

func Interaction_Prompt_Manager():
	pass
