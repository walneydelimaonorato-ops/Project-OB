extends Node
@onready var PlayerRes: Node = %"Player Stats"

var Colidder

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Player Management working")
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	Regeneration_Timer_Startup()
	PlayerRes.data.Stamina_Regeneration_Delay_Timer.timeout.connect(Start_Stamina_Regeneration)
	
	get_viewport().gui_focus_changed.connect(_on_focus_changed)
	
#region Control Settup
	InputMap.action_erase_events("ui_accept")
	InputMap.action_erase_events("ui_cancel")
	InputMap.action_erase_events("ui_up")
	InputMap.action_erase_events("ui_down")
	InputMap.action_erase_events("ui_left")
	InputMap.action_erase_events("ui_right")
	
	match PlayerRes.data.Control_Mode:
		"Key":
			PlayerRes.data.Un_Forward = "In_Forward"
			PlayerRes.data.Un_Backward = "In_Backward"
			PlayerRes.data.Un_Left = "In_Left"
			PlayerRes.data.Un_Right = "In_Right"
			PlayerRes.data.Un_Jump = "In_Jump"
			PlayerRes.data.Un_Use_UItem = "In_Use_Item"
			PlayerRes.data.Un_Sprint = "In_Sprint"
			PlayerRes.data.Un_Ready_Menu = "In_Pause"
			PlayerRes.data.Un_RPrimary_Tool_Use = "In_Mouse_R"
			PlayerRes.data.Un_LPrimary_Tool_Use = "In_Mouse_L"
			PlayerRes.data.Un_RSecondary_Tool_Use = ""
			PlayerRes.data.Un_LSecondary_Tool_Use = ""
			PlayerRes.data.Un_Tool_Alternive = "In_Tool_Alt"
			PlayerRes.data.Un_2Hand_Toggle = ""
			
			PlayerRes.data.UnUI_Up = "UI_Up"
			PlayerRes.data.UnUI_Down = "UI_Down"
			PlayerRes.data.UnUI_Left = "UI_Left"
			PlayerRes.data.UnUI_Right = "UI_Right"
			PlayerRes.data.UnUI_Accept = "UI_Accept"
			PlayerRes.data.UnUI_Accept = "UI_Accept"
			PlayerRes.data.UnUI_Unselect = "UI_Unselect"
			
			add_action_key("ui_accept", KEY_ENTER)
			add_action_key("ui_cancel", KEY_SHIFT)
			add_action_key("ui_select", KEY_BACKSPACE)
			add_action_key("ui_up", KEY_UP)
			add_action_key("ui_down", KEY_DOWN)
			add_action_key("ui_left", KEY_LEFT)
			add_action_key("ui_right", KEY_RIGHT)
			
			PlayerRes.data.UnHUDIcon_Up = "uid://bceq01ccemc8o"
			PlayerRes.data.UnHUDIcon_Down = "uid://duiy16ed7ovil"
			PlayerRes.data.UnHUDIcon_Left = "uid://beqbo453gynf1"
			PlayerRes.data.UnHUDIcon_Right = "uid://cwgfmbtf38n10"
			PlayerRes.data.UnHUDIcon_Accept = "uid://0cjin76csgan"
			PlayerRes.data.UnHUDIcon_Return = "uid://d12fq4lnqjl7a"
			PlayerRes.data.UnHUDIcon_Unselect = "uid://06v660kr4rts"
			PlayerRes.data.UnHUDIcon_Interact = "uid://b1k76ih5cvb32"
		
		"Joy":
			PlayerRes.data.Un_Forward = "In_JoyL_Forward"
			PlayerRes.data.Un_Backward = "In_JoyL_Backward"
			PlayerRes.data.Un_Left = "In_JoyL_Left"
			PlayerRes.data.Un_Right = "In_JoyL_Right"
			PlayerRes.data.Un_Jump = "In_Joy_Jump"
			PlayerRes.data.Un_Use_UItem = "In_Joy_Use_Item"
			PlayerRes.data.Un_Sprint = "In_Joy_Sprint"
			PlayerRes.data.Un_Ready_Menu = "In_Joy_Pause"
			PlayerRes.data.Un_RPrimary_Tool_Use = "In_Joy_R2"
			PlayerRes.data.Un_LPrimary_Tool_Use = "In_Joy_L2"
			PlayerRes.data.Un_RSecondary_Tool_Use = ""
			PlayerRes.data.Un_LSecondary_Tool_Use = ""
			PlayerRes.data.Un_Tool_Alternive = "In_Joy_Tool_Alt"
			PlayerRes.data.Un_2Hand_Toggle = ""
			
			PlayerRes.data.UnUI_Up = "UI_Joy_Up"
			PlayerRes.data.UnUI_Down = "UI_Joy_Down"
			PlayerRes.data.UnUI_Left = "UI_Joy_Left"
			PlayerRes.data.UnUI_Right = "UI_Joy_Right"
			PlayerRes.data.UnUI_Accept = "UI_Joy_Accept"
			PlayerRes.data.UnUI_Accept = "UI_Joy_Accept"
			PlayerRes.data.UnUI_Unselect = "UI_Joy_Unselect"
			
			add_action_button("ui_accept", JOY_BUTTON_A)
			add_action_button("ui_cancel", JOY_BUTTON_X)
			add_action_button("ui_select", JOY_BUTTON_B)
			add_action_button("ui_up", JOY_BUTTON_DPAD_UP)
			add_action_button("ui_down", JOY_BUTTON_DPAD_DOWN)
			add_action_button("ui_left", JOY_BUTTON_DPAD_LEFT)
			add_action_button("ui_right", JOY_BUTTON_DPAD_RIGHT)
			
			PlayerRes.data.UnHUDIcon_Up = "uid://bumwv083liw5g"
			PlayerRes.data.UnHUDIcon_Down = "uid://dtmfxjgftvudj"
			PlayerRes.data.UnHUDIcon_Left = "uid://ovx7jbm3tdnl"
			PlayerRes.data.UnHUDIcon_Right = "uid://8p350oejc5ln"
			PlayerRes.data.UnHUDIcon_Accept = "uid://ctvxynwec6rsy"
			PlayerRes.data.UnHUDIcon_Return = "uid://pnd0l1xdxt3x"
			PlayerRes.data.UnHUDIcon_Unselect = "uid://sdcs6qj0qc6x"
			PlayerRes.data.UnHUDIcon_Interact = "uid://sdcs6qj0qc6x"
#endregion

func _process(delta: float) -> void:
	PlayerRes.data.Health = clamp(PlayerRes.data.Health, 0, PlayerRes.data.Health_Max)
	PlayerRes.data.Stamina = clamp(PlayerRes.data.Stamina, 0, PlayerRes.data.Stamina_Max)
	
	Stamina_Regeneration_Process(delta)
	
	#Geneneral_Interaction(%Ray2, "HUD_Element")

#region Stamina Regeneration Process
func Regeneration_Timer_Startup():
	PlayerRes.data.Stamina_Regeneration_Delay_Timer = Timer.new()
	PlayerRes.data.Stamina_Regeneration_Delay_Timer.wait_time = PlayerRes.data.Stamina_Regeneration_Amount
	PlayerRes.data.Stamina_Regeneration_Delay_Timer.one_shot = true
	add_child(PlayerRes.data.Stamina_Regeneration_Delay_Timer)

func Start_Stamina_Regeneration():
	PlayerRes.data.Stamina_Regeneration_Active = true

func Stamina_Regeneration_Process(delta):
	if PlayerRes.data.Stamina_Regeneration_Active == true and PlayerRes.data.Stamina < PlayerRes.data.Stamina_Max:
		PlayerRes.data.Stamina += PlayerRes.data.Stamina_Regeneration_Rate * delta
		if PlayerRes.data.Stamina >= PlayerRes.data.Stamina_Max:
			PlayerRes.data.Stamina = PlayerRes.data.Stamina_Max
			PlayerRes.data.Stamina_Regeneration_Active = false
#endregion

func Stats_Decrease(Type, Value):
	if Type == "Health":
		PlayerRes.data.Health -= Value
	elif Type == "Stamina": 
		PlayerRes.data.Stamina -= Value
		PlayerRes.data.Stamina_Regeneration_Active = false
		PlayerRes.data.Stamina_Regeneration_Delay_Timer.start()

func _on_focus_changed(node: Control):
	if node:
		#print(node.name)
		PlayerRes.data.Current_Focus = node.name

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
		if Colidder.get_parent().has_method(Method): # Get the collider and execute the method
			Colidder.get_parent().call(Method) # Executes the method
			#print(Colidder)

func Set_Menu(Switch: bool, Next_Menu: String):
	if Switch == true:
		PlayerRes.data.Current_Menu = Next_Menu
	elif Switch == false:
		PlayerRes.data.Current_SubMenu = Next_Menu

@warning_ignore("unused_parameter")
func Inventory_Update(Item):
	match PlayerRes.data.Current_SubMenu:
		"Brace menu":
			pass
		"Wear menu":
			pass
		"Tool Right menu":
			pass
		"Tool Left menu":
			pass
		"Spell menu":
			pass
		"UItem1 menu":
			pass
		"UItem2 menu":
			pass
		"UItem3 menu":
			pass
