extends Node3D

# These are debug variables to detect the state the Player is in
var PLayer_State_Movement # Reflect player movement 
var PLayer_State_Action # Reflect player action
var PLayer_State_Special # Reflect a special type of state
var Player_State

var Health_Max = 10 # Maximum amount of health
var Health = 10 # Current amount of health the player has

var Stamina_Max = 20.0 # Maximum amount of stamina the player can have
var Stamina = 20 # Current amount of stamina the player has
var Reg_Amount = 2.0 # Amount of time (in seconds) needed for the stamina regeneration to begin
var Reg_Rate = 5 # Amount of points of Stamina regenerated
var Reg_Delay_Timer # Timer related to the time needed before stamina begins regenerating

var R_Hand_In_Use = 0 # Tool in right hand
var L_Hand_In_Use = 0 # Tool in lrft hand

var Usable_Item_Selected = 1
var UItem_Max = 3
var Glass_flask_quantity = 6
var Glass_flask_quantity_max = 6
var Wild_gold_quantity = 10

var Menu_Depth = 0
var Menu_Depth_Max = 9
var Item_Menu_To = ""
var Item_Menu_Slot = ""

# Inventory related stuff
var Inv_Brace_Equiped = ""
var Inv_Wear_Equiped = ""
var Inv_ToolL_Equiped = ""
var Inv_ToolR_Equiped = ""
var Inv_Spell_Equiped = ""
var Inv_Uitem1_Equiped = ""
var Inv_Uitem2_Equiped = ""
var Inv_Uitem3_Equiped = ""

# Flags:
var Alive = true
var Undeath = false
var Reg_Active = false
var Anim_HM_Done1 = false # Animation related to the Gun transition (triggered once)
var Anim_HM_Done2 = false # Animation related to the Melee transition (triggered once)
var Menu_mode = false
var One_Time = true

var Stamina_Jump_Tax = 10
var Stamina_Act1_Tax = 5

func _ready():
	Player_State_Update("MVM", "NULL")
	Player_State_Update("ACT", "NULL")
	Player_State_Update("SPC", "NULL")

func _process(delta: float) -> void:
	if Alive == true:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	
	Health = clamp(Health, 0, Health_Max)
	Stamina = clamp(Stamina, 0, Stamina_Max)
	Menu_Depth = clamp(Menu_Depth, 0, Menu_Depth_Max)
	if Health == 0:
		Alive = false

func Menu_Forward(Constraint, Menu_Path, Menu_Slot):
	if Menu_Depth == Constraint:
		Menu_Depth += 1
	Item_Menu_To = Menu_Path
	Item_Menu_Slot = Menu_Slot
	await get_tree().create_timer(0.01).timeout
	One_Time = true

func Menu_Backwards(Depth_Level):
	if Menu_Depth == Depth_Level:
		Menu_Depth -= 1
		One_Time = true

func Player_State_Update(Type, Player_State):
	if Type == "MVM":
		PLayer_State_Movement = str("Player State MVM: ", Player_State, "\r")
	elif Type == "ACT":
		PLayer_State_Action = str("Player State ACT: ", Player_State, "\r")
	elif Type == "":
		pass
	elif Type == "SPC":
		PLayer_State_Special = str("Player State SPC: ", Player_State, "\r")

func Heal(Type, amount):
	if Type == "Partial" and Health != Health_Max or Alive == false or Undeath == true:
		Health += amount
		
		var emit_request_id = 0
		emit_request_id += 1
		var id = emit_request_id
		$"../Head/Player_Particles/Hearts".emitting = true
		await get_tree().create_timer(0.2).timeout
		if id == emit_request_id:
			$"../Head/Player_Particles/Hearts".emitting = false
		
	elif Type == "Full":
		Health = Health_Max

func Stats_decrease(Type, Lower):
	if Type == "Stamina":
		Stamina -= Lower
		Reg_Active = false
		Reg_Delay_Timer.start()
	elif Type == "Health":
		Health -= Lower
		$"../Player_sfx/General sfx/pain".play()
		
		var emit_request_id = 0
		emit_request_id += 1
		var id = emit_request_id
		$"../Head/CanvasLayer/face/GUI/Control/Pain".visible = true
		await get_tree().create_timer(0.2).timeout
		if id == emit_request_id:
			$"../Head/CanvasLayer/face/GUI/Control/Pain".visible = false

func Reg_Timer_Startup():
	Reg_Delay_Timer = Timer.new()
	Reg_Delay_Timer.wait_time = Reg_Amount
	Reg_Delay_Timer.one_shot = true
	add_child(Reg_Delay_Timer)

func _start_Reg():
	Reg_Active = true

func Reg_Process(delta):
	if Reg_Active and Stamina < Stamina_Max:
		Stamina += Reg_Rate * delta
		if Stamina >= Stamina_Max:
			Stamina = Stamina_Max
			Reg_Active = false

var UItem_ID = [
	{"name": "", "heal_value": 0, "quantity": 0, "special id": ""},
	{"name": "Glass flask", "heal_value": Health_Max/3, "quantity": Glass_flask_quantity, "special id": "renewable"},
	{"name": "Wild gold", "heal_value": 2, "quantity": Wild_gold_quantity, "special id": ""},
]
func UItem_Get_ID() -> Dictionary:
	if Usable_Item_Selected >= 0 and Usable_Item_Selected < UItem_ID.size():
		return UItem_ID[Usable_Item_Selected]
	return {}

var ToolR_ID = [ 
	{"name": "Hand", "id": "close", "damage": 0, "Icon Ref": "res://addons/control/Player/Menus/Menu visuals/Tool_Blank.png"}, # Tool information for the Hand
	{"name": "Gun", "id": "range", "damage": 3, "Icon Ref": "res://addons/control/Player/Menus/Menu visuals/Tool_Gun.png"}, # Tool information for the Gun
	{"name": "Sword", "id": "melee", "damage": 8, "Icon Ref": "res://addons/control/Player/Menus/Menu visuals/Tool_Sword.png"} # Tool information for the Melee
]
var ToolL_ID = [
	{"name": "Hand", "id": "close"}, # Tool information for the Hand
	{"name": "Gun", "id": "range"}, # Tool information for the Gun
	{"name": "Sword", "id": "melee", "damage": 8} # Tool information for the Melee
]
func ToolR_Get_ID() -> Dictionary:
	if R_Hand_In_Use >= 0 and R_Hand_In_Use < ToolR_ID.size():
		return ToolR_ID[R_Hand_In_Use]
	return {}
func ToolLGet_ID() -> Dictionary:
	if L_Hand_In_Use >= 0 and L_Hand_In_Use < ToolL_ID.size():
		return ToolL_ID[L_Hand_In_Use]
	return {}
