extends Node
@onready var PlayerVars: Node = %"Player Stats"

var Colidder

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Player Management working")
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	Regeneration_Timer_Startup()
	PlayerVars.data.Stamina_Regeneration_Delay_Timer.timeout.connect(Start_Stamina_Regeneration)
	
	get_viewport().gui_focus_changed.connect(_on_focus_changed)

#region Control Settup
	InputMap.action_erase_events("ui_accept")
	InputMap.action_erase_events("ui_cancel")
	InputMap.action_erase_events("ui_up")
	InputMap.action_erase_events("ui_down")
	InputMap.action_erase_events("ui_left")
	InputMap.action_erase_events("ui_right")
	
	match PlayerVars.data.Control_Mode:
		"Key":
			PlayerVars.data.Un_Forward = "In_Forward"
			PlayerVars.data.Un_Backward = "In_Backward"
			PlayerVars.data.Un_Left = "In_Left"
			PlayerVars.data.Un_Right = "In_Right"
			PlayerVars.data.Un_Jump = "In_Jump"
			PlayerVars.data.Un_Use_UItem = "In_Use_Item"
			PlayerVars.data.Un_Sprint = "In_Sprint"
			PlayerVars.data.Un_Ready_Menu = "In_Pause"
			PlayerVars.data.Un_RPrimary_Tool_Use = "In_Mouse_R"
			PlayerVars.data.Un_LPrimary_Tool_Use = "In_Mouse_L"
			PlayerVars.data.Un_RSecondary_Tool_Use = ""
			PlayerVars.data.Un_LSecondary_Tool_Use = ""
			PlayerVars.data.Un_Tool_Alternive = "In_Tool_Alt"
			PlayerVars.data.Un_2Hand_Toggle = ""
			
			PlayerVars.data.UnUI_Up = "UI_Up"
			PlayerVars.data.UnUI_Down = "UI_Down"
			PlayerVars.data.UnUI_Left = "UI_Left"
			PlayerVars.data.UnUI_Right = "UI_Right"
			PlayerVars.data.UnUI_Accept = "UI_Accept"
			PlayerVars.data.UnUI_Accept = "UI_Accept"
			PlayerVars.data.UnUI_Unselect = "UI_Unselect"
			
			add_action_key("ui_accept", KEY_ENTER)
			add_action_key("ui_cancel", KEY_SHIFT)
			add_action_key("ui_select", KEY_BACKSPACE)
			add_action_key("ui_up", KEY_UP)
			add_action_key("ui_down", KEY_DOWN)
			add_action_key("ui_left", KEY_LEFT)
			add_action_key("ui_right", KEY_RIGHT)
			
			PlayerVars.data.UnHUDIcon_Up = "uid://bceq01ccemc8o"
			PlayerVars.data.UnHUDIcon_Down = "uid://duiy16ed7ovil"
			PlayerVars.data.UnHUDIcon_Left = "uid://beqbo453gynf1"
			PlayerVars.data.UnHUDIcon_Right = "uid://cwgfmbtf38n10"
			PlayerVars.data.UnHUDIcon_Accept = "uid://0cjin76csgan"
			PlayerVars.data.UnHUDIcon_Return = "uid://d12fq4lnqjl7a"
			PlayerVars.data.UnHUDIcon_Unselect = "uid://06v660kr4rts"
			PlayerVars.data.UnHUDIcon_Interact = "uid://b1k76ih5cvb32"
		
		"Joy":
			PlayerVars.data.Un_Forward = "In_JoyL_Forward"
			PlayerVars.data.Un_Backward = "In_JoyL_Backward"
			PlayerVars.data.Un_Left = "In_JoyL_Left"
			PlayerVars.data.Un_Right = "In_JoyL_Right"
			PlayerVars.data.Un_Jump = "In_Joy_Jump"
			PlayerVars.data.Un_Use_UItem = "In_Joy_Use_Item"
			PlayerVars.data.Un_Sprint = "In_Joy_Sprint"
			PlayerVars.data.Un_Ready_Menu = "In_Joy_Pause"
			PlayerVars.data.Un_RPrimary_Tool_Use = "In_Joy_R2"
			PlayerVars.data.Un_LPrimary_Tool_Use = "In_Joy_L2"
			PlayerVars.data.Un_RSecondary_Tool_Use = ""
			PlayerVars.data.Un_LSecondary_Tool_Use = ""
			PlayerVars.data.Un_Tool_Alternive = "In_Joy_Tool_Alt"
			PlayerVars.data.Un_2Hand_Toggle = ""
			
			PlayerVars.data.UnUI_Up = "UI_Joy_Up"
			PlayerVars.data.UnUI_Down = "UI_Joy_Down"
			PlayerVars.data.UnUI_Left = "UI_Joy_Left"
			PlayerVars.data.UnUI_Right = "UI_Joy_Right"
			PlayerVars.data.UnUI_Accept = "UI_Joy_Accept"
			PlayerVars.data.UnUI_Accept = "UI_Joy_Accept"
			PlayerVars.data.UnUI_Unselect = "UI_Joy_Unselect"
			
			add_action_button("ui_accept", JOY_BUTTON_A)
			add_action_button("ui_cancel", JOY_BUTTON_X)
			add_action_button("ui_select", JOY_BUTTON_B)
			add_action_button("ui_up", JOY_BUTTON_DPAD_UP)
			add_action_button("ui_down", JOY_BUTTON_DPAD_DOWN)
			add_action_button("ui_left", JOY_BUTTON_DPAD_LEFT)
			add_action_button("ui_right", JOY_BUTTON_DPAD_RIGHT)
			
			PlayerVars.data.UnHUDIcon_Up = "uid://bumwv083liw5g"
			PlayerVars.data.UnHUDIcon_Down = "uid://dtmfxjgftvudj"
			PlayerVars.data.UnHUDIcon_Left = "uid://ovx7jbm3tdnl"
			PlayerVars.data.UnHUDIcon_Right = "uid://8p350oejc5ln"
			PlayerVars.data.UnHUDIcon_Accept = "uid://ctvxynwec6rsy"
			PlayerVars.data.UnHUDIcon_Return = "uid://pnd0l1xdxt3x"
			PlayerVars.data.UnHUDIcon_Unselect = "uid://sdcs6qj0qc6x"
			PlayerVars.data.UnHUDIcon_Interact = "uid://sdcs6qj0qc6x"
#endregion

#region Stamina Regeneration Process

func Regeneration_Timer_Startup():
	PlayerVars.data.Stamina_Regeneration_Delay_Timer = Timer.new()
	PlayerVars.data.Stamina_Regeneration_Delay_Timer.wait_time = PlayerVars.data.Stamina_Regeneration_Amount
	PlayerVars.data.Stamina_Regeneration_Delay_Timer.one_shot = true
	add_child(PlayerVars.data.Stamina_Regeneration_Delay_Timer)

func Start_Stamina_Regeneration():
	PlayerVars.data.Stamina_Regeneration_Active = true

func Stamina_Regeneration_Process(delta):
	if PlayerVars.data.Stamina_Regeneration_Active == true and PlayerVars.data.Stamina < PlayerVars.data.Stamina_Max:
		PlayerVars.data.Stamina += PlayerVars.data.Stamina_Regeneration_Rate * delta
		if PlayerVars.data.Stamina >= PlayerVars.data.Stamina_Max:
			PlayerVars.data.Stamina = PlayerVars.data.Stamina_Max
			PlayerVars.data.Stamina_Regeneration_Active = false
#endregion

func Stats_Decrease(Type, Value):
	if Type == "Health":
		PlayerVars.data.Health -= Value
	elif Type == "Stamina": 
		PlayerVars.data.Stamina -= Value
		PlayerVars.data.Stamina_Regeneration_Active = false
		PlayerVars.data.Stamina_Regeneration_Delay_Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	PlayerVars.data.Health = clamp(PlayerVars.data.Health, 0, PlayerVars.data.Health_Max)
	PlayerVars.data.Stamina = clamp(PlayerVars.data.Stamina, 0, PlayerVars.data.Stamina_Max)
	
	Stamina_Regeneration_Process(delta)
	
	#Geneneral_Interaction(%Ray2, "HUD_Element")
	

func _on_focus_changed(node: Control):
	if node:
		#print(node.name)
		PlayerVars.data.Current_Focus = node.name
		
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

func Set_Menu(Next_Menu):
	PlayerVars.data.Current_Menu = Next_Menu
