extends Node
@onready var PlayerRes: Node = %"Player Stats"
@onready var StatsMan: Node = %"Stats Management"

@onready var General_Animations: AnimationPlayer = $"../../Head/Eyes/Models/General Animations"

@onready var Arm_Left_Rig: Node3D = $"../../Head/Eyes/Models/Master Rig/Arm Left Rig"
@onready var Arm_Right_Rig: Node3D = $"../../Head/Eyes/Models/Master Rig/Arm Right Rig"

@onready var Assault_Rig: Node3D = $"../../Head/Eyes/Models/Master Rig/Assault Rig"
@onready var Assault_Shoot: AudioStreamPlayer2D = $"../../Head/Eyes/Models/Sounds/Assault Shoot"

@onready var HandGun_Rig: Node3D = $"../../Head/Eyes/Models/Master Rig/Hand Gun Rig"
@onready var HandGun_Shoot: AudioStreamPlayer2D = $"../../Head/Eyes/Models/Sounds/HandGun Shoot"

@onready var Latern_Rig: Node3D = $"../../Head/Eyes/Models/Master Rig/Latern Rig"

func _ready() -> void:
	print("Player Action working")
	
	Tool_Rotation()
	PlayerRes.data.Tool_Rotation.connect(Tool_Rotation)

func Tool_Rotation():
	Arm_Right_Rig.visible = false
	Arm_Left_Rig.visible = false
	HandGun_Rig.visible = false
	Assault_Rig.visible = false
	
#region Tools
	match PlayerRes.data.Inv_ToolR_Equiped:
		"null":
			Arm_Right_Rig.visible = true
		"HandGun":
			HandGun_Rig.visible = true
			HandGun_Rig.scale.x = 1.0
			General_Animations.play("Tools_Anims/HandGun_Popup")
		"AssaultRifle":
			Assault_Rig.visible = true
			Assault_Rig.scale.x = 1.0
			General_Animations.play("Tools_Anims/Assault_Popup")
	match PlayerRes.data.Inv_ToolL_Equiped:
		"null":
			Arm_Left_Rig.visible = true
		"HandGun":
			HandGun_Rig.visible = true
			HandGun_Rig.scale.x = -1.0
			General_Animations.play("Tools_Anims/HandGun_Popup")
		"AssaultRifle":
			Assault_Rig.visible = true
			Assault_Rig.scale.x = -1.0
			General_Animations.play("Tools_Anims/Assault_Popup")
#endregion

func Action_Alternative():
	StatsMan.Geneneral_Interaction (%Ray2, "Iteraction")
	General_Animations.play("Tools_Anims/LeftHand_Interact")

func Action_Primary(Direction):
	match Direction:
		"Right":
			match PlayerRes.data.Inv_ToolR_Equiped:
				"HandGun":
					General_Animations.play("Tools_Anims/HandGun_Shoot")
					HandGun_Shoot.play()
				"AssaultRifle":
					General_Animations.play("Tools_Anims/Assault_Shoot")
					Assault_Shoot.play()
		"Left":
			match PlayerRes.data.Inv_ToolL_Equiped:
				pass
