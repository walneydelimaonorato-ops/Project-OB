extends Node
@onready var PlayerRes: Node = %"Player Stats"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Player Management working")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	Regeneration_Timer_Startup()
	PlayerRes.Stamina_Regeneration_Delay_Timer.timeout.connect(Start_Stamina_Regeneration)
	
	
	
#region Control Settup
	match PlayerRes.Control_Mode:
		"Key":
			PlayerRes.Un_Forward = "In_Forward"
			PlayerRes.Un_Backward = "In_Backward"
			PlayerRes.Un_Left = "In_Left"
			PlayerRes.Un_Right = "In_Right"
			PlayerRes.Un_Jump = "In_Jump"
			PlayerRes.Un_Use_UItem = "In_Use_Item"
			PlayerRes.Un_Sprint = "In_Sprint"
			PlayerRes.Un_Ready_Menu = "In_Pause"
			PlayerRes.Un_RPrimary_Tool_Use = "In_Mouse_R"
			PlayerRes.Un_LPrimary_Tool_Use = "In_Mouse_L"
			PlayerRes.Un_RSecondary_Tool_Use = ""
			PlayerRes.Un_LSecondary_Tool_Use = ""
			PlayerRes.Un_Tool_Alternive = "In_Tool_Alt"
			PlayerRes.Un_2Hand_Toggle = ""
			
			PlayerRes.UnUI_Up = "UI_Up"
			PlayerRes.UnUI_Down = "UI_Down"
			PlayerRes.UnUI_Left = "UI_Left"
			PlayerRes.UnUI_Right = "UI_Right"
			PlayerRes.UnUI_Accept = "UI_Accept"
			PlayerRes.UnUI_Accept = "UI_Accept"
			PlayerRes.UnUI_Unselect = "UI_Unselect"
		
		"Joy":
			PlayerRes.Un_Forward = "In_JoyL_Forward"
			PlayerRes.Un_Backward = "In_JoyL_Backward"
			PlayerRes.Un_Left = "In_JoyL_Left"
			PlayerRes.Un_Right = "In_JoyL_Right"
			PlayerRes.Un_Jump = "In_Joy_Jump"
			PlayerRes.Un_Use_UItem = "In_Joy_Use_Item"
			PlayerRes.Un_Sprint = "In_Joy_Sprint"
			PlayerRes.Un_Ready_Menu = "In_Joy_Pause"
			PlayerRes.Un_RPrimary_Tool_Use = "In_Joy_R2"
			PlayerRes.Un_LPrimary_Tool_Use = "In_Joy_L2"
			PlayerRes.Un_RSecondary_Tool_Use = ""
			PlayerRes.Un_LSecondary_Tool_Use = ""
			PlayerRes.Un_Tool_Alternive = "In_Joy_Tool_Alt"
			PlayerRes.Un_2Hand_Toggle = ""
			
			PlayerRes.UnUI_Up = "UI_Joy_Up"
			PlayerRes.UnUI_Down = "UI_Joy_Down"
			PlayerRes.UnUI_Left = "UI_Joy_Left"
			PlayerRes.UnUI_Right = "UI_Joy_Right"
			PlayerRes.UnUI_Accept = "UI_Joy_Accept"
			PlayerRes.UnUI_Accept = "UI_Joy_Accept"
			PlayerRes.UnUI_Unselect = "UI_Joy_Unselect"
#endregion

#region Stamina Regeneration Process

func Regeneration_Timer_Startup():
	PlayerRes.Stamina_Regeneration_Delay_Timer = Timer.new()
	PlayerRes.Stamina_Regeneration_Delay_Timer.wait_time = PlayerRes.Stamina_Regeneration_Amount
	PlayerRes.Stamina_Regeneration_Delay_Timer.one_shot = true
	add_child(PlayerRes.Stamina_Regeneration_Delay_Timer)

func Start_Stamina_Regeneration():
	PlayerRes.Stamina_Regeneration_Active = true

func Stamina_Regeneration_Process(delta):
	if PlayerRes.Stamina_Regeneration_Active == true and PlayerRes.Stamina < PlayerRes.Stamina_Max:
		PlayerRes.Stamina += PlayerRes.Stamina_Regeneration_Rate * delta
		if PlayerRes.Stamina >= PlayerRes.Stamina_Max:
			PlayerRes.Stamina = PlayerRes.Stamina_Max
			PlayerRes.Stamina_Regeneration_Active = false
#endregion

func Stats_Decrease(Type, Value):
	if Type == "Health":
		PlayerRes.Health -= Value
	elif Type == "Stamina": 
		PlayerRes.Stamina -= Value
		PlayerRes.Stamina_Regeneration_Active = false
		PlayerRes.Stamina_Regeneration_Delay_Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	PlayerRes.Health = clamp(PlayerRes.Health, 0, PlayerRes.Health_Max)
	PlayerRes.Stamina = clamp(PlayerRes.Stamina, 0, PlayerRes.Stamina_Max)
	
	Stamina_Regeneration_Process(delta)
