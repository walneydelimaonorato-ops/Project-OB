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
	SignalBus.emit_signal("request_popup", Choice_Names, "Test box")

func on_reply_popup(Choice_Answer, Address_To):
	if Address_To == "Test box":
		if Choice_Answer == "Up":
			print("Confirmed!")
		elif Choice_Answer == "Down":
			print("Denied!")
	else:
		pass
		#print("ERROR: on_reply_popup no matching Address_To")

func Take_Damage():
	print("loutsacue")
