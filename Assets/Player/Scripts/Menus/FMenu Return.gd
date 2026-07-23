extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_rich("[color=#ffdf00]FMenu Return Working[/color]")
	
	SignalBus.FMenu_Return.connect(Menu_Exit)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		Menu_Exit(Global.Player_Data.Current_Menu)

func Menu_Exit(Return_Path: String):
	%"Menu Return".play()
	SignalBus.emit_signal("Tool_Rotation")
	SignalBus.emit_signal("Side_HUD_Update")
	SignalBus.emit_signal("Menu_Setting", Return_Path)
