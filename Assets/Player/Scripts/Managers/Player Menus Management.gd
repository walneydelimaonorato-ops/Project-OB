extends Node

func _ready() -> void:
	print_rich("[color=#ffdf00]Player Menus Management Work[/color]")
	
	%"Ready Menu".visible = false
	%"Selection Menu".visible = false
	%"Choice Menu".visible = false
	%"Dialogue Menu".visible = false
	
	Ready_Menu_Overlay_Update()
	SignalBus.Ready_Menu_Overlay_Update.connect(Ready_Menu_Overlay_Update)
	SignalBus.focus_first_visible.connect(focus_first_visible)
	
	SignalBus.Menu_Setting.connect(Menu_Setting)
	SignalBus.SubMenu_Setting.connect(SubMenu_Setting)

func Menu_Setting(Menu: String):
	match Menu:
		"Ready":
			Global.Player_Data.Ready_Menu_Active = !Global.Player_Data.Ready_Menu_Active
			%"Ready Menu".visible = Global.Player_Data.Ready_Menu_Active
			if Global.Player_Data.Ready_Menu_Active:
				SignalBus.emit_signal("focus_first_visible", %"Ready Technical")
				Global.Player_Data.Current_Menu = "Ready"
				%"Menu Advance".play()
			elif not Global.Player_Data.Ready_Menu_Active:
				Global.Player_Data.Current_Menu = "null"
				%"Menu Return".play()
		"Selection":
			Global.Player_Data.Seletion_Menu_Active = !Global.Player_Data.Seletion_Menu_Active
			%"Selection Menu".visible = Global.Player_Data.Seletion_Menu_Active
			if Global.Player_Data.Seletion_Menu_Active:
				SignalBus.emit_signal("MSelection_Item_Sorting")
				Global.Player_Data.Current_Menu = "Selection"
				%"Menu Advance".play()
			elif not Global.Player_Data.Seletion_Menu_Active:
				SignalBus.emit_signal("focus_first_visible", %"Ready Wear and Tool")
				Global.Player_Data.Current_Menu = "Ready"
				%"Menu Return".play()
		"Keys":
			Global.Player_Data.Keys_Menu_Active = !Global.Player_Data.Keys_Menu_Active
			%"Keys Menu".visible = Global.Player_Data.Keys_Menu_Active
			if Global.Player_Data.Keys_Menu_Active:
				SignalBus.emit_signal("focus_first_visible", %Keys)
				Global.Player_Data.Player_Perms.Can_Move = false
				Global.Player_Data.Player_Perms.Can_Look = false
				Global.Player_Data.Current_Menu = "Keys"
				%"Menu Advance".play()
			elif not Global.Player_Data.Keys_Menu_Active:
				Global.Player_Data.Player_Perms.Can_Move = true
				Global.Player_Data.Player_Perms.Can_Look = true
				Global.Player_Data.Current_Menu = "null"
				%"Menu Return".play()

		
		_:
			print_rich("[color=#ff00ff]MANUAL ERROR: <Attempt to Exit Menu without valid parameters>[/color]")
			#get_tree().quit()

func SubMenu_Setting(SubMenu: String):
	Global.Player_Data.Current_SubMenu = SubMenu

func Exit_Menu(Menu_Back_To: String, Focus_First):
	$"Menu Return".play()
	SignalBus.emit_signal("Tool_Rotation")
	SignalBus.emit_signal("Side_HUD_Update")
	Menu_Setting(Menu_Back_To)
	SignalBus.emit_signal("focus_first_visible", Focus_First)

func focus_first_visible(container):
	for child in container.get_children():
		if child is Control:
			if child.visible and child.focus_mode != Control.FOCUS_NONE:
				child.grab_focus()
				return
			focus_first_visible(child)

func Ready_Menu_Overlay_Update():
	%"Ready Brace Overlay".texture = load(Global.Inventory_Data.Brace_ID[Global.Player_Data.Inv_Brace_Equiped]["Icon"])
	%"Ready Wear Overlay".texture = load(Global.Inventory_Data.Wear_ID[Global.Player_Data.Inv_Wear_Equiped]["Icon"])
	%"Ready Tool Left Overlay".texture = load(Global.Inventory_Data.Tool_ID[Global.Player_Data.Inv_ToolL_Equiped]["Icon"])
	%"Ready Tool Right Overlay".texture = load(Global.Inventory_Data.Tool_ID[Global.Player_Data.Inv_ToolR_Equiped]["Icon"])
	
	#%"Ready Spell Overlay".texture = load(Item_Texture)
	%"Ready UItem 1 Overlay".texture = load(Global.Inventory_Data.UItem_ID[Global.Player_Data.Inv_Uitem1_Equiped]["Icon"])
	%"Ready UItem 2 Overlay".texture = load(Global.Inventory_Data.UItem_ID[Global.Player_Data.Inv_Uitem2_Equiped]["Icon"])
	%"Ready UItem 3 Overlay".texture = load(Global.Inventory_Data.UItem_ID[Global.Player_Data.Inv_Uitem3_Equiped]["Icon"])
