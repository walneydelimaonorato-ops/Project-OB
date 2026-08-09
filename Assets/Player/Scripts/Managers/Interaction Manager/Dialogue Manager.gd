extends Node

var Local_Storage_Param1: String
var Local_Storage_Param2: String
var Local_Storage_Address: String

func _ready() -> void:
	print_rich("[color=#ffdf00]Dialogue Manager Working[/color]")
	SignalBus.NPC_Dialogue.connect(Diag_Play)
	SignalBus.Interaction_Prompt_Manager_Response.connect(Proceed_SPLIT)

func Diag_Play(Param1: String, Param2: String):
	Local_Storage_Param1 = Param1
	Local_Storage_Param2 = Param2
	
	print_rich("[color=blue]", Local_Storage_Param1, " ", Local_Storage_Param2, "[/color]")
	
	%"Dialogue Menu".visible = true
	
	%"Current Book".text = Global.Dialogue.Library[Param1][Param2]["LINE"]
	%"Current Voice".stream = load(Global.Dialogue.Library[Param1][Param2]["VOICE"])
	%"Current Voice".playing = true

func _current_voice_finished() -> void:
	Proceed_Sytem()

func Proceed_Sytem():
	match Global.Dialogue.Library[Local_Storage_Param1][Local_Storage_Param2]["PROCEED"]:
		"NEXT":
			SignalBus.emit_signal("Interaction_Manager_Request", "Dialogue", "", "NPC_TEST_INTRODUCTION", Global.Dialogue.Library[Local_Storage_Param1][Local_Storage_Param2]["NEXT"])
		"SPLIT":
			Local_Storage_Address = Global.Dialogue.Library[Local_Storage_Param1][Local_Storage_Param2]["ADDRESS"]
			SignalBus.emit_signal("Interaction_Prompt_Manager", Local_Storage_Address, Global.Dialogue.Library[Local_Storage_Param1][Local_Storage_Param2]["CHOICE NAME"], Global.Dialogue.Library[Local_Storage_Param1][Local_Storage_Param2]["CONFIRM"], Global.Dialogue.Library[Local_Storage_Param1][Local_Storage_Param2]["DENY"])
			%"Dialogue Menu".visible = false
		"END":
			%"Dialogue Menu".visible = false
			return

func Proceed_SPLIT(Address: String, Response: bool):
	if Address == Local_Storage_Address:
		if Response == true:
			SignalBus.emit_signal("Interaction_Manager_Request", "Dialogue", "", Local_Storage_Address, Global.Dialogue.Library[Local_Storage_Param1][Local_Storage_Param2]["PASS A"])
		elif Response == false:
			SignalBus.emit_signal("Interaction_Manager_Request", "Dialogue", "", Local_Storage_Address, Global.Dialogue.Library[Local_Storage_Param1][Local_Storage_Param2]["PASS B"])
