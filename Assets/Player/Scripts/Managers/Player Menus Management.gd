extends Node

func _ready() -> void:
	print_rich("[color=#ffdf00]Player Menus Management Work[/color]")
	
	%"Ready Menu".visible = false
	%"Selection Menu".visible = false
	%"Choice Menu".visible = false
	%"Dialogue Menu".visible = false
	
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
		"":
			pass
		
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

func Ready_Menu_Overlay_Update(Menu_Slot, Item_Texture):
	match Menu_Slot:
		"Ready Inventory":
			pass
		"Ready Settings":
			pass
	
		"Ready Brace":
			%"Ready Brace Overlay".texture = load(Item_Texture)
		"Ready Wear":
			%"Ready Wear Overlay".texture = load(Item_Texture)
		"Ready Tool Left":
			%"Ready Tool Left Overlay".texture = load(Item_Texture)
		"Ready Tool Right":
			%"Ready Tool Right Overlay".texture = load(Item_Texture)
	
		"Ready Spell":
			%"Ready Spell Overlay".texture = load(Item_Texture)
		"Ready UItem 1":
			%"Ready UItem 1 Overlay".texture = load(Item_Texture)
		"Ready UItem 2":
			%"Ready UItem 2 Overlay".texture = load(Item_Texture)
		"Ready UItem 3":
			%"Ready UItem 3 Overlay".texture = load(Item_Texture)
		_:
			print_rich("[color=#ff00ff]MANUAL ERROR: <Ready_Menu_Visual_Update> Argument out of scope[/color]")
