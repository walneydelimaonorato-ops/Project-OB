extends Node

func _ready() -> void:
	print_rich("[color=#ffdf00]MSelection Item Selected Working[/color]")

func exit():
	SignalBus.emit_signal("FMenu_Return", "Selection")

#region Tools Region
func tool_handgun_pressed() -> void:
	match Global.Player_Data.Current_SubMenu:
		"Tool Right menu":
			Global.Player_Data.Inv_ToolR_Equiped = Global.Player_Data.Tool_ID["HandGun"]["sys name"]
			SignalBus.emit_signal("Side_HUD_Overlay_Update", "Ready Tool Right", Global.Player_Data.Tool_ID["HandGun"]["Icon"])
			SignalBus.emit_signal("Ready_Menu_Overlay_Update", "Ready Tool Right", Global.Player_Data.Tool_ID["HandGun"]["Icon"])
		"Tool Left menu":
			Global.Player_Data.Inv_ToolL_Equiped = Global.Player_Data.Tool_ID["HandGun"]["sys name"]
			SignalBus.emit_signal("Side_HUD_Overlay_Update", "Ready Tool Left", Global.Player_Data.Tool_ID["HandGun"]["Icon"])
			SignalBus.emit_signal("Ready_Menu_Overlay_Update", "Ready Tool Left", Global.Player_Data.Tool_ID["HandGun"]["Icon"])
	Global.Player_Data.Tool_ID["HandGun"]["equipped?"] = true
	exit()

func tool_assault_pressed() -> void:
	match Global.Player_Data.Current_SubMenu:
		"Tool Right menu":
			Global.Player_Data.Inv_ToolR_Equiped = Global.Player_Data.Tool_ID["AssaultRifle"]["sys name"]
			SignalBus.emit_signal("Side_HUD_Overlay_Update", "Ready Tool Right", Global.Player_Data.Tool_ID["AssaultRifle"]["Icon"])
			SignalBus.emit_signal("Ready_Menu_Overlay_Update", "Ready Tool Right", Global.Player_Data.Tool_ID["AssaultRifle"]["Icon"])
		"Tool Left menu":
			Global.Player_Data.Inv_ToolL_Equiped = Global.Player_Data.Tool_ID["AssaultRifle"]["sys name"]
			SignalBus.emit_signal("Side_HUD_Overlay_Update", "Ready Tool Left", Global.Player_Data.Tool_ID["AssaultRifle"]["Icon"])
			SignalBus.emit_signal("Ready_Menu_Overlay_Update", "Ready Tool Left", Global.Player_Data.Tool_ID["AssaultRifle"]["Icon"])
	Global.Player_Data.Tool_ID["AssaultRifle"]["equipped?"] = true
	exit()

func tool_sword_pressed() -> void:
	match Global.Player_Data.Current_SubMenu:
		"Tool Right menu":
			Global.Player_Data.Inv_ToolR_Equiped = Global.Player_Data.Tool_ID["Sword"]["sys name"]
			SignalBus.emit_signal("Side_HUD_Overlay_Update", "Ready Tool Right", Global.Player_Data.Tool_ID["Sword"]["Icon"])
			SignalBus.emit_signal("Ready_Menu_Overlay_Update", "Ready Tool Right", Global.Player_Data.Tool_ID["Sword"]["Icon"])
		"Tool Left menu":
			Global.Player_Data.Inv_ToolL_Equiped = Global.Player_Data.Tool_ID["Sword"]["sys name"]
			SignalBus.emit_signal("Side_HUD_Overlay_Update", "Ready Tool Left", Global.Player_Data.Tool_ID["Sword"]["Icon"])
			SignalBus.emit_signal("Ready_Menu_Overlay_Update", "Ready Tool Left", Global.Player_Data.Tool_ID["Sword"]["Icon"])
	Global.Player_Data.Tool_ID["Sword"]["equipped?"] = true
	exit()

func tool_dagger_pressed() -> void:
	match Global.Player_Data.Current_SubMenu:
		"Tool Right menu":
			Global.Player_Data.Inv_ToolR_Equiped = Global.Player_Data.Tool_ID["Dagger"]["sys name"]
			SignalBus.emit_signal("Side_HUD_Overlay_Update", "Ready Tool Right", Global.Player_Data.Tool_ID["Dagger"]["Icon"])
			SignalBus.emit_signal("Ready_Menu_Overlay_Update", "Ready Tool Right", Global.Player_Data.Tool_ID["Dagger"]["Icon"])
		"Tool Left menu":
			Global.Player_Data.Inv_ToolL_Equiped = Global.Player_Data.Tool_ID["Dagger"]["sys name"]
			SignalBus.emit_signal("Side_HUD_Overlay_Update", "Ready Tool Left", Global.Player_Data.Tool_ID["Dagger"]["Icon"])
			SignalBus.emit_signal("Ready_Menu_Overlay_Update", "Ready Tool Left", Global.Player_Data.Tool_ID["Dagger"]["Icon"])
	Global.Player_Data.Tool_ID["Dagger"]["equipped?"] = true
	exit()

func tool_bow_pressed() -> void:
	match Global.Player_Data.Current_SubMenu:
		"Tool Right menu":
			Global.Player_Data.Inv_ToolR_Equiped = Global.Player_Data.Tool_ID["SpecialBow"]["sys name"]
			SignalBus.emit_signal("Side_HUD_Overlay_Update", "Ready Tool Right", Global.Player_Data.Tool_ID["SpecialBow"]["Icon"])
			SignalBus.emit_signal("Ready_Menu_Overlay_Update", "Ready Tool Right", Global.Player_Data.Tool_ID["SpecialBow"]["Icon"])
		"Tool Left menu":
			Global.Player_Data.Inv_ToolL_Equiped = Global.Player_Data.Tool_ID["SpecialBow"]["sys name"]
			SignalBus.emit_signal("Side_HUD_Overlay_Update", "Ready Tool Left", Global.Player_Data.Tool_ID["SpecialBow"]["Icon"])
			SignalBus.emit_signal("Ready_Menu_Overlay_Update", "Ready Tool Left", Global.Player_Data.Tool_ID["SpecialBow"]["Icon"])
	Global.Player_Data.Tool_ID["SpecialBow"]["equipped?"] = true
	exit()
#endregion

#region Braces Region
func brace_golden_pressed() -> void:
	Global.Player_Data.Inv_Brace_Equiped = Global.Player_Data.Brace_ID["Golden Bra."]["sys name"]
	Global.Player_Data.Brace_ID["Golden Bra."]["equipped?"] = true
	SignalBus.emit_signal("Side_HUD_Overlay_Update", "Ready Brace", Global.Player_Data.Brace_ID["Golden Bra."]["Icon"])
	SignalBus.emit_signal("Ready_Menu_Overlay_Update", "Ready Brace", Global.Player_Data.Brace_ID["Golden Bra."]["Icon"])
	exit()

func brace_clorophyl_pressed() -> void:
	Global.Player_Data.Inv_Brace_Equiped = Global.Player_Data.Brace_ID["Clorophyl Bra."]["sys name"]
	Global.Player_Data.Brace_ID["Clorophyl Bra."]["equipped?"] = true
	SignalBus.emit_signal("Side_HUD_Overlay_Update", "Ready Brace", Global.Player_Data.Brace_ID["Clorophyl Bra."]["Icon"])
	SignalBus.emit_signal("Ready_Menu_Overlay_Update", "Ready Brace", Global.Player_Data.Brace_ID["Clorophyl Bra."]["Icon"])
	exit()

func brace_power_pressed() -> void:
	Global.Player_Data.Inv_Brace_Equiped = Global.Player_Data.Brace_ID["Power Bra."]["sys name"]
	Global.Player_Data.Brace_ID["Power Bra."]["equipped?"] = true
	SignalBus.emit_signal("Side_HUD_Overlay_Update", "Ready Brace", Global.Player_Data.Brace_ID["Power Bra."]["Icon"])
	SignalBus.emit_signal("Ready_Menu_Overlay_Update", "Ready Brace", Global.Player_Data.Brace_ID["Power Bra."]["Icon"])
	
	exit()
#endregion

#region UItems Region
func uitem_sigil_pressed() -> void:
	match Global.Player_Data.Current_SubMenu:
		"UItem1 menu":
			Global.Player_Data.Inv_Uitem1_Equiped = Global.Player_Data.UItem_ID["Sigil"]["sys name"]
			Global.Player_Data.UItem_ID["Sigil"]["equipped?"] = true
			SignalBus.emit_signal("Side_HUD_Overlay_Update", "Ready UItem 1", Global.Player_Data.UItem_ID["Sigil"]["Icon"])
			SignalBus.emit_signal("Ready_Menu_Overlay_Update", "Ready UItem 1", Global.Player_Data.UItem_ID["Sigil"]["Icon"])
			exit()
		"UItem2 menu":
			Global.Player_Data.Inv_Uitem2_Equiped = Global.Player_Data.UItem_ID["Sigil"]["sys name"]
			Global.Player_Data.UItem_ID["Sigil"]["equipped?"] = true
			SignalBus.emit_signal("Side_HUD_Overlay_Update", "Ready UItem 2", Global.Player_Data.UItem_ID["Sigil"]["Icon"])
			SignalBus.emit_signal("Ready_Menu_Overlay_Update", "Ready UItem 2", Global.Player_Data.UItem_ID["Sigil"]["Icon"])
			exit()
		"UItem3 menu":
			Global.Player_Data.Inv_Uitem3_Equiped = Global.Player_Data.UItem_ID["Sigil"]["sys name"]
			Global.Player_Data.UItem_ID["Sigil"]["equipped?"] = true
			SignalBus.emit_signal("Side_HUD_Overlay_Update", "Ready UItem 3", Global.Player_Data.UItem_ID["Sigil"]["Icon"])
			SignalBus.emit_signal("Ready_Menu_Overlay_Update", "Ready UItem 3", Global.Player_Data.UItem_ID["Sigil"]["Icon"])
			exit()

func uitem_green_flask_pressed() -> void:
	match Global.Player_Data.Current_SubMenu:
		"UItem1 menu":
			Global.Player_Data.Inv_Uitem1_Equiped = Global.Player_Data.UItem_ID["Glass Flask"]["sys name"]
			Global.Player_Data.UItem_ID["Glass Flask"]["equipped?"] = true
			SignalBus.emit_signal("Side_HUD_Overlay_Update", "Ready UItem 1", Global.Player_Data.UItem_ID["Glass Flask"]["Icon"])
			SignalBus.emit_signal("Ready_Menu_Overlay_Update", "Ready UItem 1", Global.Player_Data.UItem_ID["Glass Flask"]["Icon"])
			exit()
		"UItem2 menu":
			Global.Player_Data.Inv_Uitem2_Equiped = Global.Player_Data.UItem_ID["Glass Flask"]["sys name"]
			Global.Player_Data.UItem_ID["Glass Flask"]["equipped?"] = true
			SignalBus.emit_signal("Side_HUD_Overlay_Update", "Ready UItem 2", Global.Player_Data.UItem_ID["Glass Flask"]["Icon"])
			SignalBus.emit_signal("Ready_Menu_Overlay_Update", "Ready UItem 2", Global.Player_Data.UItem_ID["Glass Flask"]["Icon"])
			exit()
		"UItem3 menu":
			Global.Player_Data.Inv_Uitem3_Equiped = Global.Player_Data.UItem_ID["Glass Flask"]["sys name"]
			Global.Player_Data.UItem_ID["Glass Flask"]["equipped?"] = true
			SignalBus.emit_signal("Side_HUD_Overlay_Update", "Ready UItem 3", Global.Player_Data.UItem_ID["Glass Flask"]["Icon"])
			SignalBus.emit_signal("Ready_Menu_Overlay_Update", "Ready UItem 3", Global.Player_Data.UItem_ID["Glass Flask"]["Icon"])
			exit()
#endregion
