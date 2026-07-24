extends Node

var Local_Storage_Param1: String
var Local_Storage_Param2: String

func _ready() -> void:
	print_rich("[color=#ffdf00]Dialogue Manager Working[/color]")
	SignalBus.NPC_Dialogue.connect(Diag_Play)

func Diag_Play(Param1: String, Param2: String):
	Local_Storage_Param1 = Param1
	Local_Storage_Param2 = Param2
	print_rich("[color=blue]", Local_Storage_Param1, " ", Local_Storage_Param2, "[/color]")
	
	%"Dialogue Menu".visible = true
	#%"Dialogue Container".self_modulate.a = lerp(%"Dialogue Container".self_modulate.a, 0, 1)
	
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
			pass
		"END":
			%"Dialogue Menu".visible = false
			return
