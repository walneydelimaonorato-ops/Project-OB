extends Node

var Colidder

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BugBus.emit_signal("Report", "Player", "Player Management Working")
	
	IntSigBus.LOC_Value_Operator.connect(Value_Operate)
	IntSigBus.item_transfer.connect(Item_Pickup)
	IntSigBus.Sig_General_Interaction.connect(Geneneral_Interaction)
	
	get_viewport().gui_focus_changed.connect(_on_focus_changed)
	
#region Control Settup
	InputMap.action_erase_events("ui_accept")
	InputMap.action_erase_events("ui_cancel")
	InputMap.action_erase_events("ui_up")
	InputMap.action_erase_events("ui_down")
	InputMap.action_erase_events("ui_left")
	InputMap.action_erase_events("ui_right")
	
	match PLY_Var.Control_Mode:
		"Key":
			PLY_Input.Un_Forward = "In_Forward"
			PLY_Input.Un_Backward = "In_Backward"
			PLY_Input.Un_Left = "In_Left"
			PLY_Input.Un_Right = "In_Right"
			PLY_Input.Un_Jump = "In_Jump"
			PLY_Input.Un_Use_UItem = "In_Use_Item"
			PLY_Input.Un_Cycle_UItem = "In_Cycle_UItem"
			PLY_Input.Un_Sprint = "In_Sprint"
			PLY_Input.Un_Ready_Menu = "In_Pause"
			PLY_Input.Un_RPrimary_Tool_Use = "In_Mouse_R"
			PLY_Input.Un_LPrimary_Tool_Use = "In_Mouse_L"
			PLY_Input.Un_RSecondary_Tool_Use = ""
			PLY_Input.Un_LSecondary_Tool_Use = ""
			PLY_Input.Un_Tool_Alternive = "In_Tool_Alt"
			PLY_Input.Un_2Hand_Toggle = ""
			
			PLY_Input.UnUI_Up = "UI_Up"
			PLY_Input.UnUI_Down = "UI_Down"
			PLY_Input.UnUI_Left = "UI_Left"
			PLY_Input.UnUI_Right = "UI_Right"
			PLY_Input.UnUI_Accept = "UI_Accept"
			PLY_Input.UnUI_Accept = "UI_Accept"
			PLY_Input.UnUI_Unselect = "UI_Unselect"
			
			add_action_key("ui_accept", KEY_ENTER)
			add_action_key("ui_cancel", KEY_DELETE)
			add_action_key("ui_select", KEY_BACKSPACE)
			add_action_key("ui_up", KEY_UP)
			add_action_key("ui_down", KEY_DOWN)
			add_action_key("ui_left", KEY_LEFT)
			add_action_key("ui_right", KEY_RIGHT)
			
			PLY_Input.UnHUDIcon_Up = "uid://bceq01ccemc8o"
			PLY_Input.UnHUDIcon_Down = "uid://duiy16ed7ovil"
			PLY_Input.UnHUDIcon_Left = "uid://beqbo453gynf1"
			PLY_Input.UnHUDIcon_Right = "uid://cwgfmbtf38n10"
			PLY_Input.UnHUDIcon_Accept = "uid://0cjin76csgan"
			PLY_Input.UnHUDIcon_Return = "uid://d12fq4lnqjl7a"
			PLY_Input.UnHUDIcon_Unselect = "uid://06v660kr4rts"
			PLY_Input.UnHUDIcon_Interact = "uid://b1k76ih5cvb32"
		
		"Joy":
			PLY_Input.Un_Forward = "In_JoyL_Forward"
			PLY_Input.Un_Backward = "In_JoyL_Backward"
			PLY_Input.Un_Left = "In_JoyL_Left"
			PLY_Input.Un_Right = "In_JoyL_Right"
			PLY_Input.Un_Jump = "In_Joy_Jump"
			PLY_Input.Un_Use_UItem = "In_Joy_Use_Item"
			PLY_Input.Un_Cycle_UItem = "In_Joy_Cycle_UItem"
			PLY_Input.Un_Sprint = "In_Joy_Sprint"
			PLY_Input.Un_Ready_Menu = "In_Joy_Pause"
			PLY_Input.Un_RPrimary_Tool_Use = "In_Joy_R2"
			PLY_Input.Un_LPrimary_Tool_Use = "In_Joy_L2"
			PLY_Input.Un_RSecondary_Tool_Use = ""
			PLY_Input.Un_LSecondary_Tool_Use = ""
			PLY_Input.Un_Tool_Alternive = "In_Joy_Tool_Alt"
			PLY_Input.Un_2Hand_Toggle = ""
			
			PLY_Input.UnUI_Up = "UI_Joy_Up"
			PLY_Input.UnUI_Down = "UI_Joy_Down"
			PLY_Input.UnUI_Left = "UI_Joy_Left"
			PLY_Input.UnUI_Right = "UI_Joy_Right"
			PLY_Input.UnUI_Accept = "UI_Joy_Accept"
			PLY_Input.UnUI_Accept = "UI_Joy_Accept"
			PLY_Input.UnUI_Unselect = "UI_Joy_Unselect"
			
			add_action_button("ui_accept", JOY_BUTTON_A)
			add_action_button("ui_cancel", JOY_BUTTON_X)
			add_action_button("ui_select", JOY_BUTTON_B)
			add_action_button("ui_up", JOY_BUTTON_DPAD_UP)
			add_action_button("ui_down", JOY_BUTTON_DPAD_DOWN)
			add_action_button("ui_left", JOY_BUTTON_DPAD_LEFT)
			add_action_button("ui_right", JOY_BUTTON_DPAD_RIGHT)
			
			PLY_Input.UnHUDIcon_Up = "uid://bumwv083liw5g"
			PLY_Input.UnHUDIcon_Down = "uid://dtmfxjgftvudj"
			PLY_Input.UnHUDIcon_Left = "uid://ovx7jbm3tdnl"
			PLY_Input.UnHUDIcon_Right = "uid://8p350oejc5ln"
			PLY_Input.UnHUDIcon_Accept = "uid://ctvxynwec6rsy"
			PLY_Input.UnHUDIcon_Return = "uid://pnd0l1xdxt3x"
			PLY_Input.UnHUDIcon_Unselect = "uid://sdcs6qj0qc6x"
			PLY_Input.UnHUDIcon_Interact = "uid://sdcs6qj0qc6x"
#endregion

func _process(delta: float) -> void:
	PLY_Var.Health = clamp(PLY_Var.Health, 0, PLY_Var.Health_Max)
	PLY_Var.Stamina = clamp(PLY_Var.Stamina, 0, PLY_Var.Stamina_Max)

func Value_Operate(Operation: bool, Value: String, Quantity: float):
	if Operation == false:
		match Value:
			"Health":
				PLY_Var.Health -= Quantity
			"Stamina": 
				PLY_Var.Stamina -= Quantity
				PLY_Var.Stamina_Regeneration_Active = false
				PLY_Var.Stamina_Regeneration_Delay_Timer.start()
	elif Operation == true:
		match Value:
			"Health":
				PLY_Var.Health += Quantity
			"Stamina": 
				PLY_Var.Stamina += Quantity
				PLY_Var.Stamina_Regeneration_Active = false
				PLY_Var.Stamina_Regeneration_Delay_Timer.start()
	
	IntSigBus.emit_signal("Side_Status_Update")
	IntSigBus.emit_signal("Player_Permissions_Conditionals")


func _on_focus_changed(node: Control):
	if node:
		#print(node.name)
		PLY_Var.Current_Focus = node.name

func add_action_key(action, keycode):
	var ev = InputEventKey.new()
	ev.physical_keycode = keycode
	InputMap.action_add_event(action, ev)

func add_action_button(action, button):
	var ev = InputEventJoypadButton.new()
	ev.button_index = button
	InputMap.action_add_event(action, ev)

func Geneneral_Interaction(Ray, Method):
	if !Ray.is_colliding(): # If ray isnt colidding, nothing happens
		return
	elif Ray.is_colliding():
		Colidder = Ray.get_collider()
		if Colidder.get_parent().has_method(Method): # If the collider has the method
			Colidder.get_parent().call(Method) # Executes the method
			IntSigBus.emit_signal("Sig_Interaction_HUD_Return", Colidder)

func Item_Pickup(Item_Sys_Name, Item_Type, Item_Quantity):
	match Item_Type:
		"Special":
			GLOBAL.Player_Data.Tool_ID[Item_Sys_Name]["picked?"] = true
		"Ordinary":
			pass
