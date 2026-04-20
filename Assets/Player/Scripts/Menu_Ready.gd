extends Node
@onready var PlayerRes: Node = $"../../../../Script Nodes/Player Stats"
@onready var StatsMan: Node = $"../../../../Script Nodes/Stats Management"

var buttfocus: String = ""

func _ready() -> void:
	PlayerRes.data.Ready_Menu_Toggled.connect(set_Ready_Menu)
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
	match buttfocus:
		"Ready Inventory":
			pass
		"Ready Settings":
			pass
	
		"Ready Brace":
			pass
		"Ready Wear":
			pass
		"Ready Tool Left":
			if !PlayerRes.data.Inv_ToolL_Equiped == "null":
				PlayerRes.data.Tool_ID[PlayerRes.data.Inv_ToolL_Equiped]["equipped?"] = false
				PlayerRes.data.Inv_ToolL_Equiped = "null"
			else:
				%"Menu Return".play()
		"Ready Tool Right":
			if !PlayerRes.data.Inv_ToolR_Equiped == "null":
				PlayerRes.data.Tool_ID[PlayerRes.data.Inv_ToolR_Equiped]["equipped?"] = false
				PlayerRes.data.Inv_ToolR_Equiped = "null"
			else:
				%"Menu Return".play()
	
		"Ready Spell":
			pass
		"Ready UItem 1":
			pass
		"Ready UItem 2":
			pass
		"Ready UItem 3":
			pass
	PlayerRes.data.emit_signal("Tool_Rotation")

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed(PlayerRes.data.UnUI_Unselect):
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
	StatsMan.Set_Menu(false, "Brace menu")
	PlayerRes.data.Seletion_Menu_Active = !PlayerRes.data.Seletion_Menu_Active
	PlayerRes.data.emit_signal("Seletion_Menu_Toggled", PlayerRes.data.Seletion_Menu_Active)

func ready_wear_pressed() -> void:
	StatsMan.Set_Menu(false, "Wear menu")
	PlayerRes.data.Seletion_Menu_Active = !PlayerRes.data.Seletion_Menu_Active
	PlayerRes.data.emit_signal("Seletion_Menu_Toggled", PlayerRes.data.Seletion_Menu_Active)

func ready_tool_left_pressed() -> void:
	StatsMan.Set_Menu(false, "Tool Left menu")
	PlayerRes.data.Seletion_Menu_Active = !PlayerRes.data.Seletion_Menu_Active
	PlayerRes.data.emit_signal("Seletion_Menu_Toggled", PlayerRes.data.Seletion_Menu_Active)

func ready_tool_right_pressed() -> void:
	if PlayerRes.data.Inv_ToolR_Equiped == "null":
		StatsMan.Set_Menu(false, "Tool Right menu")
		PlayerRes.data.Seletion_Menu_Active = !PlayerRes.data.Seletion_Menu_Active
		PlayerRes.data.emit_signal("Seletion_Menu_Toggled", PlayerRes.data.Seletion_Menu_Active)
	else:
		%"Menu Return".play()
#endregion

#region Spell and UItem
func ready_spell_pressed() -> void:
	StatsMan.Set_Menu(false, "Spell menu")
	PlayerRes.data.Seletion_Menu_Active = !PlayerRes.data.Seletion_Menu_Active
	PlayerRes.data.emit_signal("Seletion_Menu_Toggled", PlayerRes.data.Seletion_Menu_Active)

func ready_u_item_1_pressed() -> void:
	StatsMan.Set_Menu(false, "UItem1 menu")
	PlayerRes.data.Seletion_Menu_Active = !PlayerRes.data.Seletion_Menu_Active
	PlayerRes.data.emit_signal("Seletion_Menu_Toggled", PlayerRes.data.Seletion_Menu_Active)

func ready_u_item_2_pressed() -> void:
	StatsMan.Set_Menu(false, "UItem2 menu")
	PlayerRes.data.Seletion_Menu_Active = !PlayerRes.data.Seletion_Menu_Active
	PlayerRes.data.emit_signal("Seletion_Menu_Toggled", PlayerRes.data.Seletion_Menu_Active)

func ready_u_item_3_pressed() -> void:
	StatsMan.Set_Menu(false, "UItem3 menu")
	PlayerRes.data.Seletion_Menu_Active = !PlayerRes.data.Seletion_Menu_Active
	PlayerRes.data.emit_signal("Seletion_Menu_Toggled", PlayerRes.data.Seletion_Menu_Active)
#endregion
