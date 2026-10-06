extends Node
# STATSMAN Node = %"Stats Management"

func _ready() -> void:
	BugBus.emit_signal("Report", "Player", "Player Action Working")
	#SignalBus.Action.connect(Action_Primary)
	SignalBus.Action_Alternative.connect(Action_Alternative)
	SignalBus.Action_Primary.connect(Action_Primary)

func Action_Alternative(Direction):
	match Direction:
		"Right":
			match PLY_Inventory.Inv_ToolR_Equiped:
				"null":
					pass
				"HandGun":
					HandGun("Reload")
				"AssaultRifle":
					AssaultRifle("reload")
		"Left":
			match PLY_Inventory.Inv_ToolL_Equiped:
				"null":
					Hand("Interact")
				"HandGun":
					HandGun("Reload")
				"AssaultRifle":
					AssaultRifle("Reload")

func Action_Primary(Direction):
	SignalBus.emit_signal("Player_Permissions_Conditionals")
	match Direction:
		"Right":
			match PLY_Inventory.Inv_ToolR_Equiped:
				"null":
					pass
				"HandGun":
					HandGun("Shoot")
				"AssaultRifle":
					AssaultRifle("Shoot")
		"Left":
			match PLY_Inventory.Inv_ToolL_Equiped:
				"null":
					pass
				"HandGun":
					HandGun("Shoot")
				"AssaultRifle":
					AssaultRifle("Shoot")

func Hand(Action_Type: String):
	match Action_Type:
		"Interact":
			SignalBus.emit_signal("Sig_General_Interaction", %Ray2, "Interact")
			SignalBus.emit_signal("Player_Animations", "Tools_Anims/LeftHand_Interact")

func HandGun(Action_Type: String):
	match Action_Type:
		"Shoot":
			if PLY_Flags.Perms["Can Use HandGun"] == true:
				SignalBus.emit_signal("LOC_Value_Operator", false, "Stamina", 2.0)
				SignalBus.emit_signal("Player_Animations", "Tools_Anims/HandGun_Shoot")
				SignalBus.emit_signal("SubRoutine_Call", "HandGun", "Ammunition Loss")
				SignalBus.emit_signal("request_damage", PLY_Inventory.Tool_ID["HandGun"]["damage"])
				SignalBus.emit_signal("Sig_General_Interaction", %Ray1, "Take_Damage")
			else:
				# PLay jamming sound
				pass
		"Reload":
			# Call subroutine ("HandGun", "Reload Magazine")
			pass

func AssaultRifle(Action_Type: String):
	match Action_Type:
		"Shoot":
			if PLY_Flags.Perms["Can Use AssaultRifle"] == true:
				SignalBus.emit_signal("LOC_Value_Operator", false, "Stamina", 3.5)
				SignalBus.emit_signal("Player_Animations", "Tools_Anims/Assault_Shoot")
				SignalBus.emit_signal("SubRoutine_Call", "AssaultRifle", "Ammunition Loss")
				SignalBus.emit_signal("request_damage", PLY_Inventory.Tool_ID["AssaultRifle"]["damage"])
				SignalBus.emit_signal("Sig_General_Interaction", %Ray1, "Take_Damage")

func Sword(Action_Type):
	pass
