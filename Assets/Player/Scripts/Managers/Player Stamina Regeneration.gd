extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_rich("[color=#ffdf00]Stamina Regeneration Working[/color]")
	Regeneration_Timer_Startup()
	Global.Player_Data.Stamina_Regeneration_Delay_Timer.timeout.connect(Start_Stamina_Regeneration)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Stamina_Regeneration_Process(delta)

func Regeneration_Timer_Startup():
	Global.Player_Data.Stamina_Regeneration_Delay_Timer = Timer.new()
	Global.Player_Data.Stamina_Regeneration_Delay_Timer.wait_time = Global.Player_Data.Stamina_Regeneration_Amount
	Global.Player_Data.Stamina_Regeneration_Delay_Timer.one_shot = true
	add_child(Global.Player_Data.Stamina_Regeneration_Delay_Timer)

func Start_Stamina_Regeneration():
	Global.Player_Data.Stamina_Regeneration_Active = true

func Stamina_Regeneration_Process(delta):
	if Global.Player_Data.Stamina_Regeneration_Active == true and Global.Player_Data.Stamina < Global.Player_Data.Stamina_Max:
		Global.Player_Data.Stamina += Global.Player_Data.Stamina_Regeneration_Rate * delta
		SignalBus.emit_signal("Side_Status_Update")
		if Global.Player_Data.Stamina >= Global.Player_Data.Stamina_Max:
			Global.Player_Data.Stamina = Global.Player_Data.Stamina_Max
			Global.Player_Data.Stamina_Regeneration_Active = false
