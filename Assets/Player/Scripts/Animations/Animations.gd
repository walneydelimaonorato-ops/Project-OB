extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_rich("[color=#ffdf00]Player Animations Working[/color]")
	Tool_Rotation()
	SignalBus.Player_Animations.connect(Play_Animation)
	SignalBus.Tool_Rotation.connect(Tool_Rotation)


func Play_Animation(Animation_Name):
	%"General Animations".play(Animation_Name)

func Tool_Rotation():
	%"Arm Right Rig".visible = false
	%"Arm Left Rig".visible = false
	%"Sword Rig".visible = false
	%"Dagger Rig".visible = false
	%"Hand Gun Rig".visible = false
	%"Assault Rig".visible = false
	%"Latern Rig".visible = false
	
	match Global.Player_Data.Inv_ToolR_Equiped:
		"null":
			%"Arm Right Rig".visible = true
		"Sword":
			%"Sword Rig".visible = true
			%"Sword Rig".scale.x = 1.0
		"Dagger":
			%"Dagger Rig".visible = true
			%"Dagger Rig".scale.x = 1.0
		"HandGun":
			%"Hand Gun Rig".visible = true
			%"Hand Gun Rig".scale.x = 1.0
			%"General Animations".play("Tools_Anims/HandGun_Popup")
		"AssaultRifle":
			%"Assault Rig".visible = true
			%"Assault Rig".scale.x = 1.0
			%"General Animations".play("Tools_Anims/Assault_Popup")
	match Global.Player_Data.Inv_ToolL_Equiped:
		"null":
			%"Arm Left Rig".visible = true
		"Sword":
			%"Sword Rig".visible = true
			%"Sword Rig".scale.x = -1.0
		"Dagger":
			%"Dagger Rig".visible = true
			%"Dagger Rig".scale.x = -1.0
		"HandGun":
			%"Hand Gun Rig".visible = true
			%"Hand Gun Rig".scale.x = -1.0
			%"General Animations".play("Tools_Anims/HandGun_Popup")
		"AssaultRifle":
			%"Assault Rig".visible = true
			%"Assault Rig".scale.x = -1.0
			%"General Animations".play("Tools_Anims/Assault_Popup")
