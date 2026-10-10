extends Node

func _ready() -> void:
	BugBus.emit_signal("Report", "Player", "MSelection Item Selected Working")

func exit():
	IntSigBus.emit_signal("FMenu_Return", "Selection")
	IntSigBus.emit_signal("Side_HUD_Overlay_Update")
	IntSigBus.emit_signal("Ready_Menu_Overlay_Update")

#region Tools Region
func tool_handgun_pressed() -> void:
	match PLY_Flags.Menus["Current SubMenu"]:
		"Tool Right menu":
			PLY_Inventory.Inv_ToolR_Equiped = PLY_Inventory.Tool_ID["HandGun"]["sys name"]
		"Tool Left menu":
			PLY_Inventory.Inv_ToolL_Equiped = PLY_Inventory.Tool_ID["HandGun"]["sys name"]
	PLY_Inventory.Tool_ID["HandGun"]["equipped?"] = true
	exit()

func tool_assault_pressed() -> void:
	match PLY_Flags.Menus["Current SubMenu"]:
		"Tool Right menu":
			PLY_Inventory.Inv_ToolR_Equiped = PLY_Inventory.Tool_ID["AssaultRifle"]["sys name"]
		"Tool Left menu":
			PLY_Inventory.Inv_ToolL_Equiped = PLY_Inventory.Tool_ID["AssaultRifle"]["sys name"]
	PLY_Inventory.Tool_ID["AssaultRifle"]["equipped?"] = true
	exit()

func tool_sword_pressed() -> void:
	match PLY_Flags.Menus["Current SubMenu"]:
		"Tool Right menu":
			PLY_Inventory.Inv_ToolR_Equiped = PLY_Inventory.Tool_ID["Sword"]["sys name"]
		"Tool Left menu":
			PLY_Inventory.Inv_ToolL_Equiped = PLY_Inventory.Tool_ID["Sword"]["sys name"]
	PLY_Inventory.Tool_ID["Sword"]["equipped?"] = true
	exit()

func tool_dagger_pressed() -> void:
	match PLY_Flags.Menus["Current SubMenu"]:
		"Tool Right menu":
			PLY_Inventory.Inv_ToolR_Equiped = PLY_Inventory.Tool_ID["Dagger"]["sys name"]
		"Tool Left menu":
			PLY_Inventory.Inv_ToolL_Equiped = PLY_Inventory.Tool_ID["Dagger"]["sys name"]
	PLY_Inventory.Tool_ID["Dagger"]["equipped?"] = true
	exit()

func tool_bow_pressed() -> void:
	match PLY_Flags.Menus["Current SubMenu"]:
		"Tool Right menu":
			PLY_Inventory.Inv_ToolR_Equiped = PLY_Inventory.Tool_ID["SpecialBow"]["sys name"]
		"Tool Left menu":
			PLY_Inventory.Inv_ToolL_Equiped = PLY_Inventory.Tool_ID["SpecialBow"]["sys name"]
	PLY_Inventory.Tool_ID["SpecialBow"]["equipped?"] = true
	exit()
#endregion

#region Braces Region
func brace_golden_pressed() -> void:
	PLY_Inventory.Inv_Brace_Equiped = PLY_Inventory.Brace_ID["Golden Bra."]["sys name"]
	PLY_Inventory.Brace_ID["Golden Bra."]["equipped?"] = true
	exit()

func brace_clorophyl_pressed() -> void:
	PLY_Inventory.Inv_Brace_Equiped = PLY_Inventory.Brace_ID["Clorophyl Bra."]["sys name"]
	PLY_Inventory.Brace_ID["Clorophyl Bra."]["equipped?"] = true
	exit()

func brace_power_pressed() -> void:
	PLY_Inventory.Inv_Brace_Equiped = PLY_Inventory.Brace_ID["Power Bra."]["sys name"]
	PLY_Inventory.Brace_ID["Power Bra."]["equipped?"] = true
	exit()
#endregion

#region UItems Region
func uitem_sigil_pressed() -> void:
	match PLY_Flags.Menus["Current SubMenu"]:
		"UItem1 menu":
			PLY_Inventory.Inv_Uitem1_Equiped = PLY_Inventory.UItem_ID["Sigil"]["sys name"]
			PLY_Inventory.UItem_ID["Sigil"]["equipped?"] = true
		"UItem2 menu":
			PLY_Inventory.Inv_Uitem2_Equiped = PLY_Inventory.UItem_ID["Sigil"]["sys name"]
			PLY_Inventory.UItem_ID["Sigil"]["equipped?"] = true
		"UItem3 menu":
			PLY_Inventory.Inv_Uitem3_Equiped = PLY_Inventory.UItem_ID["Sigil"]["sys name"]
			PLY_Inventory.UItem_ID["Sigil"]["equipped?"] = true
	exit()

func uitem_green_flask_pressed() -> void:
	match PLY_Flags.Menus["Current SubMenu"]:
		"UItem1 menu":
			PLY_Inventory.Inv_Uitem1_Equiped = PLY_Inventory.UItem_ID["Glass Flask"]["sys name"]
			PLY_Inventory.UItem_ID["Glass Flask"]["equipped?"] = true
		"UItem2 menu":
			PLY_Inventory.Inv_Uitem2_Equiped = PLY_Inventory.UItem_ID["Glass Flask"]["sys name"]
			PLY_Inventory.UItem_ID["Glass Flask"]["equipped?"] = true
		"UItem3 menu":
			PLY_Inventory.Inv_Uitem3_Equiped = PLY_Inventory.UItem_ID["Glass Flask"]["sys name"]
			PLY_Inventory.UItem_ID["Glass Flask"]["equipped?"] = true
	exit()
#endregion
