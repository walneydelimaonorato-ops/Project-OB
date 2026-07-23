extends Node

var Target_Tool: String = "null"
var Target_SubRoutine: String = "null"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.SubRoutine_Call.connect(Tool_Subroutine_Sorting)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Tool_Subroutine_Sorting(Tool: String, Routine: String):
	match Routine:
		"Ammunition Loss":
			Ammunition_Loss(Tool)
	
	SignalBus.emit_signal("Side_HUD_Update")

func Ammunition_Loss(Tool: String):
	Global.Player_Data.Tool_ID[Tool]["Ammo"] -= 1
	
	
