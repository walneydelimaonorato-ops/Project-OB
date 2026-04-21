extends Node

signal request_popup(Choice_Names, source)
signal reply_popup(Choice_Answer)
signal request_dialogue()

signal request_damage(Damage_Number)

func _ready() -> void:
	print("Signal Bus working")
