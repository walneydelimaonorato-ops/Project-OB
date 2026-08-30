extends Node

func _ready() -> void:
	print("Save loaded Vis Update Working")
	SignalBus.Load_save_Visual_Update.connect(Visual_Update)

func Visual_Update():
	SignalBus.emit_signal("Side_Status_Update")
