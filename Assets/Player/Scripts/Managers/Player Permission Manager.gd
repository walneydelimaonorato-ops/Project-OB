extends Node

func _ready() -> void:
	BugBus.emit_signal("Report", "Player", "Player Permission Manager Working")
	PLY_Flags.Player_Status_Master = "Alive"
	Bulk_Permission_Assigning()
	
	IntSigBus.Player_Permissions_Changer.connect(Player_Permissions_Setting)
	IntSigBus.Player_Permissions_Conditionals.connect(Player_Permissions_Conditionals)

func Bulk_Permission_Assigning():
	match PLY_Flags.Player_Status_Master:
		"Alive":
			Player_Permissions_Setting("Can Move", "Yes")
			Player_Permissions_Setting("Can Look", "Yes")
			Player_Permissions_Setting("Can Show UI Side", "Yes")
			Player_Permissions_Setting("Can Show UI Stats", "Yes")
			Player_Permissions_Setting("Can Show UI Side", "Yes")
		"Dead":
			Player_Permissions_Setting("Can Menus", "No")
			Player_Permissions_Setting("Can Show UI Side", "No")
			Player_Permissions_Setting("Can Show UI Stats", "No")
			Player_Permissions_Setting("Can Show Prompts", "No")
			Player_Permissions_Setting("Can Move", "No")
			Player_Permissions_Setting("Can Look", "No")
			Player_Permissions_Setting("Can Use UItems", "No")
		"Undead":
			pass
	
	match PLY_Flags.Player_Status_2:
		pass
	
	match PLY_Flags.Player_Status_3:
		pass
	
	IntSigBus.emit_signal("Side_HUD_Update")


func Stats_Setting(Target, Setting):
	match Target:
		"Player Status Master":
			PLY_Flags.Player_Status_Master = Setting
		"Player Status 1":
			PLY_Flags.Player_Status_1 = Setting
		"Player Status 2":
			PLY_Flags.Player_Status_2 = Setting
		"Player Status 3":
			PLY_Flags.Player_Status_3 = Setting

func Player_Permissions_Setting(Permission: String, Setting: String):
	
	if !PLY_Flags.Perms.has(Permission):
		push_error("Unknown permission: " + Permission)
		return
	
	match Setting:
		"Flip":
			PLY_Flags.Perms[Permission] = !PLY_Flags.Perms[Permission]
		"Yes":
			PLY_Flags.Perms[Permission] = true
		"No":
			PLY_Flags.Perms[Permission] = false
	

func Player_Permissions_Conditionals():
	if PLY_Inventory.Tool_ID["HandGun"]["Ammo"] <= 0:
		Player_Permissions_Setting("Can_Use_HandGun", "No")
	elif PLY_Inventory.Tool_ID["HandGun"]["Ammo"] > 0:
		Player_Permissions_Setting("Can_Use_HandGun", "Yes")
	
	if PLY_Inventory.Tool_ID["AssaultRifle"]["Ammo"] <= 0:
		Player_Permissions_Setting("Can_Use_AssaultRifle", "No")
	elif PLY_Inventory.Tool_ID["AssaultRifle"]["Ammo"] > 0:
		Player_Permissions_Setting("Can_Use_AssaultRifle", "Yes")
		
	
	if PLY_Var.Health <= 0:
		PLY_Flags.Player_Status_Master = "Dead"
		Bulk_Permission_Assigning()
	elif PLY_Var.Health > 0:
		PLY_Flags.Player_Status_Master = "Alive"
		Bulk_Permission_Assigning()
	
	if PLY_Var.Stamina <= 0 :
		Player_Permissions_Setting("Can_Sprint", "No")
	elif PLY_Var.Stamina > 0 :
		Player_Permissions_Setting("Can_Sprint", "Yes")
	
	if PLY_Flags.Perms["Is Resting"] == true:
		%Models.visible = false
		%Model.visible = false
	elif PLY_Flags.Perms["Is Resting"] == false:
		%Models.visible = true
		%Model.visible = true
