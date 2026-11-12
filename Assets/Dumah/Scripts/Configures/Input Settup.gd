extends Node

func _ready() -> void:
	#match PLY_Var.Control_Mode:
		#"Key":
	PLY_Input.Un_Forward = "In_Forward"
	PLY_Input.Un_Backward = "In_Backward"
	PLY_Input.Un_Left = "In_Left"
	PLY_Input.Un_Right = "In_Right"
	PLY_Input.Un_Jump = "In_Jump"
	PLY_Input.Un_Use_UItem = "In_Use_Item"
	#PLY_Input.Un_Interact = "In"
	PLY_Input.Un_Cycle_UItem = "In_Cycle_UItem"
	PLY_Input.Un_Sprint = "In_Sprint"
	PLY_Input.Un_Ready_Menu = "In_Pause"
	PLY_Input.Un_RPrimary_Tool_Use = "In_Mouse_R"
	PLY_Input.Un_LPrimary_Tool_Use = "In_Mouse_L"
	PLY_Input.Un_RSecondary_Tool_Use = ""
	PLY_Input.Un_LSecondary_Tool_Use = ""
	PLY_Input.Un_Tool_Alternive = "In_Tool_Alt"
	PLY_Input.Un_2Hand_Toggle = ""
	
	PLY_Input.UnUI_Up = "UI_Up"
	PLY_Input.UnUI_Down = "UI_Down"
	PLY_Input.UnUI_Left = "UI_Left"
	PLY_Input.UnUI_Right = "UI_Right"
	PLY_Input.UnUI_Accept = "UI_Accept"
	PLY_Input.UnUI_Accept = "UI_Accept"
	PLY_Input.UnUI_Unselect = "UI_Unselect"
