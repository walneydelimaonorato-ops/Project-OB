extends Node

#TH_Active_Valid: bool = false
#TH_Active: bool = false

#TH_Timing: float = 0.00
#TH_Threshold: float = 2.25

#TH_Tapped: bool = false
#TH_Held: bool = false

#Global.Player_Data.TH_Active

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_rich("[color=#ffdf00]Player Hold-Tap Working[/color]")
	SignalBus.Tap_Hold_Interval.connect(Hold_Tap_Innitializer)

func Hold_Tap_Innitializer():
	Global.Player_Data.TH_Active = true
	Global.Player_Data.TH_Tapped = false
	Global.Player_Data.TH_Held = false

func _process(delta: float) -> void:
	Hold_Tap_Timer(delta)
	if Input.is_action_just_released(Global.Player_Data.Un_Tool_Alternive) or Global.Player_Data.TH_Timing > Global.Player_Data.TH_Threshold:
		Hold_Tap_Stale(Global.Player_Data.TH_Timing)
		Global.Player_Data.TH_Active = false
		Global.Player_Data.TH_Timing = 0

func Hold_Tap_Timer(Delta: float):
	if Global.Player_Data.TH_Active == true:
		Global.Player_Data.TH_Timing += Delta

func Hold_Tap_Stale(Result: float):
	if Result < Global.Player_Data.TH_Threshold:
		Global.Player_Data.TH_Tapped = true
		SignalBus.emit_signal("Action_Alternative", "Left")
	elif Result >= Global.Player_Data.TH_Threshold:
		SignalBus.emit_signal("Action_Alternative", "Right")
		Global.Player_Data.TH_Held = true


#region FUCKRFUCFKFUCKFUCKFUCFKLFUCKFUCKFUKFCUF
#func _process(delta: float) -> void:
	#Hold_Tap_Timing(delta)
	#
	#if Global.Player_Data.TH_Timing < Global.Player_Data.TH_Threshold:
		#Global.Player_Data.TH_Active_Valid = true
		#Global.Player_Data.TH_Active = Global.Player_Data.TH_Active_Valid
	#elif Global.Player_Data.TH_Timing >= Global.Player_Data.TH_Threshold + 0.5:
		#Global.Player_Data.TH_Active_Valid = false
		#Global.Player_Data.TH_Active = Global.Player_Data.TH_Active_Valid
	#
	#if Input.is_action_just_released(Global.Player_Data.Un_Tool_Alternive) and Global.Player_Data.TH_Active_Valid == false:
		#Global.Player_Data.TH_Timing = 0
#
#func Hold_Tap_Interval():
	#Global.Player_Data.TH_Tapped = false
	#Global.Player_Data.TH_Held = false
	#
	#if Global.Player_Data.TH_Active_Valid == true:
		#Global.Player_Data.TH_Active = true
	#elif Global.Player_Data.TH_Active_Valid == false:
		#Global.Player_Data.TH_Active = false
#
#func Hold_Tap_Stale(TH_Time: float):
	#if TH_Time < Global.Player_Data.TH_Threshold:
		#Global.Player_Data.TH_Tapped = true
		#SignalBus.emit_signal("Action_Alternative", "Left")
	#elif TH_Time >= Global.Player_Data.TH_Threshold:
		#Global.Player_Data.TH_Held = true
		#SignalBus.emit_signal("Action_Alternative", "Right")
#
#func Hold_Tap_Timing(delta):
	##print("TH_Active: ", Global.Player_Data.TH_Active, " Timing: ", Global.Player_Data.TH_Timing)
	#if Global.Player_Data.TH_Active == true:
		#Global.Player_Data.TH_Timing += delta
		##print("Timing: ", Global.Player_Data.TH_Timing)
	#
	#if Input.is_action_just_released(Global.Player_Data.Un_Tool_Alternive) and Global.Player_Data.TH_Active_Valid == true:
		#Hold_Tap_Stale(Global.Player_Data.TH_Timing)
		#Global.Player_Data.TH_Timing = 0
	#elif Global.Player_Data.TH_Timing >= Global.Player_Data.TH_Threshold:
		#Hold_Tap_Stale(Global.Player_Data.TH_Timing)
		#
	#
		#
#endregion
