extends Node
@onready var PlayerRes: Node = %"Player Stats"
# STATSMAN Node = %"Stats Management"

func _ready() -> void:
	print_rich("[color=#ffdf00]Player Action Working[/color]")
	#SignalBus.Action.connect(Action_Primary)
	SignalBus.Action_Alternative.connect(Action_Alternative)
	SignalBus.Action_Primary.connect(Action_Primary)

func Action_Alternative(Direction):
	match Direction:
		"Right":
			match Global.Player_Data.Inv_ToolR_Equiped:
				"null":
					pass
				"HandGun":
					HandGun("Reload")
				"AssaultRifle":
					AssaultRifle("reload")
		"Left":
			match Global.Player_Data.Inv_ToolL_Equiped:
				"null":
					Hand("Interact")
				"HandGun":
					HandGun("Reload")
				"AssaultRifle":
					AssaultRifle("Reload")

func Action_Primary(Direction):
	match Direction:
		"Right":
			match Global.Player_Data.Inv_ToolR_Equiped:
				"null":
					pass
				"HandGun":
					HandGun("Shoot")
				"AssaultRifle":
					AssaultRifle("Shoot")
		"Left":
			match Global.Player_Data.Inv_ToolL_Equiped:
				"null":
					pass
				"HandGun":
					HandGun("Shoot")
				"AssaultRifle":
					AssaultRifle("Shoot")

func Hand(Action_Type: String):
	match Action_Type:
		"Interact":
			SignalBus.emit_signal("Sig_General_Interaction", %Ray2, "Iteraction")
			SignalBus.emit_signal("Player_Animations", "Tools_Anims/LeftHand_Interact")

func HandGun(Action_Type: String):
	match Action_Type:
		"Shoot":
			if Global.Player_Data.Player_Perms["Can_Use_HandGun"] == true:
				SignalBus.emit_signal("Player_Animations", "Tools_Anims/HandGun_Shoot")
				SignalBus.emit_signal("SubRoutine_Call", "HandGun", "Ammunition Loss")
				SignalBus.emit_signal("request_damage", Global.Player_Data.Tool_ID["HandGun"]["damage"])
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
			if Global.Player_Data.Player_Perms["Can_Use_AssaultRifle"] == true:
				SignalBus.emit_signal("Player_Animations", "Tools_Anims/Assault_Shoot")
				SignalBus.emit_signal("SubRoutine_Call", "AssaultRifle", "Ammunition Loss")
				SignalBus.emit_signal("request_damage", Global.Player_Data.Tool_ID["AssaultRifle"]["damage"])
				SignalBus.emit_signal("Sig_General_Interaction", %Ray1, "Take_Damage")

func Sword(Action_Type):
	pass
