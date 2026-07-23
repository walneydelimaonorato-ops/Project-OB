extends Node

func _ready() -> void:
	print_rich("[color=#b76e79]=========================\r[/color] [color=#ffdf00]Player Permission Manager Working[/color]")
	Global.Player_Data.Player_Status_Master = "Alive"
	Stats_Assigning()

func Stats_Assigning():
	match Global.Player_Data.Player_Status_Master:
		"Alive":
			Player_Permissions_Setting("Can_Move", "Yes")
			Player_Permissions_Setting("Can_Look", "Yes")
		"Dead":
			Player_Permissions_Setting("Can_Menus", "No")
			Player_Permissions_Setting("Can_Show_UI_Side", "No")
			Player_Permissions_Setting("Can_Show_UI_Stats", "No")
			Player_Permissions_Setting("Can_Show_Prompts", "No")
			Player_Permissions_Setting("Can_Move", "No")
			Player_Permissions_Setting("Can_Look", "No")
			Player_Permissions_Setting("Can_Use_UItems", "No")
		"Undead":
			pass
	
	match Global.Player_Data.Player_Status_2:
		pass
	
	match Global.Player_Data.Player_Status_3:
		pass

func Stats_Setting(Target, Setting):
	match Target:
		"Player Status Master":
			Global.Player_Data.Player_Status_Master = Setting
		"Player Status 1":
			Global.Player_Data.Player_Status_1 = Setting
		"Player Status 2":
			Global.Player_Data.Player_Status_2 = Setting
		"Player Status 3":
			Global.Player_Data.Player_Status_3 = Setting

func Player_Permissions_Setting(Permission: String, Setting: String):
	if !Global.Player_Data.Player_Perms.has(Permission):
		push_error("Unknown permission: " + Permission)
		return
	
	match Setting:
		"Flip":
			Global.Player_Data.Player_Perms[Permission] = !Global.Player_Data.Player_Perms[Permission]
		"Yes":
			Global.Player_Data.Player_Perms[Permission] = true
		"No":
			Global.Player_Data.Player_Perms[Permission] = false
