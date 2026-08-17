extends Node
var HUD_Prompt: String = "Hear"

func HUD_Element():
	return HUD_Prompt

func Interact():
	SignalBus.emit_signal("Interaction_Manager_Request", "Dialogue", "", "NPC_TEST_INTRODUCTION", "BOOK1")
