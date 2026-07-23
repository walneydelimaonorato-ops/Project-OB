extends Node

var localfocus: String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_rich("[color=#ffdf00]Mready Remove Item Working[/color]")
	
	get_viewport().gui_focus_changed.connect(_on_focus_changed)

func _on_focus_changed(nodefocus: Control):
	if nodefocus:
		%"Menu Move".play()
		localfocus = nodefocus.name

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed(Global.Player_Data.UnUI_Unselect):
		Remove_Item()

func Remove_Item():
	var Blank_Image: String = "res://Assets/UI/HUD/Item Icons/_Ultilities/Item_Icon_Blank.png"
	
	match localfocus:
		"Ready Inventory":
			pass
		"Ready Settings":
			pass
	
		"Ready Brace":
			if !Global.Player_Data.Inv_Brace_Equiped == "null":
				Global.Player_Data.Brace_ID[Global.Player_Data.Inv_Brace_Equiped]["equipped?"] = false
				%"Ready Brace Overlay".texture = load(Blank_Image)
				Global.Player_Data.Inv_Brace_Equiped = "null"
			else:
				%"Menu Return".play()
		"Ready Wear":
			pass
		"Ready Tool Left":
			if !Global.Player_Data.Inv_ToolL_Equiped == "null":
				Global.Player_Data.Tool_ID[Global.Player_Data.Inv_ToolL_Equiped]["equipped?"] = false
				%"Ready Tool Left Overlay".texture = load(Blank_Image)
				Global.Player_Data.Inv_ToolL_Equiped = "null"
			else:
				%"Menu Return".play()
		"Ready Tool Right":
			if !Global.Player_Data.Inv_ToolR_Equiped == "null":
				Global.Player_Data.Tool_ID[Global.Player_Data.Inv_ToolR_Equiped]["equipped?"] = false
				%"Ready Tool Right Overlay".texture = load(Blank_Image)
				Global.Player_Data.Inv_ToolR_Equiped = "null"
			else:
				%"Menu Return".play()
	
		"Ready Spell":
			pass
		"Ready UItem 1":
			if !Global.Player_Data.Inv_Uitem1_Equiped == "null":
				Global.Player_Data.UItem_ID[Global.Player_Data.Inv_Uitem1_Equiped]["equipped?"] = false
				%"Ready UItem 1 Overlay".texture = load(Blank_Image)
				Global.Player_Data.Inv_Uitem1_Equiped = "null"
			else:
				%"Menu Return".play()
		"Ready UItem 2":
			if !Global.Player_Data.Inv_Uitem2_Equiped == "null":
				Global.Player_Data.UItem_ID[Global.Player_Data.Inv_Uitem2_Equiped]["equipped?"] = false
				%"Ready UItem 2 Overlay".texture = load(Blank_Image)
				Global.Player_Data.Inv_Uitem2_Equiped = "null"
			else:
				%"Menu Return".play()
		"Ready UItem 3":
			if !Global.Player_Data.Inv_Uitem3_Equiped == "null":
				Global.Player_Data.UItem_ID[Global.Player_Data.Inv_Uitem3_Equiped]["equipped?"] = false
				%"Ready UItem 3 Overlay".texture = load(Blank_Image)
				Global.Player_Data.Inv_Uitem3_Equiped = "null"
			else:
				%"Menu Return".play()
	SignalBus.emit_signal("Tool_Rotation")
