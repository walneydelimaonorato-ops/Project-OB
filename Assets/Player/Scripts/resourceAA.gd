extends Resource
class_name PlayerData

var test1: bool = false

#region Universal Input Settup
var Un_Forward: String
var Un_Backward: String
var Un_Left: String
var Un_Right: String
var Un_Jump: String
var Un_Interact: String
var Un_Sprint: String
var Un_Ready_Menu: String
var Un_RPrimary_Tool_Use: String
var Un_LPrimary_Tool_Use: String
var Un_RSecondary_Tool_Use: String
var Un_LSecondary_Tool_Use: String
var Un_Tool_Alternive: String
var Un_2Hand_Toggle: String
var Un_Use_UItem: String 
var Un_Cycle_UItem: String

var UnUI_Up: String
var UnUI_Down: String
var UnUI_Left: String
var UnUI_Right: String
var UnUI_Accept: String
var UnUI_Return: String
var UnUI_Unselect: String

var UnHUDIcon_Up: String
var UnHUDIcon_Down: String
var UnHUDIcon_Left: String
var UnHUDIcon_Right: String
var UnHUDIcon_Accept: String
var UnHUDIcon_Return: String
var UnHUDIcon_Unselect: String
var UnHUDIcon_Interact: String
#var Un_Ass: String
#endregion

#region Flags
var Alive: bool = true # Checks if the player is alive
var Stamina_Regeneration_Active: bool = false # Checks if the stamina regeneration is active
var Menu_mode: bool = false # Checks if the player is currently in a menu
#endregion

#region Signals
signal Ready_Menu_Toggled(active: bool)
signal Seletion_Menu_Toggled(active: bool)
signal Choice_Menu_Toggled(active: bool)
signal Menus_Visual_Update(Menu_Slot: String, Item_Texture: String)

signal UItem_Cycle()
signal UItem_Use()

signal Stats_Change(Operation: String, Type: String, Value: int)
signal Player_Stats_Management_Update_In()
signal Player_Stats_Management_Update_Out()

signal Tool_and_HUD_Rotation()
#endregion

#region Static Variables (never change)
var Control_Mode: String = "Key"
var Base_Speed: int = 4 # Speed used to move
var Dummy_Speed: int = 4 # Fallback speed value
var Run: int = 6 # Speed used when running
var Key_Camera_Sens: float = 0.003
var Joy_Camera_Sens: float = 0.075
# UItem quantity
var Glass_flask_quantity_max: int = 6 # Maximum use quantity of Glass Flask
# Stamina related variables
var Dummy_Stamina_Regeneration_Rate: float = 5.0 # Amount of points of Stamina regenerated
var Stamina_Regeneration_Delay_Timer # Timer related to the time needed before stamina begins regenerating
# Ahhh
var Actionable: bool
#endregion

#region Fluid Variables (change)
# Can / Can't setters
var Can_Open_Menus: bool
var Can_Use_Sword: bool
var Can_Use_Dagger: bool
var Can_Use_HandGun: bool
var Can_Use_AssaultRifle: bool
var Can_Show_UI_Side: bool
var Can_Show_UI_Stats: bool
var Can_Show_Prompts: bool
var Can_Move: bool
var Can_Sprint: bool
var Can_Look: bool
var Can_Use_Menus: bool
var Can_Use_UItems: bool

var Player_Status_1: String
var Player_Status_2: String
var Player_Status_3: String

# Aassss
var Ammo_A: int = 0
var Mag_A: int = 0
var Ammo_C: int = 0

# Menu related variables
var Current_Focus: String = ""
var Current_Menu: String = ""
var Current_SubMenu: String = ""

var Ready_Menu_Active: bool = false
var Seletion_Menu_Active: bool = false
var Choice_Menu_Active: bool = false

# Inventory related variables
var Inv_Brace_Equiped: String = "null"
var Inv_Wear_Equiped: String = "null"
var Inv_ToolL_Equiped: String = "null"
var Inv_ToolR_Equiped: String = "null"
var Inv_Spell_Equiped: String = "null"
var Inv_Uitem1_Equiped: String = "null"
var Inv_Uitem2_Equiped: String = "null"
var Inv_Uitem3_Equiped: String = "null"
var Cycle_Uitem_Active: String = "null"
var Cycle_Uitem_Index: int = 1

# Stamina related variables
var Stamina_Max: float = 20.0 # Maximum amount of stamina the player can have
var Stamina: float = 20.0 # Current amount of stamina the player has
var Stamina_Regeneration_Amount: float = 2.0 # Amount of time (in seconds) waited for the stamina regeneration to begin
var Stamina_Regeneration_Rate: float = 3.0 # Amount of points of Stamina regenerated

# Health related variables
var Health_Max: float = 10.0 # Maximum amount of health
var Health: float = 10.0 # Current amount of health the player has

# Bonuses and modifiers
var Health_Bonus: int = 0
var Physical_Damage_Bonus: int = 0
var Divine_Damage_Bonus: int = 0
var Heretic_Damage_Bonus: int = 0

# UItem quantity
var Glass_flask_quantity: int = 6 # Use quantity of Glass Flask
var Wild_gold_quantity: int = 10 # Use quantity of Wild Gold
#endregion

#region IDs
var Tool_ID = {
	"Hand": {
		"dys name": " ", 
		"sys name": "Hand",
		"Icon": "",
		"picked?": true,
		"equipped?": false, 
		"damage": 0, 
		},
	"HandGun": {
		"dys name": "Abrams",
		"sys name": "HandGun",
		"Icon": "uid://dev6yasoqfrik",
		"picked?": true,
		"equipped?": false, 
		"damage": 6, 
		"Ammo A": 0,
		"Mag A": 0,
		},
	"AssaultRifle": {
		"dys name": "AM-16", 
		"sys name": "AssaultRifle",
		"Icon": "uid://bpdhkde57ipm",
		"picked?": true,
		"equipped?": false, 
		"damage": 15, 
		},
	"Sword": {
		"dys name": "E. Trais", 
		"sys name": "Sword",
		"Icon": "uid://d3txjn55xf1sw",
		"picked?": true,
		"equipped?": false, 
		"damage": 20, 
		},
	"Dagger": {
		"dys name": " ", 
		"sys name": "Dagger",
		"Icon": "uid://cxpllkwkj3coo",
		"picked?": false,
		"equipped?": false, 
		"damage": 10,
		},
	"SpecialBow": {
		"dys name": " ", 
		"sys name": "SpecialBow",
		"Icon": "uid://c244x88oddpii",
		"picked?": false,
		"equipped?": false, 
		"damage": 25,
		},
}

var Wear_ID = {
	"Plain": {
		"dys name": " ", 
		"sys name": " ",
		"Icon": "uid://bqi66glri2ec",
		"picked?": true,
		"equipped?": false, 
		"weight": 0,
		"def. redu.": -5,
		},
	"Upper Mewclad Arm.": {
		"dys name": " ", 
		"sys name": " ",
		"Icon": "",
		"picked?": false,
		"equipped?": false, 
		"weight": 20,
		"def. redu.": 4,
		},
	"Lower Mewclad Arm.": {
		"dys name": " ", 
		"sys name": " ",
		"Icon": "",
		"picked?": false,
		"equipped?": false, 
		"weight": 12,
		"def. redu.": 2,
		}
}

var Spell_ID = {
	"null": {
		"dys name": " ", 
		"sys name": " ",
		"Icon": "",
		"picked?": true,
		"equipped?": false, 
		"quantity": 0,
		"max quantity": 0,
		"damage": 0,
		},
	"PotentiaSolis": {
		"dys name": " ", 
		"sys name": " ",
		"Icon": "uid://baatlbdf0r5c",
		"picked?": true,
		"equipped?": false, 
		"quantity": 6,
		"max quantity": 6,
		"damage": 20 + Divine_Damage_Bonus,
		},
	"Misericordia": {
		"dys name": " ", 
		"sys name": " ",
		"Icon": "",
		"picked?": true,
		"equipped?": false, 
		"quantity": 2,
		"max quantity": 2,
		"damage": 0,
		},
	"Tywyll": {
		"dys name": " ", 
		"sys name": " ",
		"Icon": "",
		"picked?": true,
		"equipped?": false, 
		"quantity": 10,
		"max quantity": 10,
		"damage": 10 + Heretic_Damage_Bonus,
		},
	"Sunfire": {
		"dys name": " ", 
		"sys name": " ",
		"Icon": "",
		"picked?": true,
		"equipped?": false, 
		"quantity": 99999,
		"max quantity": 99999,
		"damage": 99999,
		}
}

var Brace_ID = {
	"Golden Bra.": {
		"dys name": " ", 
		"sys name": "Golden Bra.",
		"Icon": "uid://davke1oama52w",
		
		"picked?": true,
		"equipped?": false, 
		},
	"Clorophyl Bra.": {
		"dys name": " ", 
		"sys name": "Clorophyl Bra.",
		"Icon": "",
		
		"picked?": true,
		"equipped?": false, 
		},
	"Power Bra.": {
		"dys name": " ", 
		"sys name": "Power Bra.",
		"Icon": "",
		
		"picked?": true,
		"equipped?": false, 
		}
}

var UItem_ID = {
	"null": {
		"dys name": " ", 
		"sys name": "null",
		"Icon": "uid://qua4cq3ubssm",
	},
	"Sigil": {
		"dys name": " ", 
		"sys name": "Sigil",
		"Icon": "uid://di03rqvlhqp7q",
		"picked?": true,
		"equipped?": false,
		
		"heal_values": 0,
		"quantity": 0,
		"special id": ""
		},
	"Glass Flask": {
		"dys name": " ", 
		"sys name": "Glass Flask",
		"Icon": "uid://13ylgt0ylimp",
		"picked?": true,
		"equipped?": false, 
		
		"heal_values": Health_Max / 3,
		"quantity": Glass_flask_quantity,
		"special id": "renewable"
		},
	"Wild Gold": {
		"dys name": " ", 
		"sys name": "Wild Gold",
		"Icon": "uid://v22tjgao7mso",
		"picked?": true,
		"equipped?": false, 
		
		"heal_values": 2,
		"quantity": Wild_gold_quantity,
		"special id": ""
		}
}
#endregion

func _ready() -> void:
	print("Player Stats working")
