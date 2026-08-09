extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Side_Status_Update()
	SignalBus.Side_Status_Update.connect(Side_Status_Update)

func Side_Status_Update():
	%Stamina.visible = Global.Player_Data.Player_Perms.Can_Show_UI_Stats
	%Health.visible = Global.Player_Data.Player_Perms.Can_Show_UI_Stats
	
	#Health.value = lerp(Health.value, Global.Player_Data.Health, 0.5)
	%Health.max_value = Global.Player_Data.Health_Max
	%Health.value = Global.Player_Data.Health
	%Stamina.max_value = Global.Player_Data.Stamina_Max
	%Stamina.value = Global.Player_Data.Stamina
