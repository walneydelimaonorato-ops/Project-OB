extends Node

var Can_Update: bool = true
@onready var Sta_Bar: TextureProgressBar = %Stamina
@onready var Hea_Bar: TextureProgressBar = %Health

func _process(delta: float) -> void:
	if Can_Update == false:
		return
	
	Bar_Update()

func Bar_Update():
	if Can_Update == false:
		Can_Update = true
	if Hea_Bar.value == PLY_Data.Health and Sta_Bar.value == PLY_Data.Stamina:
		Can_Update = false
	
	Sta_Bar.max_value = PLY_Data.Max_Health
	Sta_Bar.max_value = PLY_Data.Max_Stamina
	
	Hea_Bar.value = move_toward(Hea_Bar.value, PLY_Data.Health, 0.1)
	
