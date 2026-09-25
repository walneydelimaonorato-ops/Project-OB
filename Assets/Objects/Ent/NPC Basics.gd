extends CUS_NPC

var player = null
var Current_State: NPC_State = NPC_State.CHASE
@onready var NavAgen = $NavAgen
@export var Player_Path: NodePath

const SPEED: float = 3.0
const JUMP_VELOCITY: float = 4.5

func _ready() -> void:
	if Current_State == NPC_State.WANDER:
		Random_Navigation()
	
	player = get_node(Player_Path)
	var Model = NPC_Model.instantiate()
	%Model.add_child(Model)
	if NPC_Hostile == false:
		NPC_AI_LVL = 0

func _process(delta: float) -> void:
	#print(NPC_Wait_Time)
	NPC_Wait_Time -= 1
	if NPC_Wait_Time <= 0:
		NPC_Wait_Time = 60 * 2

func _physics_process(delta: float) -> void:
	velocity = Vector3.ZERO
	
	if Current_State == NPC_State.WANDER:
		pass
	
	elif Current_State == NPC_State.CHASE:
		NavAgen.set_target_position(player.global_position)
	
	var next_nav = NavAgen.get_next_path_position()
	velocity = (next_nav - global_position).normalized() * SPEED
	look_at(next_nav)
	move_and_slide()


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
