extends Node
@onready var PlayerRes: Node = $"../../../../Script Nodes/Player Stats"
@onready var StatsMan: Node = $"../../../../Script Nodes/Stats Management"

var buttfocus: String = ""

func _ready() -> void:
	%"Ready Menu".visible = false
	%"Selection Menu".visible = false
	Global.Player_Data.Ready_Menu_Toggled.connect(set_Ready_Menu)
	Global.Player_Data.Menus_Visual_Update.connect(Ready_Menu_Visual_Update)
	get_viewport().gui_focus_changed.connect(_on_focus_changed)

#region Functions
func set_Ready_Menu(active: bool):
	%"Ready Menu".visible = active
	if active:
		focus_first_visible($"../Ready Menu/Ready Menu Grid/Ready Technical")
		StatsMan.Set_Menu(true, "Ready")
		%"Menu Advance".play()
	elif !active:
		StatsMan.Set_Menu(true, "none")
		%"Menu Return".play()

func focus_first_visible(container):
	for child in container.get_children():
		if child is Control:
			if child.visible and child.focus_mode != Control.FOCUS_NONE:
				child.grab_focus()
				return
			focus_first_visible(child)

func _on_focus_changed(nodefocus: Control):
	if nodefocus:
		%"Menu Move".play()
		buttfocus = nodefocus.name

func Remove_Item():
	var Blank_Image: String = "res://Assets/UI/HUD/Item Icons/_Ultilities/Item_Icon_Blank.png"
	
	match buttfocus:
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
	Global.Player_Data.emit_signal("Tool_and_HUD_Rotation")

func Ready_Menu_Visual_Update(Menu_Slot, Item_Texture):
	match Menu_Slot:
		"Ready Inventory":
			pass
		"Ready Settings":
			pass
	
		"Ready Brace":
			%"Ready Brace Overlay".texture = load(Item_Texture)
		"Ready Wear":
			%"Ready Wear Overlay".texture = load(Item_Texture)
		"Ready Tool Left":
			%"Ready Tool Left Overlay".texture = load(Item_Texture)
		"Ready Tool Right":
			%"Ready Tool Right Overlay".texture = load(Item_Texture)
	
		"Ready Spell":
			%"Ready Spell Overlay".texture = load(Item_Texture)
		"Ready UItem 1":
			%"Ready UItem 1 Overlay".texture = load(Item_Texture)
		"Ready UItem 2":
			%"Ready UItem 2 Overlay".texture = load(Item_Texture)
		"Ready UItem 3":
			%"Ready UItem 3 Overlay".texture = load(Item_Texture)
		_:
			print("MANUAL ERROR: <Ready_Menu_Visual_Update> Argument out of scope")

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed(Global.Player_Data.UnUI_Unselect):
		Remove_Item()
#endregion

#region Technical
func ready_inventory_pressed() -> void:
	pass

func ready_settings_pressed() -> void:
	pass # Replace with function body.
#endregion

#region Wear and Tool
func ready_brace_pressed() -> void:
	if Global.Player_Data.Inv_Brace_Equiped == "null":
		StatsMan.Set_Menu(false, "Brace menu")
		Global.Player_Data.Seletion_Menu_Active = !Global.Player_Data.Seletion_Menu_Active
		Global.Player_Data.emit_signal("Seletion_Menu_Toggled", Global.Player_Data.Seletion_Menu_Active)
	else:
		%"Menu Return".play()

func ready_wear_pressed() -> void:
	if Global.Player_Data.Inv_Wear_Equiped == "null":
		StatsMan.Set_Menu(false, "Wear menu")
		Global.Player_Data.Seletion_Menu_Active = !Global.Player_Data.Seletion_Menu_Active
		Global.Player_Data.emit_signal("Seletion_Menu_Toggled", Global.Player_Data.Seletion_Menu_Active)
	else:
		%"Menu Return".play()
func ready_tool_left_pressed() -> void:
	if Global.Player_Data.Inv_ToolL_Equiped == "null":
		StatsMan.Set_Menu(false, "Tool Left menu")
		Global.Player_Data.Seletion_Menu_Active = !Global.Player_Data.Seletion_Menu_Active
		Global.Player_Data.emit_signal("Seletion_Menu_Toggled", Global.Player_Data.Seletion_Menu_Active)
	else:
		%"Menu Return".play()

func ready_tool_right_pressed() -> void:
	if Global.Player_Data.Inv_ToolR_Equiped == "null":
		StatsMan.Set_Menu(false, "Tool Right menu")
		Global.Player_Data.Seletion_Menu_Active = !Global.Player_Data.Seletion_Menu_Active
		Global.Player_Data.emit_signal("Seletion_Menu_Toggled", Global.Player_Data.Seletion_Menu_Active)
	else:
		%"Menu Return".play()
#endregion

#region Spell and UItem
func ready_spell_pressed() -> void:
	StatsMan.Set_Menu(false, "Spell menu")
	Global.Player_Data.Seletion_Menu_Active = !Global.Player_Data.Seletion_Menu_Active
	Global.Player_Data.emit_signal("Seletion_Menu_Toggled", Global.Player_Data.Seletion_Menu_Active)

func ready_u_item_1_pressed() -> void:
	StatsMan.Set_Menu(false, "UItem1 menu")
	Global.Player_Data.Seletion_Menu_Active = !Global.Player_Data.Seletion_Menu_Active
	Global.Player_Data.emit_signal("Seletion_Menu_Toggled", Global.Player_Data.Seletion_Menu_Active)

func ready_u_item_2_pressed() -> void:
	StatsMan.Set_Menu(false, "UItem2 menu")
	Global.Player_Data.Seletion_Menu_Active = !Global.Player_Data.Seletion_Menu_Active
	Global.Player_Data.emit_signal("Seletion_Menu_Toggled", Global.Player_Data.Seletion_Menu_Active)

func ready_u_item_3_pressed() -> void:
	StatsMan.Set_Menu(false, "UItem3 menu")
	Global.Player_Data.Seletion_Menu_Active = !Global.Player_Data.Seletion_Menu_Active
	Global.Player_Data.emit_signal("Seletion_Menu_Toggled", Global.Player_Data.Seletion_Menu_Active)
#endregion
