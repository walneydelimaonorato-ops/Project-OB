extends Node
@onready var PlayerRes: Node = %"Player Stats"
# STATSMAN Node = %"Stats Management"

func _ready() -> void:
	print("Player Action working")
	#SignalBus.Action.connect(Action_Primary)
	SignalBus.Action_Alternative.connect(Action_Alternative)
	SignalBus.Action_Primary.connect(Action_Primary)

func Action_Alternative(Action_Method):
	if Action_Method == "Action_Alternative":
		if Global.Player_Data.Inv_ToolL_Equiped == "null":
			SignalBus.emit_signal("Sig_General_Interaction", %Ray2, "Iteraction")
			SignalBus.emit_signal("Player_Animations", "Tools_Anims/LeftHand_Interact")
		# STATSMAN.Geneneral_Interaction(%Ray2, "Iteraction")
		# STATSMAN.General_Animations.play("Tools_Anims/LeftHand_Interact")

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
			
		#match Direction:
			#"Right":
				#match Global.Player_Data.Inv_ToolR_Equiped:
					#"null":
						#pass
					#"HandGun":
						## STATSMAN.General_Animations.play("Tools_Anims/HandGun_Shoot")
						## STATSMAN.HandGun_Shoot.play()
					#"AssaultRifle":
						## STATSMAN.General_Animations.play("Tools_Anims/Assault_Shoot")
						## STATSMAN.Assault_Shoot.play()
						#
				#if Global.Player_Data.Inv_ToolR_Equiped != "null":
					#SignalBus.emit_signal("request_damage", Global.Player_Data.Tool_ID[Global.Player_Data.Inv_ToolR_Equiped]["damage"])
					## STATSMAN.Geneneral_Interaction(%Ray1, "Take_Damage")
			#"Left":
				#match Global.Player_Data.Inv_ToolL_Equiped:
					#"null":
						#pass
					#"HandGun":
						## STATSMAN.General_Animations.play("Tools_Anims/HandGun_Shoot")
						## STATSMAN.HandGun_Shoot.play()
					#"AssaultRifle":
						## STATSMAN.General_Animations.play("Tools_Anims/Assault_Shoot")
						## STATSMAN.Assault_Shoot.play()
						#
				#if Global.Player_Data.Inv_ToolL_Equiped != "null":
					#SignalBus.emit_signal("request_damage", Global.Player_Data.Tool_ID[Global.Player_Data.Inv_ToolL_Equiped]["damage"])
					## STATSMAN.Geneneral_Interaction(%Ray1, "Take_Damage")
func HandGun(Action_Type: String):
	match Action_Type:
		"Shoot":
			SignalBus.emit_signal("Player_Animations", "Tools_Anims/HandGun_Shoot")
			SignalBus.emit_signal("request_damage", Global.Player_Data.Tool_ID["HandGun"]["damage"])
			SignalBus.emit_signal("Sig_General_Interaction", %Ray1, "Take_Damage")
	
func AssaultRifle(Action_Type: String):
	match Action_Type:
		"Shoot":
			SignalBus.emit_signal("Player_Animations", "Tools_Anims/Assault_Shoot")
			SignalBus.emit_signal("request_damage", Global.Player_Data.Tool_ID["AssaultRifle"]["damage"])
			SignalBus.emit_signal("Sig_General_Interaction", %Ray1, "Take_Damage")
