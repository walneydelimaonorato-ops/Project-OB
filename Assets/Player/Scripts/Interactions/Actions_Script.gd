extends Node
# STATSMAN Node = %"Stats Management"

func _ready() -> void:
	BugBus.emit_signal("Report", "Player", "Player Action Working")
	#IntSigBus.Action.connect(Action_Primary)
	IntSigBus.Action_Alternative.connect(Action_Alternative)
	IntSigBus.Action_Primary.connect(Action_Primary)

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
	IntSigBus.emit_signal("Player_Permissions_Conditionals")
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
			IntSigBus.emit_signal("Sig_General_Interaction", %Ray2, "Interact")
			IntSigBus.emit_signal("Player_Animations", "Tools_Anims/LeftHand_Interact")

func HandGun(Action_Type: String):
	match Action_Type:
		"Shoot":
			if PLY_Flags.Perms["Can Use HandGun"] == true:
				IntSigBus.emit_signal("LOC_Value_Operator", false, "Stamina", 2.0)
				IntSigBus.emit_signal("Player_Animations", "Tools_Anims/HandGun_Shoot")
				IntSigBus.emit_signal("SubRoutine_Call", "HandGun", "Ammunition Loss")
				IntSigBus.emit_signal("request_damage", PLY_Inventory.Tool_ID["HandGun"]["damage"])
				IntSigBus.emit_signal("Sig_General_Interaction", %Ray1, "Take_Damage")
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
				IntSigBus.emit_signal("LOC_Value_Operator", false, "Stamina", 3.5)
				IntSigBus.emit_signal("Player_Animations", "Tools_Anims/Assault_Shoot")
				IntSigBus.emit_signal("SubRoutine_Call", "AssaultRifle", "Ammunition Loss")
				IntSigBus.emit_signal("request_damage", PLY_Inventory.Tool_ID["AssaultRifle"]["damage"])
				IntSigBus.emit_signal("Sig_General_Interaction", %Ray1, "Take_Damage")

func Sword(Action_Type):
	pass
