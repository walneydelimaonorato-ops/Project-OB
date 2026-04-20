extends Node
@onready var PlayerRes: Node = %"Player Stats"
@onready var StatsMan: Node = %"Stats Management"

func _ready() -> void:
	print("Player Action working")
	

func Action_Alternative():
	StatsMan.Geneneral_Interaction(%Ray2, "Iteraction")
	StatsMan.General_Animations.play("Tools_Anims/LeftHand_Interact")

func Action_Primary(Direction):
	match Direction:
		"Right":
			match PlayerRes.data.Inv_ToolR_Equiped:
				"HandGun":
					StatsMan.General_Animations.play("Tools_Anims/HandGun_Shoot")
					StatsMan.HandGun_Shoot.play()
				"AssaultRifle":
					StatsMan.General_Animations.play("Tools_Anims/Assault_Shoot")
					StatsMan.Assault_Shoot.play()
					StatsMan.Geneneral_Interaction(%Ray1, "Take_Damage")
		"Left":
			match PlayerRes.data.Inv_ToolL_Equiped:
				"HandGun":
					StatsMan.General_Animations.play("Tools_Anims/HandGun_Shoot")
					StatsMan.HandGun_Shoot.play()
				"AssaultRifle":
					StatsMan.General_Animations.play("Tools_Anims/Assault_Shoot")
					StatsMan.Assault_Shoot.play()
