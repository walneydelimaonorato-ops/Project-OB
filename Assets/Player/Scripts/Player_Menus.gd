extends Node
@onready var PlayerVars: Node = $"../../../../Script Nodes/Player Stats"

func _ready() -> void:
	PlayerVars.data.Ready_Menu_Toggled.connect(on_Ready_Menu_Toggled)
	get_viewport().gui_focus_changed.connect(_on_focus_changed)

#func _process(delta: float) -> void:
	#%"Ready Menu".visible = PlayerVars.data.Ready_Menu_Active
	#focus_first_visible(%"Ready Menu Grid")

#region Functions
func Set_Menu(Next_Menu):
	PlayerVars.data.Current_Menu = Next_Menu

func on_Ready_Menu_Toggled(active: bool):
	set_Ready_Menu(active)

func set_Ready_Menu(active: bool):
	%"Ready Menu".visible = active
	if active:
		call_deferred("focus_first_visible", $"../Ready Menu/Ready Menu Grid/Ready Technical")
		%"Menu Advance".play()
	elif !active:
		Set_Menu("none")
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
#endregion

#region Technical
func ready_inventory_pressed() -> void:
	pass

func ready_settings_pressed() -> void:
	pass # Replace with function body.
#endregion

#region Wear and Tool
func ready_brace_pressed() -> void:
	Set_Menu("Brace menu")

func ready_wear_pressed() -> void:
	Set_Menu("Wear menu")

func ready_tool_left_pressed() -> void:
	Set_Menu("Tool Left menu")

func ready_tool_right_pressed() -> void:
	Set_Menu("Tool Right menu")
#endregion

#region Spell and UItem
func ready_spell_pressed() -> void:
	pass # Replace with function body.

func ready_u_item_1_pressed() -> void:
	pass # Replace with function body.

func ready_u_item_2_pressed() -> void:
	pass # Replace with function body.

func ready_u_item_3_pressed() -> void:
	pass # Replace with function body.
#endregion
