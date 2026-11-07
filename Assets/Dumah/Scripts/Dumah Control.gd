extends CharacterBody3D

var Move_Inp: Vector2 = Vector2.ZERO
var Look_Inp: Vector2 = Vector2.ZERO

@onready var Head: Node3D = %Head
@onready var Cam: Camera3D = %Cam
var Sens: float = 0.003

const SPEED: float = 5.0

func _ready() -> void:
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	Move(delta)
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		Look_Inp = event.relative
		Look()

func Look():
	self.rotation.y -= Look_Inp.x * Sens
	Cam.rotation.x -= Look_Inp.y * Sens
	Cam.rotation.x = clamp(Cam.rotation.x, deg_to_rad(-85), deg_to_rad(85))

func Move(delta: float):
	Move_Inp = Input.get_vector(PLY_Input.Un_Left, PLY_Input.Un_Right, PLY_Input.Un_Forward, PLY_Input.Un_Backward)#Vector2(Input.get_axis(PLY_Input.Un_Backward, PLY_Input.Un_Forward), Input.get_axis(PLY_Input.Un_Left, PLY_Input.Un_Right))
	var direction: Vector3 = (transform.basis * Vector3(Move_Inp.x, 0, Move_Inp.y)).normalized()
	if direction:
		velocity.x = lerp(velocity.x, direction.x * SPEED, 0.08)
		velocity.z = lerp(velocity.z, direction.z * SPEED, 0.08)
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.06)
		velocity.z = lerp(velocity.z, 0.0, 0.06)
