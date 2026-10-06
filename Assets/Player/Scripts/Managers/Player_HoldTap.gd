extends Node

#TH_Active_Valid: bool = false
#TH_Active: bool = false

#TH_Timing: float = 0.00
#TH_Threshold: float = 2.25

#TH_Tapped: bool = false
#TH_Held: bool = false

#GLOBAL.Player_Data.TH_Active

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BugBus.emit_signal("Report", "Player", "Player Hold-Tap Working")
	SignalBus.Tap_Hold_Interval.connect(Hold_Tap_Innitializer)

func Hold_Tap_Innitializer():
	PLY_Var.TH_Active = true
	PLY_Var.TH_Tapped = false
	PLY_Var.TH_Held = false

func _process(delta: float) -> void:
	Hold_Tap_Timer(delta)
	if Input.is_action_just_released(PLY_Input.Un_Tool_Alternive) or PLY_Var.TH_Timing > PLY_Var.TH_Threshold:
		Hold_Tap_Stale(PLY_Var.TH_Timing)
		PLY_Var.TH_Active = false
		PLY_Var.TH_Timing = 0

func Hold_Tap_Timer(Delta: float):
	if PLY_Var.TH_Active == true:
		PLY_Var.TH_Timing += Delta

func Hold_Tap_Stale(Result: float):
	if Result < PLY_Var.TH_Threshold:
		PLY_Var.TH_Tapped = true
		SignalBus.emit_signal("Action_Alternative", "Left")
	elif Result >= PLY_Var.TH_Threshold:
		SignalBus.emit_signal("Action_Alternative", "Right")
		PLY_Var.TH_Held = true


#region FUCKRFUCFKFUCKFUCKFUCFKLFUCKFUCKFUKFCUF
#func _process(delta: float) -> void:
	#Hold_Tap_Timing(delta)
	#
	#if GLOBAL.Player_Data.TH_Timing < GLOBAL.Player_Data.TH_Threshold:
		#GLOBAL.Player_Data.TH_Active_Valid = true
		#GLOBAL.Player_Data.TH_Active = GLOBAL.Player_Data.TH_Active_Valid
	#elif GLOBAL.Player_Data.TH_Timing >= GLOBAL.Player_Data.TH_Threshold + 0.5:
		#GLOBAL.Player_Data.TH_Active_Valid = false
		#GLOBAL.Player_Data.TH_Active = GLOBAL.Player_Data.TH_Active_Valid
	#
	#if Input.is_action_just_released(GLOBAL.Player_Data.Un_Tool_Alternive) and GLOBAL.Player_Data.TH_Active_Valid == false:
		#GLOBAL.Player_Data.TH_Timing = 0
#
#func Hold_Tap_Interval():
	#GLOBAL.Player_Data.TH_Tapped = false
	#GLOBAL.Player_Data.TH_Held = false
	#
	#if GLOBAL.Player_Data.TH_Active_Valid == true:
		#GLOBAL.Player_Data.TH_Active = true
	#elif GLOBAL.Player_Data.TH_Active_Valid == false:
		#GLOBAL.Player_Data.TH_Active = false
#
#func Hold_Tap_Stale(TH_Time: float):
	#if TH_Time < GLOBAL.Player_Data.TH_Threshold:
		#GLOBAL.Player_Data.TH_Tapped = true
		#SignalBus.emit_signal("Action_Alternative", "Left")
	#elif TH_Time >= GLOBAL.Player_Data.TH_Threshold:
		#GLOBAL.Player_Data.TH_Held = true
		#SignalBus.emit_signal("Action_Alternative", "Right")
#
#func Hold_Tap_Timing(delta):
	##print("TH_Active: ", GLOBAL.Player_Data.TH_Active, " Timing: ", GLOBAL.Player_Data.TH_Timing)
	#if GLOBAL.Player_Data.TH_Active == true:
		#GLOBAL.Player_Data.TH_Timing += delta
		##print("Timing: ", GLOBAL.Player_Data.TH_Timing)
	#
	#if Input.is_action_just_released(GLOBAL.Player_Data.Un_Tool_Alternive) and GLOBAL.Player_Data.TH_Active_Valid == true:
		#Hold_Tap_Stale(GLOBAL.Player_Data.TH_Timing)
		#GLOBAL.Player_Data.TH_Timing = 0
	#elif GLOBAL.Player_Data.TH_Timing >= GLOBAL.Player_Data.TH_Threshold:
		#Hold_Tap_Stale(GLOBAL.Player_Data.TH_Timing)
		#
	#
		#
#endregion
