extends Node3D
var HUD_Prompt: String = "TST Modular Choice Prompt"

@export var Pop_Up_Adress: String
@export var Stance_text: String
@export var Yes_Text: String
@export var No_text: String

func _ready() -> void:
	SignalBus.connect("reply_popup", on_reply_popup)

func HUD_Element():
	return HUD_Prompt

func Iteraction():
	var Choice_Names = {
		"stance_text": Stance_text,
		"yes_text": Yes_Text,
		"no_text": No_text
	}
	SignalBus.emit_signal("request_popup", Choice_Names, Pop_Up_Adress)

func on_reply_popup(Choice_Answer, Address_To):
	if Address_To == Pop_Up_Adress:
		if Choice_Answer == Yes_Text:
			print("Confirmed!")
		elif Choice_Answer == No_text:
			print("Denied!")
	else:
		pass
		#print("ERROR: on_reply_popup no matching Address_To")

func Take_Damage():
	pass
	#print("loutsacue")
