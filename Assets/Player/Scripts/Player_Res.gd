class_name PlayerStats
extends Resource

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

#@export var Control_Mode: String
var Base_Speed: int = 4 # Speed used to move
var Dummy_Speed: int = 4 # Fallback speed value
var Run: int = 6 # Speed used when running
var Health: int
var Key_Camera_Sens: float = 0.003
var Joy_Camera_Sens: float = 0.075

var Control_Mode: String = "Key"
