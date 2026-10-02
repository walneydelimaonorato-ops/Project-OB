extends Node

@onready var NPC_ROOT: CUS_NPC = owner as CUS_NPC
var Can_Call_Random_Wait: bool = true

func _physics_process(delta: float) -> void:
	if %"Hit Detector".is_colliding() and NPC_ROOT.Current_State == NPC_ROOT.NPC_State.CHASE:
		if Can_Call_Random_Wait == true:
			NPC_ROOT.Random_Wait(60, 1)
			Can_Call_Random_Wait = false
		#get_tree().quit()
	
	if %"Close Sphere Detector".is_colliding() or %"Line Sight Detector".is_colliding():
		NPC_ROOT.Current_State = NPC_ROOT.NPC_State.CHASE
	
	if not %"Far Sphere Detector".is_colliding() and NPC_ROOT.Current_State == NPC_ROOT.NPC_State.CHASE:
		if Can_Call_Random_Wait == true:
			NPC_ROOT.Random_Wait(30, 2)
			Can_Call_Random_Wait = false
		
		if NPC_ROOT.NPC_Wait_Time <= 0:
			NPC_ROOT.Current_State = NPC_ROOT.NPC_State.WANDER
			Can_Call_Random_Wait = true
