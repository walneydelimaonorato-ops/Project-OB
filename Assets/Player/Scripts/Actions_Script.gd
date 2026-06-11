extends Node
@onready var PlayerRes: Node = %"Player Stats"
# STATSMAN Node = %"Stats Management"

func _ready() -> void:
	print("Player Action working")

func Action_Alternative():
	# STATSMAN.Geneneral_Interaction(%Ray2, "Iteraction")
	# STATSMAN.General_Animations.play("Tools_Anims/LeftHand_Interact")

func Action_Primary(Direction):
	match Direction:
		"Right":
			match Global.Player_Data.Inv_ToolR_Equiped:
				"null":
					pass
				"HandGun":
					# STATSMAN.General_Animations.play("Tools_Anims/HandGun_Shoot")
					# STATSMAN.HandGun_Shoot.play()
				"AssaultRifle":
					# STATSMAN.General_Animations.play("Tools_Anims/Assault_Shoot")
					# STATSMAN.Assault_Shoot.play()
					
			if Global.Player_Data.Inv_ToolR_Equiped != "null":
				SignalBus.emit_signal("request_damage", Global.Player_Data.Tool_ID[Global.Player_Data.Inv_ToolR_Equiped]["damage"])
				# STATSMAN.Geneneral_Interaction(%Ray1, "Take_Damage")
		"Left":
			match Global.Player_Data.Inv_ToolL_Equiped:
				"null":
					pass
				"HandGun":
					# STATSMAN.General_Animations.play("Tools_Anims/HandGun_Shoot")
					# STATSMAN.HandGun_Shoot.play()
				"AssaultRifle":
					# STATSMAN.General_Animations.play("Tools_Anims/Assault_Shoot")
					# STATSMAN.Assault_Shoot.play()
					
			if Global.Player_Data.Inv_ToolL_Equiped != "null":
				SignalBus.emit_signal("request_damage", Global.Player_Data.Tool_ID[Global.Player_Data.Inv_ToolL_Equiped]["damage"])
				# STATSMAN.Geneneral_Interaction(%Ray1, "Take_Damage")
