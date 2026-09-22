extends Node

func _ready() -> void:
	print_rich("[color=#ffdf00]MSelection Items Sorting Working[/color]")
	
	SignalBus.MSelection_Item_Sorting.connect(MSelection_Item_Sorting)

func MSelection_Item_Sorting():
	Menu_Path()
	Item_Availabe_Match("Tools")

func Item_Availabe_Match(Item_Type: String):
	for Brace: TextureButton in %Braces.get_children():
		if Brace.name in ["Start of Braces", "End of Braces", "Brace Placeholder"]: 
			continue
		if Global.Inventory_Data.Brace_ID[Brace.name]["picked?"] == true and Global.Inventory_Data.Brace_ID[Brace.name]["equipped?"] == false:
			Brace.visible = true
	
	for Tool: TextureButton in %Tools.get_children():
		if Tool.name in ["Start of Tool", "End of Tool", "Tool Placeholder"]: 
			continue
		if Global.Inventory_Data.Tool_ID[Tool.name]["picked?"] == true and Global.Inventory_Data.Tool_ID[Tool.name]["equipped?"] == false:
			Tool.visible = true
			var Info = Tool.get_child(0)
			Info.text = str("[img=200]", Global.Inventory_Data.Tool_ID[Tool.name]["Icon"], "[/img]: ", Global.Inventory_Data.Tool_ID[Tool.name]["dys name"])

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
