extends Node
@onready var PlayerRes: Node = %"Player Stats"

var Colidder

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_rich("[color=#ffdf00]Player Management Working[/color]")
	#print("Instance ID", self.get_instance_id())
	
	
	SignalBus.Variable_Operation.connect(Stats_Decrease)
	SignalBus.Variable_Operation.connect(Stats_Increase)
	SignalBus.item_transfer.connect(Item_Pickup)
	SignalBus.player_stat_change.connect(Stats_Decrease)
	SignalBus.player_stat_change.connect(Stats_Increase)
	SignalBus.Sig_General_Interaction.connect(Geneneral_Interaction)
	#SignalBus.Sig_Set_Menu.connect(Set_Menu)
	
	# Hold_Tap_Timing(Global.Player_Data.Un_Tool_Alternive, get_process_delta_time())
	get_viewport().gui_focus_changed.connect(_on_focus_changed)
	
#region Control Settup
	InputMap.action_erase_events("ui_accept")
	InputMap.action_erase_events("ui_cancel")
	InputMap.action_erase_events("ui_up")
	InputMap.action_erase_events("ui_down")
	InputMap.action_erase_events("ui_left")
	InputMap.action_erase_events("ui_right")
	
	match Global.Player_Data.Control_Mode:
		"Key":
			Global.Player_Data.Un_Forward = "In_Forward"
			Global.Player_Data.Un_Backward = "In_Backward"
			Global.Player_Data.Un_Left = "In_Left"
			Global.Player_Data.Un_Right = "In_Right"
			Global.Player_Data.Un_Jump = "In_Jump"
			Global.Player_Data.Un_Use_UItem = "In_Use_Item"
			Global.Player_Data.Un_Cycle_UItem = "In_Cycle_UItem"
			Global.Player_Data.Un_Sprint = "In_Sprint"
			Global.Player_Data.Un_Ready_Menu = "In_Pause"
			Global.Player_Data.Un_RPrimary_Tool_Use = "In_Mouse_R"
			Global.Player_Data.Un_LPrimary_Tool_Use = "In_Mouse_L"
			Global.Player_Data.Un_RSecondary_Tool_Use = ""
			Global.Player_Data.Un_LSecondary_Tool_Use = ""
			Global.Player_Data.Un_Tool_Alternive = "In_Tool_Alt"
			Global.Player_Data.Un_2Hand_Toggle = ""
			
			Global.Player_Data.UnUI_Up = "UI_Up"
			Global.Player_Data.UnUI_Down = "UI_Down"
			Global.Player_Data.UnUI_Left = "UI_Left"
			Global.Player_Data.UnUI_Right = "UI_Right"
			Global.Player_Data.UnUI_Accept = "UI_Accept"
			Global.Player_Data.UnUI_Accept = "UI_Accept"
			Global.Player_Data.UnUI_Unselect = "UI_Unselect"
			
			add_action_key("ui_accept", KEY_ENTER)
			add_action_key("ui_cancel", KEY_DELETE)
			add_action_key("ui_select", KEY_BACKSPACE)
			add_action_key("ui_up", KEY_UP)
			add_action_key("ui_down", KEY_DOWN)
			add_action_key("ui_left", KEY_LEFT)
			add_action_key("ui_right", KEY_RIGHT)
			
			Global.Player_Data.UnHUDIcon_Up = "uid://bceq01ccemc8o"
			Global.Player_Data.UnHUDIcon_Down = "uid://duiy16ed7ovil"
			Global.Player_Data.UnHUDIcon_Left = "uid://beqbo453gynf1"
			Global.Player_Data.UnHUDIcon_Right = "uid://cwgfmbtf38n10"
			Global.Player_Data.UnHUDIcon_Accept = "uid://0cjin76csgan"
			Global.Player_Data.UnHUDIcon_Return = "uid://d12fq4lnqjl7a"
			Global.Player_Data.UnHUDIcon_Unselect = "uid://06v660kr4rts"
			Global.Player_Data.UnHUDIcon_Interact = "uid://b1k76ih5cvb32"
		
		"Joy":
			Global.Player_Data.Un_Forward = "In_JoyL_Forward"
			Global.Player_Data.Un_Backward = "In_JoyL_Backward"
			Global.Player_Data.Un_Left = "In_JoyL_Left"
			Global.Player_Data.Un_Right = "In_JoyL_Right"
			Global.Player_Data.Un_Jump = "In_Joy_Jump"
			Global.Player_Data.Un_Use_UItem = "In_Joy_Use_Item"
			Global.Player_Data.Un_Cycle_UItem = "In_Joy_Cycle_UItem"
			Global.Player_Data.Un_Sprint = "In_Joy_Sprint"
			Global.Player_Data.Un_Ready_Menu = "In_Joy_Pause"
			Global.Player_Data.Un_RPrimary_Tool_Use = "In_Joy_R2"
			Global.Player_Data.Un_LPrimary_Tool_Use = "In_Joy_L2"
			Global.Player_Data.Un_RSecondary_Tool_Use = ""
			Global.Player_Data.Un_LSecondary_Tool_Use = ""
			Global.Player_Data.Un_Tool_Alternive = "In_Joy_Tool_Alt"
			Global.Player_Data.Un_2Hand_Toggle = ""
			
			Global.Player_Data.UnUI_Up = "UI_Joy_Up"
			Global.Player_Data.UnUI_Down = "UI_Joy_Down"
			Global.Player_Data.UnUI_Left = "UI_Joy_Left"
			Global.Player_Data.UnUI_Right = "UI_Joy_Right"
			Global.Player_Data.UnUI_Accept = "UI_Joy_Accept"
			Global.Player_Data.UnUI_Accept = "UI_Joy_Accept"
			Global.Player_Data.UnUI_Unselect = "UI_Joy_Unselect"
			
			add_action_button("ui_accept", JOY_BUTTON_A)
			add_action_button("ui_cancel", JOY_BUTTON_X)
			add_action_button("ui_select", JOY_BUTTON_B)
			add_action_button("ui_up", JOY_BUTTON_DPAD_UP)
			add_action_button("ui_down", JOY_BUTTON_DPAD_DOWN)
			add_action_button("ui_left", JOY_BUTTON_DPAD_LEFT)
			add_action_button("ui_right", JOY_BUTTON_DPAD_RIGHT)
			
			Global.Player_Data.UnHUDIcon_Up = "uid://bumwv083liw5g"
			Global.Player_Data.UnHUDIcon_Down = "uid://dtmfxjgftvudj"
			Global.Player_Data.UnHUDIcon_Left = "uid://ovx7jbm3tdnl"
			Global.Player_Data.UnHUDIcon_Right = "uid://8p350oejc5ln"
			Global.Player_Data.UnHUDIcon_Accept = "uid://ctvxynwec6rsy"
			Global.Player_Data.UnHUDIcon_Return = "uid://pnd0l1xdxt3x"
			Global.Player_Data.UnHUDIcon_Unselect = "uid://sdcs6qj0qc6x"
			Global.Player_Data.UnHUDIcon_Interact = "uid://sdcs6qj0qc6x"
#endregion

func _process(delta: float) -> void:
	Global.Player_Data.Health = clamp(Global.Player_Data.Health, 0, Global.Player_Data.Health_Max)
	Global.Player_Data.Stamina = clamp(Global.Player_Data.Stamina, 0, Global.Player_Data.Stamina_Max)

func Stats_Decrease(Operation, Type, Value):
	if Operation == "Decrease":
		match Type:
			"Health":
				Global.Player_Data.Health -= Value
			"Stamina": 
				Global.Player_Data.Stamina -= Value
				Global.Player_Data.Stamina_Regeneration_Active = false
				Global.Player_Data.Stamina_Regeneration_Delay_Timer.start()
	else:
		pass
	SignalBus.emit_signal("Side_Status_Update")
	SignalBus.emit_signal("Player_Permissions_Conditionals")

func Stats_Increase(Operation, Type, Value):
	if Operation == "Increase":
		match Type:
			"Health":
				Global.Player_Data.Health += Value
	else:
		pass
	SignalBus.emit_signal("Side_Status_Update")

func _on_focus_changed(node: Control):
	if node:
		#print(node.name)
		Global.Player_Data.Current_Focus = node.name

func add_action_key(action, keycode):
	var ev = InputEventKey.new()
	ev.physical_keycode = keycode
	InputMap.action_add_event(action, ev)

func add_action_button(action, button):
	var ev = InputEventJoypadButton.new()
	ev.button_index = button
	InputMap.action_add_event(action, ev)

func Geneneral_Interaction(Ray, Method):
	#var Method_String = str(Method) # Transfroms the un-inferred argument into an string
	if !Ray.is_colliding(): # If ray isnt colidding, nothing happens
		return
	elif Ray.is_colliding():
		Colidder = Ray.get_collider()
		if Colidder.get_parent().has_method(Method): # If the collider has the method
			Colidder.get_parent().call(Method) # Executes the method
			SignalBus.emit_signal("Sig_Interaction_HUD_Return", Colidder)
			#print(Colidder)

#func Set_Menu(Switch: bool, Next_Menu: String):
	#if Switch == true:
		#Global.Player_Data.Current_Menu = Next_Menu
	#elif Switch == false:
		#Global.Player_Data.Current_SubMenu = Next_Menu



func Item_Pickup(Item_Sys_Name, Item_Type, Item_Quantity):
	match Item_Type:
		"Special":
			Global.Player_Data.Tool_ID[Item_Sys_Name]["picked?"] = true
		"Ordinary":
			pass
