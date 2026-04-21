extends Node3D
var HUD_Prompt: String = "TST Modular Choice Prompt"

func _ready() -> void:
	SignalBus.connect("reply_popup", on_reply_popup)

func HUD_Element():
	return HUD_Prompt

func Iteraction():
	var Choice_Names = {
		"stance_text": "Stance",
		"yes_text": "Up",
		"no_text": "Down"
	}
	SignalBus.emit_signal("request_popup", Choice_Names, self)

func on_reply_popup(Choice_Answer):
	if Choice_Answer == true:
		print("Confirmed!")
	elif Choice_Answer == false:
		print("Denied!")

func Take_Damage():
	print("loutsacue")
