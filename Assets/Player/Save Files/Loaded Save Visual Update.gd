extends Node

func _ready() -> void:
	BugBus.emit_signal("Report", "Player", "Loaded Save Visual Update Working")
	IntSigBus.Load_save_Visual_Update.connect(Visual_Update)

func Visual_Update():
	$"../..".position = GLOBAL.Player_Data.Player_Position
	$"../..".rotation = GLOBAL.Player_Data.Player_Rotation
	IntSigBus.emit_signal("Side_Status_Update")
	IntSigBus.emit_signal("Tool_Rotation")
	IntSigBus.emit_signal("Side_HUD_Update")
	IntSigBus.emit_signal("Ready_Menu_Overlay_Update")
	IntSigBus.emit_signal("Side_HUD_Overlay_Update")
