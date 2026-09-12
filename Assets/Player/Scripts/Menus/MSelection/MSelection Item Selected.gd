extends Node

func _ready() -> void:
	print_rich("[color=#ffdf00]MSelection Item Selected Working[/color]")

func exit():
	SignalBus.emit_signal("FMenu_Return", "Selection")
	SignalBus.emit_signal("Side_HUD_Overlay_Update")
	SignalBus.emit_signal("Ready_Menu_Overlay_Update")

#region Tools Region
func tool_handgun_pressed() -> void:
	match Global.Player_Data.Current_SubMenu:
		"Tool Right menu":
			Global.Player_Data.Inv_ToolR_Equiped = Global.Inventory_Data.Tool_ID["HandGun"]["sys name"]
		"Tool Left menu":
			Global.Player_Data.Inv_ToolL_Equiped = Global.Inventory_Data.Tool_ID["HandGun"]["sys name"]
	Global.Inventory_Data.Tool_ID["HandGun"]["equipped?"] = true
	exit()

func tool_assault_pressed() -> void:
	match Global.Player_Data.Current_SubMenu:
		"Tool Right menu":
			Global.Player_Data.Inv_ToolR_Equiped = Global.Inventory_Data.Tool_ID["AssaultRifle"]["sys name"]
		"Tool Left menu":
			Global.Player_Data.Inv_ToolL_Equiped = Global.Inventory_Data.Tool_ID["AssaultRifle"]["sys name"]
	Global.Inventory_Data.Tool_ID["AssaultRifle"]["equipped?"] = true
	exit()

func tool_sword_pressed() -> void:
	match Global.Player_Data.Current_SubMenu:
		"Tool Right menu":
			Global.Player_Data.Inv_ToolR_Equiped = Global.Inventory_Data.Tool_ID["Sword"]["sys name"]
		"Tool Left menu":
			Global.Player_Data.Inv_ToolL_Equiped = Global.Inventory_Data.Tool_ID["Sword"]["sys name"]
	Global.Inventory_Data.Tool_ID["Sword"]["equipped?"] = true
	exit()

func tool_dagger_pressed() -> void:
	match Global.Player_Data.Current_SubMenu:
		"Tool Right menu":
			Global.Player_Data.Inv_ToolR_Equiped = Global.Inventory_Data.Tool_ID["Dagger"]["sys name"]
		"Tool Left menu":
			Global.Player_Data.Inv_ToolL_Equiped = Global.Inventory_Data.Tool_ID["Dagger"]["sys name"]
	Global.Inventory_Data.Tool_ID["Dagger"]["equipped?"] = true
	exit()

func tool_bow_pressed() -> void:
	match Global.Player_Data.Current_SubMenu:
		"Tool Right menu":
			Global.Player_Data.Inv_ToolR_Equiped = Global.Inventory_Data.Tool_ID["SpecialBow"]["sys name"]
		"Tool Left menu":
			Global.Player_Data.Inv_ToolL_Equiped = Global.Inventory_Data.Tool_ID["SpecialBow"]["sys name"]
	Global.Inventory_Data.Tool_ID["SpecialBow"]["equipped?"] = true
	exit()
#endregion

#region Braces Region
func brace_golden_pressed() -> void:
	Global.Player_Data.Inv_Brace_Equiped = Global.Inventory_Data.Brace_ID["Golden Bra."]["sys name"]
	Global.Inventory_Data.Brace_ID["Golden Bra."]["equipped?"] = true
	exit()

func brace_clorophyl_pressed() -> void:
	Global.Player_Data.Inv_Brace_Equiped = Global.Inventory_Data.Brace_ID["Clorophyl Bra."]["sys name"]
	Global.Inventory_Data.Brace_ID["Clorophyl Bra."]["equipped?"] = true
	exit()

func brace_power_pressed() -> void:
	Global.Player_Data.Inv_Brace_Equiped = Global.Inventory_Data.Brace_ID["Power Bra."]["sys name"]
	Global.Inventory_Data.Brace_ID["Power Bra."]["equipped?"] = true
	exit()
#endregion

#region UItems Region
func uitem_sigil_pressed() -> void:
	match Global.Player_Data.Current_SubMenu:
		"UItem1 menu":
			Global.Player_Data.Inv_Uitem1_Equiped = Global.Inventory_Data.UItem_ID["Sigil"]["sys name"]
			Global.Inventory_Data.UItem_ID["Sigil"]["equipped?"] = true
		"UItem2 menu":
			Global.Player_Data.Inv_Uitem2_Equiped = Global.Inventory_Data.UItem_ID["Sigil"]["sys name"]
			Global.Inventory_Data.UItem_ID["Sigil"]["equipped?"] = true
		"UItem3 menu":
			Global.Player_Data.Inv_Uitem3_Equiped = Global.Inventory_Data.UItem_ID["Sigil"]["sys name"]
			Global.Inventory_Data.UItem_ID["Sigil"]["equipped?"] = true
	exit()

func uitem_green_flask_pressed() -> void:
	match Global.Player_Data.Current_SubMenu:
		"UItem1 menu":
			Global.Player_Data.Inv_Uitem1_Equiped = Global.Inventory_Data.UItem_ID["Glass Flask"]["sys name"]
			Global.Inventory_Data.UItem_ID["Glass Flask"]["equipped?"] = true
		"UItem2 menu":
			Global.Player_Data.Inv_Uitem2_Equiped = Global.Inventory_Data.UItem_ID["Glass Flask"]["sys name"]
			Global.Inventory_Data.UItem_ID["Glass Flask"]["equipped?"] = true
		"UItem3 menu":
			Global.Player_Data.Inv_Uitem3_Equiped = Global.Inventory_Data.UItem_ID["Glass Flask"]["sys name"]
			Global.Inventory_Data.UItem_ID["Glass Flask"]["equipped?"] = true
	exit()
#endregion
