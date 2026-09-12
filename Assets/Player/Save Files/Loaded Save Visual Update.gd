extends Node

func _ready() -> void:
	print("Loaded Save Visual Update Working")
	SignalBus.Load_save_Visual_Update.connect(Visual_Update)

func Visual_Update():
	$"../..".position = Global.Player_Data.Player_Position
	$"../..".rotation = Global.Player_Data.Player_Rotation
	SignalBus.emit_signal("Side_Status_Update")
	SignalBus.emit_signal("Tool_Rotation")
	SignalBus.emit_signal("Side_HUD_Update")
	SignalBus.emit_signal("Ready_Menu_Overlay_Update")
	SignalBus.emit_signal("Side_HUD_Overlay_Update")
