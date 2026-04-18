extends Node
@onready var PlayerRes: Node = $"../../../../Script Nodes/Player Stats"
@onready var StatsMan: Node = $"../../../../Script Nodes/Stats Management"

@onready var MenuReady: Node = %"Menus (Ready)"

func _ready() -> void:
	PlayerRes.data.Seletion_Menu_Toggled.connect(set_Selection_Menu)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel") and PlayerRes.data.Current_Menu == "Selection":
		exit()

func exit():
	PlayerRes.data.emit_signal("Tool_Rotation")
	PlayerRes.data.Seletion_Menu_Active = !PlayerRes.data.Seletion_Menu_Active
	PlayerRes.data.emit_signal("Seletion_Menu_Toggled", PlayerRes.data.Seletion_Menu_Active)
	PlayerRes.data.Current_Menu = "Ready"
	MenuReady.focus_first_visible($"../Ready Menu/Ready Menu Grid/Ready Wear and Tool")

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
			if PlayerRes.data.Brace_ID[Item1][Key1] == true and PlayerRes.data.Brace_ID[Item1][Key2] == false:
				Item2.visible = true
		"Wear":
			if PlayerRes.data.Wear_ID[Item1][Key1] == true and PlayerRes.data.Wear_ID[Item1][Key2] == false:
				Item2.visible = true
		"Tool":
			if PlayerRes.data.Tool_ID[Item1][Key1] == true and PlayerRes.data.Tool_ID[Item1][Key2] == false:
				Item2.visible = true
		"Spell":
			if PlayerRes.data.Spell_ID[Item1][Key1] == true and PlayerRes.data.Spell_ID[Item1][Key2] == false:
				Item2.visible = true
		"UItem":
			if PlayerRes.data.UItem_ID[Item1][Key1] == true and PlayerRes.data.UItem_ID[Item1][Key2] == false:
				Item2.visible = true

func Menu_Path():
	%Braces.visible = false
	%Wear.visible = false
	%Spells.visible = false
	%Tools.visible = false
	%Spells.visible = false
	%UItems.visible = false
	match PlayerRes.data.Current_SubMenu:
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
	match PlayerRes.data.Current_SubMenu:
		"Tool Right menu":
			PlayerRes.data.Inv_ToolR_Equiped = PlayerRes.data.Tool_ID["HandGun"]["sys name"]
		"Tool Left menu":
			PlayerRes.data.Inv_ToolL_Equiped = PlayerRes.data.Tool_ID["HandGun"]["sys name"]
	PlayerRes.data.Tool_ID["HandGun"]["equipped?"] = true
	exit()
func tool_assault_pressed() -> void:
	match PlayerRes.data.Current_SubMenu:
		"Tool Right menu":
			PlayerRes.data.Inv_ToolR_Equiped = PlayerRes.data.Tool_ID["AssaultRifle"]["sys name"]
		"Tool Left menu":
			PlayerRes.data.Inv_ToolL_Equiped = PlayerRes.data.Tool_ID["AssaultRifle"]["sys name"]
	PlayerRes.data.Tool_ID["AssaultRifle"]["equipped?"] = true
	exit()
func tool_sword_pressed() -> void:
	match PlayerRes.data.Current_SubMenu:
		"Tool Right menu":
			PlayerRes.data.Inv_ToolR_Equiped = PlayerRes.data.Tool_ID["Sword"]["sys name"]
		"Tool Left menu":
			PlayerRes.data.Inv_ToolL_Equiped = PlayerRes.data.Tool_ID["Sword"]["sys name"]
	PlayerRes.data.Tool_ID["Sword"]["equipped?"] = true
	exit()
