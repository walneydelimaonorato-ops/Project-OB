extends Node

var localfocus: String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BugBus.emit_signal("Report", "Player", "Mready Remove Item Working")
	
	get_viewport().gui_focus_changed.connect(_on_focus_changed)

func _on_focus_changed(nodefocus: Control):
	if nodefocus:
		%"Menu Move".play()
		localfocus = nodefocus.name

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed(PLY_Input.UnUI_Unselect):
		Remove_Item()

func Remove_Item():
	var Blank_Image: String = "res://Assets/UI/HUD/Item Icons/_Ultilities/Item_Icon_Blank.png"
	
	match localfocus:
		"Ready Inventory":
			pass
		"Ready Settings":
			pass
	
		"Ready Brace":
			if !PLY_Inventory.Inv_Brace_Equiped == "null":
				PLY_Inventory.Brace_ID[PLY_Inventory.Inv_Brace_Equiped]["equipped?"] = false
				%"Ready Brace Overlay".texture = load(Blank_Image)
				PLY_Inventory.Inv_Brace_Equiped = "null"
			else:
				%"Menu Return".play()
		"Ready Wear":
			pass
		"Ready Tool Left":
			if !PLY_Inventory.Inv_ToolL_Equiped == "null":
				PLY_Inventory.Tool_ID[PLY_Inventory.Inv_ToolL_Equiped]["equipped?"] = false
				%"Ready Tool Left Overlay".texture = load(Blank_Image)
				PLY_Inventory.Inv_ToolL_Equiped = "null"
			else:
				%"Menu Return".play()
		"Ready Tool Right":
			if !PLY_Inventory.Inv_ToolR_Equiped == "null":
				PLY_Inventory.Tool_ID[PLY_Inventory.Inv_ToolR_Equiped]["equipped?"] = false
				%"Ready Tool Right Overlay".texture = load(Blank_Image)
				PLY_Inventory.Inv_ToolR_Equiped = "null"
			else:
				%"Menu Return".play()
	
		"Ready Spell":
			pass
		"Ready UItem 1":
			if !PLY_Inventory.Inv_Uitem1_Equiped == "null":
				PLY_Inventory.UItem_ID[PLY_Inventory.Inv_Uitem1_Equiped]["equipped?"] = false
				%"Ready UItem 1 Overlay".texture = load(Blank_Image)
				PLY_Inventory.Inv_Uitem1_Equiped = "null"
			else:
				%"Menu Return".play()
		"Ready UItem 2":
			if !PLY_Inventory.Inv_Uitem2_Equiped == "null":
				PLY_Inventory.UItem_ID[PLY_Inventory.Inv_Uitem2_Equiped]["equipped?"] = false
				%"Ready UItem 2 Overlay".texture = load(Blank_Image)
				PLY_Inventory.Inv_Uitem2_Equiped = "null"
			else:
				%"Menu Return".play()
		"Ready UItem 3":
			if !PLY_Inventory.Inv_Uitem3_Equiped == "null":
				PLY_Inventory.UItem_ID[PLY_Inventory.Inv_Uitem3_Equiped]["equipped?"] = false
				%"Ready UItem 3 Overlay".texture = load(Blank_Image)
				PLY_Inventory.Inv_Uitem3_Equiped = "null"
			else:
				%"Menu Return".play()
	IntSigBus.emit_signal("Tool_Rotation")
