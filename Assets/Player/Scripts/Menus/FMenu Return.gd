extends Node


func _ready() -> void:
	BugBus.emit_signal("Report", "Player", "FMenu Return Working")
	
	SignalBus.FMenu_Return.connect(Menu_Exit)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		Menu_Exit(PLY_Flags.Menus["Current Menu"])

func Menu_Exit(Return_Path: String):
	%"Menu Return".play()
	SignalBus.emit_signal("Tool_Rotation")
	SignalBus.emit_signal("Side_HUD_Update")
	SignalBus.emit_signal("Menu_Setting", Return_Path)
