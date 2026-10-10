extends Node

func _ready() -> void:
	BugBus.emit_signal("Report", "Player", "Player Menus Management Work")
	
	%"Ready Menu".visible = false
	%"Selection Menu".visible = false
	%"Choice Menu".visible = false
	%"Dialogue Menu".visible = false
	
	Ready_Menu_Overlay_Update()
	IntSigBus.Ready_Menu_Overlay_Update.connect(Ready_Menu_Overlay_Update)
	IntSigBus.focus_first_visible.connect(focus_first_visible)
	
	IntSigBus.Menu_Setting.connect(Menu_Setting)
	IntSigBus.SubMenu_Setting.connect(SubMenu_Setting)

func Menu_Setting(Menu: String):
	match Menu:
		"Ready":
			PLY_Flags.Menus["Ready"] = !PLY_Flags.Menus["Ready"]
			%"Ready Menu".visible = PLY_Flags.Menus["Ready"]
			if PLY_Flags.Menus["Ready"]:
				IntSigBus.emit_signal("focus_first_visible", %"Ready Technical")
				PLY_Flags.Menus["Current Menu"] = "Ready"
				%"Menu Advance".play()
			elif not PLY_Flags.Menus["Ready"]:
				PLY_Flags.Menus["Current Menu"] = "null"
				%"Menu Return".play()
		
		"Selection":
			PLY_Flags.Menus["Selection"] = !PLY_Flags.Menus["Selection"]
			%"Selection Menu".visible = PLY_Flags.Menus["Selection"]
			if PLY_Flags.Menus["Selection"]:
				IntSigBus.emit_signal("MSelection_Item_Sorting")
				PLY_Flags.Menus["Current Menu"] = "Selection"
				%"Menu Advance".play()
			elif not PLY_Flags.Menus["Selection"]:
				IntSigBus.emit_signal("focus_first_visible", %"Ready Wear and Tool")
				PLY_Flags.Menus["Current Menu"] = "Ready"
				%"Menu Return".play()
		
		"Keys":
			PLY_Flags.Menus["Keys"] = !PLY_Flags.Menus["Keys"]
			%"Keys Menu".visible = PLY_Flags.Menus["Keys"]
			if PLY_Flags.Menus["Keys"]:
				IntSigBus.emit_signal("focus_first_visible", %Keys)
				PLY_Flags.Perms["Can Move"] = false
				PLY_Flags.Perms["Can Look"] = false
				PLY_Flags.Menus["Current Menu"] = "Keys"
				%"Menu Advance".play()
			elif not PLY_Flags.Menus["Keys"]:
				PLY_Flags.Perms["Can Move"] = true
				PLY_Flags.Perms["Can Look"] = true
				PLY_Flags.Menus["Current Menu"] = "null"
				%"Menu Return".play()
		
		"Rest":
			PLY_Flags.Perms["Is Resting"] = !PLY_Flags.Perms["Is Resting"]
			%"Rest Menu".visible = PLY_Flags.Perms["Is Resting"]
			if PLY_Flags.Perms["Is Resting"]:
				IntSigBus.emit_signal("focus_first_visible", %"Rest Buttons")
				PLY_Flags.Perms["Can Move"] = false
				PLY_Flags.Perms["Can Look"] = false
				PLY_Flags.Menus["Current Menu"] = "Rest"
			elif not PLY_Flags.Perms["Is Resting"]:
				PLY_Flags.Perms["Can Move"] = true
				PLY_Flags.Perms["Can Look"] = true
				PLY_Flags.Menus["Current Menu"] = "null"
				%"Menu Return".play()
				PLY_Var.Current_Camera = get_tree().get_root().find_child("Eyes", true, false)
				PLY_Var.Current_Camera.make_current()
		_:
			print_rich("[color=#ff00ff]MANUAL ERROR: <Attempt to Exit Menu without valid parameters>[/color]")
	IntSigBus.emit_signal("Player_Permissions_Conditionals")

func SubMenu_Setting(SubMenu: String):
	PLY_Flags.Menus["Current SubMenu"] = SubMenu

func Exit_Menu(Menu_Back_To: String, Focus_First):
	$"Menu Return".play()
	IntSigBus.emit_signal("Tool_Rotation")
	IntSigBus.emit_signal("Side_HUD_Update")
	Menu_Setting(Menu_Back_To)
	IntSigBus.emit_signal("focus_first_visible", Focus_First)

func focus_first_visible(container):
	for child in container.get_children():
		if child is Control:
			if child.visible and child.focus_mode != Control.FOCUS_NONE:
				child.grab_focus()
				return
			focus_first_visible(child)

func Ready_Menu_Overlay_Update():
	%"Ready Brace Overlay".texture = load(PLY_Inventory.Brace_ID[PLY_Inventory.Inv_Brace_Equiped]["Icon"])
	%"Ready Wear Overlay".texture = load(PLY_Inventory.Wear_ID[PLY_Inventory.Inv_Wear_Equiped]["Icon"])
	%"Ready Tool Left Overlay".texture = load(PLY_Inventory.Tool_ID[PLY_Inventory.Inv_ToolL_Equiped]["Icon"])
	%"Ready Tool Right Overlay".texture = load(PLY_Inventory.Tool_ID[PLY_Inventory.Inv_ToolR_Equiped]["Icon"])
	
	#%"Ready Spell Overlay".texture = load(Item_Texture)
	%"Ready UItem 1 Overlay".texture = load(PLY_Inventory.UItem_ID[PLY_Inventory.Inv_Uitem1_Equiped]["Icon"])
	%"Ready UItem 2 Overlay".texture = load(PLY_Inventory.UItem_ID[PLY_Inventory.Inv_Uitem2_Equiped]["Icon"])
	%"Ready UItem 3 Overlay".texture = load(PLY_Inventory.UItem_ID[PLY_Inventory.Inv_Uitem3_Equiped]["Icon"])
