extends Node
@onready var PlayerRes: Node = %"Player Stats"
@onready var StatsMan: Node = %"Stats Management"

@onready var Assault_Rig: Node3D = $"../../Head/Eyes/Models/Master Rig/Assault Rig"
@onready var HandGun_Rig: Node3D = $"../../Head/Eyes/Models/Master Rig/Hand Gun Rig"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Player Action working")
	
	PlayerRes.data.Tool_Rotation.connect(Tool_Rotation)

func Tool_Rotation():
	match PlayerRes.data.Inv_ToolR_Equiped:
		"HandGun":
			HandGun_Rig.visible = true
			HandGun_Rig.scale.x = 1.0
		"AssaultRifle":
			Assault_Rig.visible = true
			Assault_Rig.scale.x = 1.0
	match PlayerRes.data.Inv_ToolL_Equiped:
		"AssaultRifle":
			Assault_Rig.visible = true
			Assault_Rig.scale.x = -1.0
		"HandGun":
			HandGun_Rig.visible = true
			HandGun_Rig.scale.x = 1.0

func Action_Alternative():
	StatsMan.Geneneral_Interaction (%Ray2, "Iteraction")

func Action_Primary(Direction):
	match Direction:
		"Right":
			match PlayerRes.data.Inv_ToolR_Equiped:
				pass
		"Left":
			match PlayerRes.data.Inv_ToolL_Equiped:
				pass
