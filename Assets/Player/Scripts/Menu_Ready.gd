extends Node
@onready var PlayerVars: Node = $"../../../../Script Nodes/Player Stats"
@onready var StatsMan: Node = $"../../../../Script Nodes/Stats Management"

func _ready() -> void:
	PlayerVars.data.Ready_Menu_Toggled.connect(set_Ready_Menu)
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
	#if not is_ancestor_of(%"Ready Menu"):
		#focus_first_visible($"../Ready Menu/Ready Menu Grid/Ready Spell and UItem")
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
	PlayerVars.data.Seletion_Menu_Active = !PlayerVars.data.Seletion_Menu_Active
	PlayerVars.data.emit_signal("Seletion_Menu_Toggled", PlayerVars.data.Seletion_Menu_Active)

func ready_wear_pressed() -> void:
	StatsMan.Set_Menu(false, "Wear menu")
	PlayerVars.data.Seletion_Menu_Active = !PlayerVars.data.Seletion_Menu_Active
	PlayerVars.data.emit_signal("Seletion_Menu_Toggled", PlayerVars.data.Seletion_Menu_Active)

func ready_tool_left_pressed() -> void:
	StatsMan.Set_Menu(false, "Tool Left menu")
	PlayerVars.data.Seletion_Menu_Active = !PlayerVars.data.Seletion_Menu_Active
	PlayerVars.data.emit_signal("Seletion_Menu_Toggled", PlayerVars.data.Seletion_Menu_Active)

func ready_tool_right_pressed() -> void:
	StatsMan.Set_Menu(false, "Tool Right menu")
	PlayerVars.data.Seletion_Menu_Active = !PlayerVars.data.Seletion_Menu_Active
	PlayerVars.data.emit_signal("Seletion_Menu_Toggled", PlayerVars.data.Seletion_Menu_Active)
#endregion

#region Spell and UItem
func ready_spell_pressed() -> void:
	StatsMan.Set_Menu(false, "Spell menu")
	PlayerVars.data.Seletion_Menu_Active = !PlayerVars.data.Seletion_Menu_Active
	PlayerVars.data.emit_signal("Seletion_Menu_Toggled", PlayerVars.data.Seletion_Menu_Active)

func ready_u_item_1_pressed() -> void:
	StatsMan.Set_Menu(false, "UItem1 menu")
	PlayerVars.data.Seletion_Menu_Active = !PlayerVars.data.Seletion_Menu_Active
	PlayerVars.data.emit_signal("Seletion_Menu_Toggled", PlayerVars.data.Seletion_Menu_Active)

func ready_u_item_2_pressed() -> void:
	StatsMan.Set_Menu(false, "UItem2 menu")
	PlayerVars.data.Seletion_Menu_Active = !PlayerVars.data.Seletion_Menu_Active
	PlayerVars.data.emit_signal("Seletion_Menu_Toggled", PlayerVars.data.Seletion_Menu_Active)

func ready_u_item_3_pressed() -> void:
	StatsMan.Set_Menu(false, "UItem3 menu")
	PlayerVars.data.Seletion_Menu_Active = !PlayerVars.data.Seletion_Menu_Active
	PlayerVars.data.emit_signal("Seletion_Menu_Toggled", PlayerVars.data.Seletion_Menu_Active)
#endregion
