class_name PlayerStats
extends Resource

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
#var Un_Ass: String
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
var Stamina_Max: int = 20 # Maximum amount of stamina the player can have
var Stamina: int = 20 # Current amount of stamina the player has
# Health related variables
var Health_Max: int = 10 # Maximum amount of health
var Health: int = 10 # Current amount of health the player has
#endregion
