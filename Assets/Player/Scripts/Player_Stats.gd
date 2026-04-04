extends Node

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
#endregion

#region Fluid Variables (change)
# Inventory related variables
var Inv_Brace_Equiped: String  = "null"
var Inv_Wear_Equiped: String  = "null"
var Inv_ToolL_Equiped: String  = "null"
var Inv_ToolR_Equiped: String  = "null"
var Inv_Spell_Equiped: String  = "null"
var Inv_Uitem1_Equiped: String  = "null"
var Inv_Uitem2_Equiped: String  = "null"
var Inv_Uitem3_Equiped: String  = "null"
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
		"damage": 0, 
		"picked?": true,
		"equipped?": false, 
		"can be used?": true
		},
	"HandGun": {
		"damage": 6, 
		"picked?": true,
		"usable?": true
		},
	"AssaultRifle": {
		"damage": 15, 
		"picked?": true,
		"usable?": true
		},
	"Sword": {
		"damage": 20, 
		"picked?": true,
		"usable?": true
		},
	"Dagger": {
		"damage": 10,
		"picked?": true,
		"usable?": true
		},
	"SpecialBow": {
		"damage": 25,
		"picked?": true,
		"usable?": true
		},
}

var Wear_ID = {
	"Unclothed": {
		"weight": 0,
		"def. redu.": -5,
	},
	"Upper Mewclad Arm.": {
		"weight": 20,
		"def. redu.": 4,
	},
	"Lower Mewclad Arm.": {
		"weight": 12,
		"def. redu.": 2,
	}
}

var Spell_ID = {
	"null": {
	"quantity": 0,
	"max quantity": 0,
	"damage": 0,
	"picked?": true,
	"usable?": true
	},
	"PotentiaSolis": {
	"quantity": 6,
	"max quantity": 6,
	"damage": 20 + Divine_Damage_Bonus,
	"picked?": true,
	"usable?": true
	},
	"Misericordia": {
	"quantity": 2,
	"max quantity": 2,
	"damage": 0,
	"picked?": true,
	"usable?": true
	},
	"Tywyll": {
	"quantity": 10,
	"max quantity": 10,
	"damage": 10 + Heretic_Damage_Bonus,
	"picked?": true,
	"usable?": true
	},
	"Sunfire": {
	"quantity": 99999,
	"max quantity": 99999,
	"damage": 99999,
	"picked?": true,
	"usable?": true
	}
}

var Brace_ID = {
	"Golden Bra.": {
	
	"picked?": true,
	"usable?": true
	},
	"Clorophyl Bra.": {
	
	"picked?": true,
	"usable?": true
	},
	"power Bra.": {
	
	"picked?": true,
	"usable?": true
	}
}

var UItem_ID = {
	"null": {
	"heal_values": 0,
	"quantity": 0,
	"special id": ""
	},
	"Glass flask": {
	"heal_values": Health_Max / 3,
	"quantity": Glass_flask_quantity,
	"special id": "renewable"
	},
	"Wild gold": {
	"heal_values": 2,
	"quantity": Wild_gold_quantity,
	"special id": ""
	}
}
#endregion

func _ready() -> void:
	print("Player Stats working")
