extends Node


func _ready() -> void:
	BugBus.emit_signal("Report", "Player", "Mready Redirect Working")


#region Technical
func ready_inventory_pressed() -> void:
	pass

func ready_settings_pressed() -> void:
	pass # Replace with function body.
#endregion

#region Wear and Tool
func ready_brace_pressed() -> void:
	if PLY_Inventory.Inv_Brace_Equiped == "null":
		IntSigBus.emit_signal("SubMenu_Setting", "Brace menu")
		IntSigBus.emit_signal("Menu_Setting", "Selection")
	else:
		%"Menu Return".play()

func ready_wear_pressed() -> void:
	if PLY_Inventory.Inv_Wear_Equiped == "null":
		IntSigBus.emit_signal("SubMenu_Setting", "Wear menu")
		IntSigBus.emit_signal("Menu_Setting", "Selection")
	else:
		%"Menu Return".play()
func ready_tool_left_pressed() -> void:
	if PLY_Inventory.Inv_ToolL_Equiped == "null":
		IntSigBus.emit_signal("SubMenu_Setting", "Tool Left menu")
		IntSigBus.emit_signal("Menu_Setting", "Selection")
	else:
		%"Menu Return".play()

func ready_tool_right_pressed() -> void:
	if PLY_Inventory.Inv_ToolR_Equiped == "null":
		IntSigBus.emit_signal("SubMenu_Setting", "Tool Right menu")
		IntSigBus.emit_signal("Menu_Setting", "Selection")
	else:
		%"Menu Return".play()
#endregion

#region Spell and UItem
func ready_spell_pressed() -> void:
	IntSigBus.emit_signal("SubMenu_Setting", "Spell menu")
	IntSigBus.emit_signal("Menu_Setting", "Selection")

func ready_u_item_1_pressed() -> void:
	IntSigBus.emit_signal("SubMenu_Setting", "UItem1 menu")
	IntSigBus.emit_signal("Menu_Setting", "Selection")

func ready_u_item_2_pressed() -> void:
	IntSigBus.emit_signal("SubMenu_Setting", "UItem2 menu")
	IntSigBus.emit_signal("Menu_Setting", "Selection")

func ready_u_item_3_pressed() -> void:
	IntSigBus.emit_signal("SubMenu_Setting", "UItem3 menu")
	IntSigBus.emit_signal("Menu_Setting", "Selection")
#endregion
