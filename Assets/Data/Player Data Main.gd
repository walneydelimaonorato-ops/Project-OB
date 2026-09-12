extends Resource
class_name PlayerData

var test1: bool = false
var Developer_Mode: bool = true
var Context_Debug: int = 0
var Free_Cam_Mode: bool = false

var Player_Position: Vector3
var Player_Rotation: Vector3

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

#region Static Variables (never change)
var Control_Mode: String = "Key"
var Base_Speed: int = 4 # Speed used to move
var Dummy_Speed: int = 4 # Fallback speed value
var Run: int = 14 # Speed used when running
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
var Player_Perms = {
	"Can_Open_Menus": false,
	"Can_Use_Sword": false,
	"Can_Use_Dagger": false,
	"Can_Use_HandGun": false,
	"Can_Use_AssaultRifle": false,
	"Can_Show_UI_Side": false,
	"Can_Show_UI_Stats": false,
	"Can_Show_Prompts": false,
	"Can_Move": false,
	"Can_Sprint": false,
	"Can_Look": false,
	"Can_Use_Menus": false,
	"Can_Use_UItems": false,
}

# Variables related to: Tap or Hold Interval
var TH_Active_Valid: bool = false
var TH_Active: bool = false
var TH_Timing: float = 0.00
var TH_Threshold: float = 2.25
var TH_Tapped: bool = false
var TH_Held: bool = false

var Player_Status_Master: String
var Player_Status_1: String
var Player_Status_2: String
var Player_Status_3: String

var Debug_Fly: bool = false

# Aassss
var Ammo_A: int = 0
var Mag_A: int = 0
var Ammo_C: int = 0

# Menu related variables
var Current_Focus: String = ""
var Current_Menu: String = "null"
var Current_SubMenu: String = ""

var Ready_Menu_Active: bool = false
var Seletion_Menu_Active: bool = false
var Choice_Menu_Active: bool = false
var Keys_Menu_Active: bool = false

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

var Current_Map: String = ""
#endregion

#region IDs

#endregion

func _ready() -> void:
	print_rich("[color=#ffdf00]Player Stats Working[/color]")
