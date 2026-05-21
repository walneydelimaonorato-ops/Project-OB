extends Node

func _ready() -> void:
	print("Player Status Manager Working")

func Stats_Sorting():
	match Global.Player_Data.Player_Status_1:
		"Alive":
			pass
		"Dead":
			Global.Player_Data.Can_Open_Menus = false
			Global.Player_Data.Can_Show_UI_Side = false
			Global.Player_Data.Can_Show_UI_Stats = false
			Global.Player_Data.Can_Show_Prompts = false
			Global.Player_Data.Can_Move = false
			Global.Player_Data.Can_Look = false
			Global.Player_Data.Can_Use_UItems = false
			#Global.Player_Data.aa = false
		"Undead":
			pass
		_:
			pass
	
	match Global.Player_Data.Player_Status_2:
		pass
	
	match Global.Player_Data.Player_Status_3:
		pass
