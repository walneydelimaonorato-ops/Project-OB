extends Node
@onready var PlayerVars: Node = $"../../../../Script Nodes/Player Stats"
@onready var StatsMan: Node = $"../../../../Script Nodes/Stats Management"

@onready var MenuReady: Node = %"Menus (Ready)"

func _ready() -> void:
	PlayerVars.data.Seletion_Menu_Toggled.connect(set_Selection_Menu)


func set_Selection_Menu(active: bool):
	%"Selection Menu".visible = active
	if active:
		Menu_Path()
		StatsMan.Set_Menu("Selection")
		Item_Availabe_Match()
		%"Menu Advance".play()

func Item_Availabe_Match():
	Item_Availabe_Lookup("AssaultRifle", "picked?", "equipped?", %"Tool Assault")
	Item_Availabe_Lookup("HandGun", "picked?", "equipped?", %"Tool HandGun")
	Item_Availabe_Lookup("Sword", "picked?", "equipped?", %"Tool Sword")
	Item_Availabe_Lookup("SpecialBow", "picked?", "equipped?", %"Tool Bow")

func Item_Availabe_Lookup(Item1, Key1, Key2, Item2):
	if PlayerVars.data.Tool_ID[Item1][Key1] == true and PlayerVars.data.Tool_ID[Item1][Key2] == false:
		Item2.visible = true

func Menu_Path():
	%Braces.visible = false
	%Wear.visible = false
	%Spells.visible = false
	%Tools.visible = false
	%Spells.visible = false
	%UItems.visible = false
	match PlayerVars.data.Current_Menu:
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

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel") and PlayerVars.data.Current_Menu == "Selection":
		PlayerVars.data.Seletion_Menu_Active = !PlayerVars.data.Seletion_Menu_Active
		PlayerVars.data.emit_signal("Seletion_Menu_Toggled", PlayerVars.data.Seletion_Menu_Active)
		PlayerVars.data.Current_Menu = "Ready"
		MenuReady.focus_first_visible($"../Ready Menu/Ready Menu Grid/Ready Wear and Tool")
