extends Node
@onready var PlayerRes: Node = $"../../../../Script Nodes/Player Stats"
@onready var StatsMan: Node = $"../../../../Script Nodes/Stats Management"

@onready var MenuReady: Node = %"Menus (Ready)"

func _ready() -> void:
	Global.Player_Data.Seletion_Menu_Toggled.connect(set_Selection_Menu)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel") and Global.Player_Data.Current_Menu == "Selection":
		exit()

func exit():
	%"Menu Return".play()
	Global.Player_Data.emit_signal("Tool_Rotation")
	Global.Player_Data.Seletion_Menu_Active = !Global.Player_Data.Seletion_Menu_Active
	Global.Player_Data.emit_signal("Seletion_Menu_Toggled", Global.Player_Data.Seletion_Menu_Active)
	Global.Player_Data.Current_Menu = "Ready"
	MenuReady.focus_first_visible($"../Ready Menu/Ready Menu Grid/Ready Wear and Tool")

func Replace_Icon(Replaced_Texture, Icon_Path):
	Replaced_Texture.texture = Icon_Path.texture_normal

func set_Selection_Menu(active: bool):
	%"Selection Menu".visible = active
	if active:
		Menu_Path()
		StatsMan.Set_Menu(true, "Selection")
		Item_Availabe_Match()
		%"Menu Advance".play()

func Item_Availabe_Match():
	Item_Availabe_Lookup("Braces", "Golden Bra.", "picked?", "equipped?", %"Brace Golden")
	Item_Availabe_Lookup("Braces", "Clorophyl Bra.", "picked?", "equipped?", %"Brace Clorophyl")
	Item_Availabe_Lookup("Braces", "Power Bra.", "picked?", "equipped?", %"Brace Power")
	#Item_Availabe_Lookup("Braces", " ", "picked?", "equipped?", %" ")
	
	Item_Availabe_Lookup("Wear", "Plain", "picked?", "equipped?", %"Wear Plain Clothes")
	#Item_Availabe_Lookup("Wear", " ", "picked?", "equipped?", %" ")
	
	Item_Availabe_Lookup("Tool", "AssaultRifle", "picked?", "equipped?", %"Tool Assault")
	Item_Availabe_Lookup("Tool", "HandGun", "picked?", "equipped?", %"Tool HandGun")
	Item_Availabe_Lookup("Tool", "Sword", "picked?", "equipped?", %"Tool Sword")
	Item_Availabe_Lookup("Tool", "SpecialBow", "picked?", "equipped?", %"Tool Bow")
	#Item_Availabe_Lookup("Tool", " ", "picked?", "equipped?", %" ")

func Item_Availabe_Lookup(Type, Item1, Key1, Key2, Item2):
	Item2.visible = false
	match Type:
		"Braces":
			if Global.Player_Data.Brace_ID[Item1][Key1] == true and Global.Player_Data.Brace_ID[Item1][Key2] == false:
				Item2.visible = true
		"Wear":
			if Global.Player_Data.Wear_ID[Item1][Key1] == true and Global.Player_Data.Wear_ID[Item1][Key2] == false:
				Item2.visible = true
		"Tool":
			if Global.Player_Data.Tool_ID[Item1][Key1] == true and Global.Player_Data.Tool_ID[Item1][Key2] == false:
				Item2.visible = true
		"Spell":
			if Global.Player_Data.Spell_ID[Item1][Key1] == true and Global.Player_Data.Spell_ID[Item1][Key2] == false:
				Item2.visible = true
		"UItem":
			if Global.Player_Data.UItem_ID[Item1][Key1] == true and Global.Player_Data.UItem_ID[Item1][Key2] == false:
				Item2.visible = true

func Menu_Path():
	%Braces.visible = false
	%Wear.visible = false
	%Spells.visible = false
	%Tools.visible = false
	%Spells.visible = false
	%UItems.visible = false
	match Global.Player_Data.Current_SubMenu:
		"Brace menu":
			%Braces.visible = true
			MenuReady.focus_first_visible(%Braces)
		"Wear menu":
			%Wear.visible = true
			MenuReady.focus_first_visible(%Wear)
		"Tool Right menu":
			%Tools.visible = true
			MenuReady.focus_first_visible(%Tools)
		"Tool Left menu":
			%Tools.visible = true
			MenuReady.focus_first_visible(%Tools)
		"Spell menu":
			%Spells.visible = true
			MenuReady.focus_first_visible(%Spells)
		"UItem1 menu":
			%UItems.visible = true
			MenuReady.focus_first_visible(%UItems)
		"UItem2 menu":
			%UItems.visible = true
			MenuReady.focus_first_visible(%UItems)
		"UItem3 menu":
			%UItems.visible = true
			MenuReady.focus_first_visible(%UItems)

#region Tools Region
func tool_handgun_pressed() -> void:
	match Global.Player_Data.Current_SubMenu:
		"Tool Right menu":
			Global.Player_Data.Inv_ToolR_Equiped = Global.Player_Data.Tool_ID["HandGun"]["sys name"]
			Global.Player_Data.emit_signal("Menus_Visual_Update", "Ready Tool Right", Global.Player_Data.Tool_ID["HandGun"]["Icon"])
		"Tool Left menu":
			Global.Player_Data.Inv_ToolL_Equiped = Global.Player_Data.Tool_ID["HandGun"]["sys name"]
			Global.Player_Data.emit_signal("Menus_Visual_Update", "Ready Tool Left", Global.Player_Data.Tool_ID["HandGun"]["Icon"])
	Global.Player_Data.Tool_ID["HandGun"]["equipped?"] = true
	exit()

func tool_assault_pressed() -> void:
	match Global.Player_Data.Current_SubMenu:
		"Tool Right menu":
			Global.Player_Data.Inv_ToolR_Equiped = Global.Player_Data.Tool_ID["AssaultRifle"]["sys name"]
			Global.Player_Data.emit_signal("Menus_Visual_Update", "Ready Tool Right", Global.Player_Data.Tool_ID["AssaultRifle"]["Icon"])
		"Tool Left menu":
			Global.Player_Data.Inv_ToolL_Equiped = Global.Player_Data.Tool_ID["AssaultRifle"]["sys name"]
			Global.Player_Data.emit_signal("Menus_Visual_Update", "Ready Tool Left", Global.Player_Data.Tool_ID["AssaultRifle"]["Icon"])
	Global.Player_Data.Tool_ID["AssaultRifle"]["equipped?"] = true
	exit()

func tool_sword_pressed() -> void:
	match Global.Player_Data.Current_SubMenu:
		"Tool Right menu":
			Global.Player_Data.Inv_ToolR_Equiped = Global.Player_Data.Tool_ID["Sword"]["sys name"]
			Global.Player_Data.emit_signal("Menus_Visual_Update", "Ready Tool Right", Global.Player_Data.Tool_ID["Sword"]["Icon"])
		"Tool Left menu":
			Global.Player_Data.Inv_ToolL_Equiped = Global.Player_Data.Tool_ID["Sword"]["sys name"]
			Global.Player_Data.emit_signal("Menus_Visual_Update", "Ready Tool Left", Global.Player_Data.Tool_ID["Sword"]["Icon"])
	Global.Player_Data.Tool_ID["Sword"]["equipped?"] = true
	exit()

func tool_dagger_pressed() -> void:
	match Global.Player_Data.Current_SubMenu:
		"Tool Right menu":
			Global.Player_Data.Inv_ToolR_Equiped = Global.Player_Data.Tool_ID["Dagger"]["sys name"]
			Global.Player_Data.emit_signal("Menus_Visual_Update", "Ready Tool Right", Global.Player_Data.Tool_ID["Dagger"]["Icon"])
		"Tool Left menu":
			Global.Player_Data.Inv_ToolL_Equiped = Global.Player_Data.Tool_ID["Dagger"]["sys name"]
			Global.Player_Data.emit_signal("Menus_Visual_Update", "Ready Tool Left", Global.Player_Data.Tool_ID["Dagger"]["Icon"])
	Global.Player_Data.Tool_ID["Dagger"]["equipped?"] = true
	exit()

func tool_bow_pressed() -> void:
	match Global.Player_Data.Current_SubMenu:
		"Tool Right menu":
			Global.Player_Data.Inv_ToolR_Equiped = Global.Player_Data.Tool_ID["SpecialBow"]["sys name"]
			Global.Player_Data.emit_signal("Menus_Visual_Update", "Ready Tool Right", Global.Player_Data.Tool_ID["SpecialBow"]["Icon"])
		"Tool Left menu":
			Global.Player_Data.Inv_ToolL_Equiped = Global.Player_Data.Tool_ID["SpecialBow"]["sys name"]
			Global.Player_Data.emit_signal("Menus_Visual_Update", "Ready Tool Left", Global.Player_Data.Tool_ID["SpecialBow"]["Icon"])
	Global.Player_Data.Tool_ID["SpecialBow"]["equipped?"] = true
	exit()
#endregion


func brace_golden_pressed() -> void:
	Global.Player_Data.Inv_Brace_Equiped = Global.Player_Data.Brace_ID["Golden Bra."]["sys name"]
	Global.Player_Data.Brace_ID["Golden Bra."]["equipped?"] = true
	Global.Player_Data.emit_signal("Menus_Visual_Update", "Ready Brace", Global.Player_Data.Brace_ID["Golden Bra."]["Icon"])
	exit()

func brace_clorophyl_pressed() -> void:
	Global.Player_Data.Inv_Brace_Equiped = Global.Player_Data.Brace_ID["Clorophyl Bra."]["sys name"]
	Global.Player_Data.Brace_ID["Clorophyl Bra."]["equipped?"] = true
	Global.Player_Data.emit_signal("Menus_Visual_Update", "Ready Brace", Global.Player_Data.Brace_ID["Clorophyl Bra."]["Icon"])
	exit()

func brace_power_pressed() -> void:
	Global.Player_Data.Inv_Brace_Equiped = Global.Player_Data.Brace_ID["Power Bra."]["sys name"]
	Global.Player_Data.Brace_ID["Power Bra."]["equipped?"] = true
	Global.Player_Data.emit_signal("Menus_Visual_Update", "Ready Brace", Global.Player_Data.Brace_ID["Power Bra."]["Icon"])
	
	exit()
