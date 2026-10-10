extends Node

func _ready() -> void:
	BugBus.emit_signal("Report", "Player", "Player Animations Working")
	Tool_Rotation()
	IntSigBus.Player_Animations.connect(Play_Animation)
	IntSigBus.Tool_Rotation.connect(Tool_Rotation)

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
	
	if PLY_Inventory.Inv_ToolR_Equiped != "null":
		match PLY_Inventory.Inv_ToolR_Equiped:
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
	else:
		%"Arm Right Rig".visible = true
	
	if PLY_Inventory.Inv_ToolL_Equiped != "null":
		match PLY_Inventory.Inv_ToolL_Equiped:
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
	else:
		%"Arm Left Rig".visible = true
