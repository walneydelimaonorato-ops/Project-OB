extends Node3D

var Respaw_Scene : String


# These are debug variables to detect the state the Player is in
var INSIGHT_Player_State_Movement : String
var Player_State_Movement : String # Reflect player movement 
var INSIGHT_Player_State_Action : String
var Player_State_Action : String # Reflect player action
var INSIGHT_Player_State_Special : String
var Player_State_Special : String # Reflect a special type of state
var INSIGHT_Player_State : String
var Player_State : String

var Health_Max = 10 # Maximum amount of health
var Dummy_Health_Max = 10
var Dummy_Health_Max1 = 10
var Health_Bonus = 0
var Health = 10 # Current amount of health the player has

var Stamina_Max = 20.0 # Maximum amount of stamina the player can have
var Stamina = 20 # Current amount of stamina the player has
var Reg_Amount = 2.0 # Amount of time (in seconds) waited for the stamina regeneration to begin
var Dummy_Reg_Rate = 5 # Amount of points of Stamina regenerated
var Reg_Rate = 5 # Amount of points of Stamina regenerated
var Reg_Delay_Timer # Timer related to the time needed before stamina begins regenerating

var R_Hand_In_Use = 0 # Tool in right hand
var L_Hand_In_Use = 0 # Tool in left hand

var Usable_Item_Selected = 1 # Usable items currently selected
var UItem_Max = 3 # Maximum amount of usable items held
var Glass_flask_quantity = 6 # Use quantity of Glass Flask
var Glass_flask_quantity_max = 6 # Maximum use quantity of Glass Flask
var Wild_gold_quantity = 10 # Use quantity of Wild Gold

var Menu_Depth = 0 # How deep in the menus the player is
var Menu_Depth_Max = 9 # Arbitrary maximum depth of menus
var Item_Menu_To = "" # Where from Ready Menu the player is going to
var Item_Menu_Slot = "" # ???

# Inventory related stuff
var Inv_Brace_Equiped = "null"
var Inv_Wear_Equiped = "null"
var Inv_ToolL_Equiped = "null"
var Inv_ToolR_Equiped = "null"
var Inv_Spell_Equiped = "null"
var Inv_Uitem1_Equiped = "null"
var Inv_Uitem2_Equiped = "null"
var Inv_Uitem3_Equiped = "null"

var Tool_Fatigue = 0
var Damage_Bonus = 0
var INSIGHT_Tool_R_State = ""
var Tool_R_State = ""
var INSIGHT_Tool_L_State = ""
var Tool_L_State = ""
var INSIGHT_Tool_Direction_Use = ""
var Tool_Direction_Use = ""

# Flags:
var Alive = true # Checks if the player is alive
var Undeath = false # Checks if the player is in the Undead state
var Reg_Active = false # Checks if the stamina regeneration is active
var Anim_HM_Done1 = false # Animation related to the Gun transition (triggered once)
var Anim_HM_Done2 = false # Animation related to the Melee transition (triggered once)
var Menu_mode = false # Checks if the player is currently in a menu
var One_Time = true # Conditional integer flashed true only once per call
var inter_press_time := 0.0
var inter_hold_treshold := 0.25
var inter_button_tapped = false
var inter_button_held := false

var Stamina_Jump_Tax = 10
var Stamina_Act1_Tax = 5

func _ready():
	Player_State_Update("MVM", "NULL")
	Player_State_Update("ACT", "NULL")
	Player_State_Update("SPC", "NULL")
	Player_State_Update("ToolR", "NULL")
	Player_State_Update("ToolL", "NULL")
	Player_State_Update("ToolDir", "NULL")

func _process(delta: float) -> void:
	# When the player is alive, the mouse is captured
	if Alive == true:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	
	# Sets the minimum and maximum for "Health" and "Stamina"
	Health_Max = clamp(Health_Max, 10, Dummy_Health_Max)
	Health = clamp(Health, 0, Health_Max)
	Stamina = clamp(Stamina, 0, Stamina_Max)
	Menu_Depth = clamp(Menu_Depth, 0, Menu_Depth_Max)
	
	inter_press_time = clamp(inter_press_time, 0, 0.50)
	
	Dummy_Health_Max = Health_Max + Health_Bonus
	Health_Max = Dummy_Health_Max1 + Health_Bonus
	$"../Head/CanvasLayer/face/GUI/Control/HUD/Health".max_value = Health_Max
	
	# When the player's health reaches 0, it dies
	if Health == 0:
		Alive = false

func Ready_Menu_To_Item_Selection_Update(Item_Slot, Item):
	if Item_Slot == "Brace":
		Inv_Brace_Equiped = Item
	elif Item_Slot == "Wear":
		Inv_Wear_Equiped = Item
	elif Item_Slot == "Tool L":
		Inv_ToolL_Equiped = Item
	elif Item_Slot == "Tool R":
		Inv_ToolR_Equiped = Item
	elif Item_Slot == "Spell":
		Inv_Spell_Equiped = Item
	elif Item_Slot == "UItem 1":
		Inv_Uitem1_Equiped = Item
	elif Item_Slot == "UItem 2":
		Inv_Uitem2_Equiped = Item
	elif Item_Slot == "UItem 3":
		Inv_Uitem3_Equiped = Item
	else:
		pass

func Menu_Forward(Constraint, Menu_Path, Menu_Slot):
	# Constraint: Checks what depth the player is
	# Menu Path: What menu the player is going to
	# Menu Slot: ???
	if Menu_Depth == Constraint:
		Menu_Depth += 1
	Item_Menu_To = Menu_Path
	Item_Menu_Slot = Menu_Slot
	await get_tree().create_timer(0.01).timeout
	One_Time = true

func Menu_Backwards(Depth_Level):
	# Depth Level: How deep in the menus the player is
	if Menu_Depth == Depth_Level:
		Menu_Depth -= 1
		One_Time = true

func Player_State_Update(Type, Player_State):
	# Type: type of player state to be updated
	# Player State: new player state
	if Type == "MVM":
		INSIGHT_Player_State_Movement = str("Player State MVM: ", Player_State, "\r")
		Player_State_Movement = Player_State
	elif Type == "ACT":
		INSIGHT_Player_State_Action = str("Player State ACT: ", Player_State, "\r")
		Player_State_Action = Player_State
	elif Type == "SPC":
		INSIGHT_Player_State_Special = str("Player State SPC: ", Player_State, "\r")
		Player_State_Special = Player_State
	elif Type == "ToolR":
		INSIGHT_Tool_R_State = str("Tool R State: ", Player_State, "\r")
		Tool_R_State = Player_State
		Tool_Fatigue = 0
	elif Type == "ToolL":
		INSIGHT_Tool_L_State = str("Tool L State: ", Player_State, "\r")
		Tool_L_State = Player_State
		Tool_Fatigue = 0
	elif Type == "ToolDir":
		INSIGHT_Tool_Direction_Use = str("Tool Direction: ", Player_State)
		Tool_Direction_Use = Player_State

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

#var UItem_ID = {
	#"null": {"heal_values": 0, "quantity": 0, "special id": ""},
	#"Glass flask": {"heal_values": Health_Max/3, "quantity": Glass_flask_quantity, "special id": "renewable"},
	#"Wild gold": {"heal_values": 2, "quantity": Wild_gold_quantity, "special id": ""}
#}
var UItem_ID = [
	{"name": "", "heal_value": 0, "quantity": 0, "special id": ""},
	{"name": "Glass flask", "heal_value": Health_Max/3, "quantity": Glass_flask_quantity, "special id": "renewable"},
	{"name": "Wild gold", "heal_value": 2, "quantity": Wild_gold_quantity, "special id": ""},
]
func UItem_Get_ID() -> Dictionary:
	if Usable_Item_Selected >= 0 and Usable_Item_Selected < UItem_ID.size():
		return UItem_ID[Usable_Item_Selected]
	return UItem_ID[0]

var Tool_ID = {
	"Hand": {
		"damage": 0, 
		"equipped?": false, 
		"picked?": true
		},
	"HandGun": {
		"damage": 3, 
		"equipped?": false, 
		"picked?": true
		},
	"AssaultRifle": {
		"damage": 6, 
		"equipped?": false, 
		"picked?": true
		},
	"Sword": {
		"damage": 8, 
		"equipped?": false, 
		"picked?": true
		}
}

var Equipped_Items = [
	
]

func Tool_Get_ID() -> Dictionary:
	if Tool_Direction_Use == "Right":
		match Inv_ToolR_Equiped:
			"null":
				return Tool_ID["Hand"]
			"Hand gun":
				return Tool_ID["HandGun"]
			"Assault rifle":
				return Tool_ID["AssaultRifle"]
			"Sword":
				return Tool_ID["Sword"]

	elif Tool_Direction_Use == "Left":
		match Inv_ToolL_Equiped:
			"null":
				return Tool_ID["Hand"]
			"Hand gun":
				return Tool_ID["HandGun"]
			"Assault rifle":
				return Tool_ID["AssaultRifle"]
			"Sword":
				return Tool_ID["Sword"]

	return Tool_ID["Hand"]
