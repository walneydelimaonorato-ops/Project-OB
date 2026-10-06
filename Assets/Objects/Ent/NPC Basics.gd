extends CUS_NPC

var Current_State: NPC_State = NPC_State.WANDER
@onready var NavAgen = $NavAgen
var Next_Nav_Point: Vector3

const SPEED: float = 1.5
const JUMP_VELOCITY: float = 4.5

func _ready() -> void:
	if Current_State == NPC_State.WANDER:
		Random_Navigation()
	
	if NPC_Model:
		%Model.remove_child(%"Place Holder")
		var Model = NPC_Model.instantiate()
		%Model.add_child(Model)
	
	if NPC_Hostile == false:
		NPC_AI_LVL = 0

func _process(delta: float) -> void:
	if NPC_Wait_Count == true:
		NPC_Wait_Time -= 1
	
	if NPC_Wait_Time <= 0:
		NPC_Wait_Count = false

func _physics_process(delta: float) -> void:
	velocity = Vector3.ZERO
	
	if Current_State == NPC_State.WANDER:
		pass
	
	elif Current_State == NPC_State.CHASE:
		if get_tree().get_root().find_child("Player", true, false):
			NavAgen.set_target_position(get_tree().get_root().find_child("Player", true, false).GLOBAL_position)
	
	Next_Nav_Point = NavAgen.get_next_path_position()
	velocity = (Next_Nav_Point - global_position).normalized() * SPEED
	move_and_slide()
	look_at(Next_Nav_Point)

func navagen_navigation_finished() -> void:
	if Current_State == NPC_State.WANDER:
		Random_Navigation()

func Random_Navigation():
	var RanX: int
	var RanY: int
	var RanPos: Vector3
	
	RanX = randi_range(-5, 5)
	RanY = randi_range(-5, 5)
	RanPos = Vector3(RanX, 0, RanY)
	NavAgen.set_target_position(RanPos)

func Random_Wait(Wait: int, Max_Ran_Mod: int):
	var RanMod: int = randi_range(1, Max_Ran_Mod)
	NPC_Wait_Time = Wait * RanMod
	NPC_Wait_Count = true
