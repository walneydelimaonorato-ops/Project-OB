extends Node

func _ready() -> void:
	BugBus.emit_signal("Report", "Player", "Side Status Working")
	Side_Status_Update()
	IntSigBus.Side_Status_Update.connect(Side_Status_Update)

func Side_Status_Update():
	%Stamina.visible = PLY_Flags.Perms["Can Show UI Stats"]
	%Health.visible = PLY_Flags.Perms["Can Show UI Stats"]
	
	#Health.value = lerp(Health.value, PLY_Var.Health, 0.5)
	%Health.max_value = PLY_Var.Health_Max
	%Health.value = PLY_Var.Health
	%Stamina.max_value = PLY_Var.Stamina_Max
	%Stamina.value = PLY_Var.Stamina
