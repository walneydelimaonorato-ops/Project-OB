extends Node

func _ready() -> void:
	print_rich("[color=#ffdf00]MSelection Items Sorting Working[/color]")
	
	SignalBus.MSelection_Item_Sorting.connect(MSelection_Item_Sorting)

func MSelection_Item_Sorting():
	Menu_Path()
	Item_Availabe_Match()

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
			SignalBus.emit_signal("focus_first_visible", %Braces)
		"Wear menu":
			%Wear.visible = true
			SignalBus.emit_signal("focus_first_visible", %Wear)
		"Tool Right menu":
			%Tools.visible = true
			SignalBus.emit_signal("focus_first_visible", %Tools)
		"Tool Left menu":
			%Tools.visible = true
			SignalBus.emit_signal("focus_first_visible", %Tools)
		"Spell menu":
			%Spells.visible = true
			SignalBus.emit_signal("focus_first_visible", %Spells)
		"UItem1 menu":
			%UItems.visible = true
			SignalBus.emit_signal("focus_first_visible", %UItems)
		"UItem2 menu":
			%UItems.visible = true
			SignalBus.emit_signal("focus_first_visible", %UItems)
		"UItem3 menu":
			%UItems.visible = true
			SignalBus.emit_signal("focus_first_visible", %UItems)
