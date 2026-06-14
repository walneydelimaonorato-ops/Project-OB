extends Node
@onready var PlayerRes: Node = %"Player Stats"

#region References
@onready var General_Animations: AnimationPlayer = $"../../Head/Eyes/Models/General Animations"

@onready var Arm_Left_Rig: Node3D = $"../../Head/Eyes/Models/Master Rig/Arm Left Rig"
@onready var Arm_Right_Rig: Node3D = $"../../Head/Eyes/Models/Master Rig/Arm Right Rig"

@onready var Sword_Rig: Node3D = $"../../Head/Eyes/Models/Master Rig/Sword Rig"

@onready var Dagger_Rig: Node3D = $"../../Head/Eyes/Models/Master Rig/Dagger Rig"

@onready var Assault_Rig: Node3D = $"../../Head/Eyes/Models/Master Rig/Assault Rig"
@onready var Assault_Shoot: AudioStreamPlayer2D = $"../../Head/Eyes/Models/Sounds/Assault Shoot"

@onready var HandGun_Rig: Node3D = $"../../Head/Eyes/Models/Master Rig/Hand Gun Rig"
@onready var HandGun_Shoot: AudioStreamPlayer2D = $"../../Head/Eyes/Models/Sounds/HandGun Shoot"

@onready var Latern_Rig: Node3D = $"../../Head/Eyes/Models/Master Rig/Latern Rig"
#endregion

var Colidder

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Player Management working")
	print("Instance ID", self.get_instance_id())
	
	Regeneration_Timer_Startup()
	Global.Player_Data.Stamina_Regeneration_Delay_Timer.timeout.connect(Start_Stamina_Regeneration)
	
	Tool_Rotation()
	SignalBus.Variable_Operation.connect(Stats_Decrease)
	SignalBus.Variable_Operation.connect(Stats_Increase)
	SignalBus.Tool_Rotation.connect(Tool_Rotation)
	SignalBus.item_transfer.connect(Item_Pickup)
	SignalBus.player_stat_change.connect(Stats_Decrease)
	SignalBus.player_stat_change.connect(Stats_Increase)
	SignalBus.Sig_General_Interaction.connect(Geneneral_Interaction)
	SignalBus.Sig_Set_Menu.connect(Set_Menu)
	SignalBus.Tap_Hold_Interval.connect(Hold_Tap_Interval)
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
			add_action_key("ui_cancel", KEY_SHIFT)
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
	if not Global.Player_Data.TH_Active:
		return
	Global.Player_Data.TH_Timing += delta
	
		
	
	Global.Player_Data.Health = clamp(Global.Player_Data.Health, 0, Global.Player_Data.Health_Max)
	Global.Player_Data.Stamina = clamp(Global.Player_Data.Stamina, 0, Global.Player_Data.Stamina_Max)
	
	Stamina_Regeneration_Process(delta)
	
	#Geneneral_Interaction(%Ray2, "HUD_Element")

#region Stamina Regeneration Process
func Regeneration_Timer_Startup():
	Global.Player_Data.Stamina_Regeneration_Delay_Timer = Timer.new()
	Global.Player_Data.Stamina_Regeneration_Delay_Timer.wait_time = Global.Player_Data.Stamina_Regeneration_Amount
	Global.Player_Data.Stamina_Regeneration_Delay_Timer.one_shot = true
	add_child(Global.Player_Data.Stamina_Regeneration_Delay_Timer)

func Start_Stamina_Regeneration():
	Global.Player_Data.Stamina_Regeneration_Active = true

func Stamina_Regeneration_Process(delta):
	if Global.Player_Data.Stamina_Regeneration_Active == true and Global.Player_Data.Stamina < Global.Player_Data.Stamina_Max:
		Global.Player_Data.Stamina += Global.Player_Data.Stamina_Regeneration_Rate * delta
		SignalBus.emit_signal("HUD_Update")
		if Global.Player_Data.Stamina >= Global.Player_Data.Stamina_Max:
			Global.Player_Data.Stamina = Global.Player_Data.Stamina_Max
			Global.Player_Data.Stamina_Regeneration_Active = false
#endregion

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
	SignalBus.emit_signal("HUD_Update")

func Stats_Increase(Operation, Type, Value):
	if Operation == "Increase":
		match Type:
			"Health":
				Global.Player_Data.Health += Value
	else:
		pass
	SignalBus.emit_signal("HUD_Update")

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

func Set_Menu(Switch: bool, Next_Menu: String):
	if Switch == true:
		Global.Player_Data.Current_Menu = Next_Menu
	elif Switch == false:
		Global.Player_Data.Current_SubMenu = Next_Menu


#func Inventory_Update(Item):
	#match Global.Player_Data.Current_SubMenu:
		#"Brace menu":
			#pass
		#"Wear menu":
			#pass
		#"Tool Right menu":
			#pass
		#"Tool Left menu":
			#pass
		#"Spell menu":
			#pass
		#"UItem1 menu":
			#pass
		#"UItem2 menu":
			#pass
		#"UItem3 menu":
			#pass

func Tool_Rotation():
	Arm_Right_Rig.visible = false
	Arm_Left_Rig.visible = false
	Sword_Rig.visible = false
	Dagger_Rig.visible = false
	HandGun_Rig.visible = false
	Assault_Rig.visible = false
	
#region Tools
	match Global.Player_Data.Inv_ToolR_Equiped:
		"null":
			Arm_Right_Rig.visible = true
		"Sword":
			Sword_Rig.visible = true
			Sword_Rig.scale.x = 1.0
		"Dagger":
			Dagger_Rig.visible = true
			Dagger_Rig.scale.x = 1.0
		"HandGun":
			HandGun_Rig.visible = true
			HandGun_Rig.scale.x = 1.0
			General_Animations.play("Tools_Anims/HandGun_Popup")
		"AssaultRifle":
			Assault_Rig.visible = true
			Assault_Rig.scale.x = 1.0
			General_Animations.play("Tools_Anims/Assault_Popup")
	match Global.Player_Data.Inv_ToolL_Equiped:
		"null":
			Arm_Left_Rig.visible = true
		"Sword":
			Sword_Rig.visible = true
			Sword_Rig.scale.x = -1.0
		"Dagger":
			Dagger_Rig.visible = true
			Dagger_Rig.scale.x = -1.0
		"HandGun":
			HandGun_Rig.visible = true
			HandGun_Rig.scale.x = -1.0
			General_Animations.play("Tools_Anims/HandGun_Popup")
		"AssaultRifle":
			Assault_Rig.visible = true
			Assault_Rig.scale.x = -1.0
			General_Animations.play("Tools_Anims/Assault_Popup")
			#endregion

func Item_Pickup(Item_Sys_Name, Item_Type, Item_Quantity):
	match Item_Type:
		"Special":
			Global.Player_Data.Tool_ID[Item_Sys_Name]["picked?"] = true
		"Ordinary":
			pass

func Hold_Tap_Interval(Release_Input): #, delta: float) -> void:
	Global.Player_Data.TH_Active = true
	Global.Player_Data.TH_Tapped = false
	Global.Player_Data.TH_Held = false
	
	if Input.is_action_just_released(Global.Player_Data.Un_Tool_Alternive):
		Global.Player_Data.TH_Active = false
		
		if Global.Player_Data.TH_Timing < Global.Player_Data.TH_Threshold:
			Global.Player_Data.TH_Tapped = true
			Global.Player_Data.TH_Held = false
			print("Tapped: ", Global.Player_Data.TH_Tapped, " // Held: ", Global.Player_Data.TH_Held, " (Timing: ", Global.Player_Data.TH_Timing, ")")
			Global.Player_Data.TH_Timing = 0.0
		
	if Global.Player_Data.TH_Timing >= Global.Player_Data.TH_Threshold:
		Global.Player_Data.TH_Active = false
		Global.Player_Data.TH_Tapped = false
		Global.Player_Data.TH_Held = true
		print("Tapped: ", Global.Player_Data.TH_Tapped, " // Held: ", Global.Player_Data.TH_Held, " (Timing: ", Global.Player_Data.TH_Timing, ")")
		Global.Player_Data.TH_Timing = 0.0
		
	#print("<===Hold_Tap_Timing initialized===>")
	##var Active: bool = true
	##var Timing: float = 0.00
	##var Threshold: float = 0.25
	#print("Variables initialized")
	#
	#if Active == true:
		#print("Timer started")
		#Timing += 1
		#print(Timing)
	#
	#if Input.is_action_just_released(Release_Input):
		#Active = false
		#print("Timer ended", Timing)
	#
	#if Timing < Threshold:
		#print("Released early")
		#pass
	#
	#elif Timing >= Threshold:
		#Active = false
		#print("Timer expired")
		#pass
