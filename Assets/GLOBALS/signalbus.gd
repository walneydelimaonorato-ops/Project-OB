extends Node

@warning_ignore("unused_signal")
signal request_popup(Choice_Names, source)
@warning_ignore("unused_signal")
signal reply_popup(Choice_Answer)

@warning_ignore("unused_signal")
signal request_dialogue()

func _ready() -> void:
	print("Signal Bus working")
