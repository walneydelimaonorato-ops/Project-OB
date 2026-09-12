extends Node

func _ready() -> void:
	print_rich("[color=#ffdf00]MSelection Items Sorting Working[/color]")
	
	SignalBus.MSelection_Item_Sorting.connect(MSelection_Item_Sorting)

func MSelection_Item_Sorting():
	Menu_Path()
	Item_Availabe_Match()

func Item_Availabe_Match():
	Item_Availabe_Lookup("Braces", "Golden Bra.", %"Brace Golden")
	Item_Availabe_Lookup("Braces", "Clorophyl Bra.", %"Brace Clorophyl")
	Item_Availabe_Lookup("Braces", "Power Bra.", %"Brace Power")
	#Item_Availabe_Lookup("Braces", " ", "picked?", "equipped?", %" ")
	
	#Item_Availabe_Lookup("Wear", "Plain", "picked?", "equipped?", %"Wear Plain Clothes")
	#Item_Availabe_Lookup("Wear", " ", "picked?", "equipped?", %" ")
	
	Item_Availabe_Lookup("Tool", "AssaultRifle", %"Tool Assault")
	Item_Availabe_Lookup("Tool", "HandGun", %"Tool HandGun")
	Item_Availabe_Lookup("Tool", "Sword", %"Tool Sword")
	Item_Availabe_Lookup("Tool", "SpecialBow", %"Tool Bow")
	#Item_Availabe_Lookup("Tool", " ", "picked?", "equipped?", %" ")

func Item_Availabe_Lookup(Type, Item1, Item2):
	Item2.visible = false
	match Type:
		"Braces":
			if Global.Inventory_Data.Brace_ID[Item1]["picked?"] == true and Global.Inventory_Data.Brace_ID[Item1]["equipped?"] == false:
				Item2.visible = true
		"Wear":
			if Global.Inventory_Data.Wear_ID[Item1]["picked?"] == true and Global.Inventory_Data.Wear_ID[Item1]["equipped?"] == false:
				Item2.visible = true
		"Tool":
			if Global.Inventory_Data.Tool_ID[Item1]["picked?"] == true and Global.Inventory_Data.Tool_ID[Item1]["equipped?"] == false:
				Item2.visible = true
		"Spell":
			if Global.Inventory_Data.Spell_ID[Item1]["picked?"] == true and Global.Inventory_Data.Spell_ID[Item1]["equipped?"] == false:
				Item2.visible = true
		"UItem":
			if Global.Inventory_Data.UItem_ID[Item1]["picked?"] == true and Global.Inventory_Data.UItem_ID[Item1]["equipped?"] == false:
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
