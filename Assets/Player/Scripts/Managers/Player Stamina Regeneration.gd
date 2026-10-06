extends Node

func _ready() -> void:
	BugBus.emit_signal("Report", "Player", "Stamina Regeneration Working")
	Regeneration_Timer_Startup()
	PLY_Var.Stamina_Regeneration_Delay_Timer.timeout.connect(Start_Stamina_Regeneration)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Stamina_Regeneration_Process(delta)

func Regeneration_Timer_Startup():
	PLY_Var.Stamina_Regeneration_Delay_Timer = Timer.new()
	PLY_Var.Stamina_Regeneration_Delay_Timer.wait_time = PLY_Var.Stamina_Regeneration_Amount
	PLY_Var.Stamina_Regeneration_Delay_Timer.one_shot = true
	add_child(PLY_Var.Stamina_Regeneration_Delay_Timer)

func Start_Stamina_Regeneration():
	PLY_Var.Stamina_Regeneration_Active = true

func Stamina_Regeneration_Process(delta):
	if PLY_Var.Stamina_Regeneration_Active == true and PLY_Var.Stamina < PLY_Var.Stamina_Max:
		PLY_Var.Stamina += PLY_Var.Stamina_Regeneration_Rate * delta
		SignalBus.emit_signal("Side_Status_Update")
		if PLY_Var.Stamina >= PLY_Var.Stamina_Max:
			PLY_Var.Stamina = PLY_Var.Stamina_Max
			PLY_Var.Stamina_Regeneration_Active = false
