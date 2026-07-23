extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_rich("[color=#ffdf00]Mready Redirect Working[/color]")


#region Technical
func ready_inventory_pressed() -> void:
	pass

func ready_settings_pressed() -> void:
	pass # Replace with function body.
#endregion

#region Wear and Tool
func ready_brace_pressed() -> void:
	if Global.Player_Data.Inv_Brace_Equiped == "null":
		SignalBus.emit_signal("SubMenu_Setting",  "Brace menu")
		SignalBus.emit_signal("Menu_Setting", "Selection")
	else:
		%"Menu Return".play()

func ready_wear_pressed() -> void:
	if Global.Player_Data.Inv_Wear_Equiped == "null":
		SignalBus.emit_signal("SubMenu_Setting",  "Wear menu")
		SignalBus.emit_signal("Menu_Setting", "Selection")
	else:
		%"Menu Return".play()
func ready_tool_left_pressed() -> void:
	if Global.Player_Data.Inv_ToolL_Equiped == "null":
		SignalBus.emit_signal("SubMenu_Setting",  "Tool Left menu")
		SignalBus.emit_signal("Menu_Setting", "Selection")
	else:
		%"Menu Return".play()

func ready_tool_right_pressed() -> void:
	if Global.Player_Data.Inv_ToolR_Equiped == "null":
		SignalBus.emit_signal("SubMenu_Setting",  "Tool Right menu")
		SignalBus.emit_signal("Menu_Setting", "Selection")
	else:
		%"Menu Return".play()
#endregion

#region Spell and UItem
func ready_spell_pressed() -> void:
	SignalBus.emit_signal("SubMenu_Setting",  "Spell menu")
	SignalBus.emit_signal("Menu_Setting", "Selection")

func ready_u_item_1_pressed() -> void:
	SignalBus.emit_signal("SubMenu_Setting",  "UItem1 menu")
	SignalBus.emit_signal("Menu_Setting", "Selection")

func ready_u_item_2_pressed() -> void:
	SignalBus.emit_signal("SubMenu_Setting",  "UItem2 menu")
	SignalBus.emit_signal("Menu_Setting", "Selection")

func ready_u_item_3_pressed() -> void:
	SignalBus.emit_signal("SubMenu_Setting",  "UItem3 menu")
	SignalBus.emit_signal("Menu_Setting", "Selection")
#endregion
