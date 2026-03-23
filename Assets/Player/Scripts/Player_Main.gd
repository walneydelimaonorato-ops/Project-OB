extends CharacterBody3D
@export var PlayerRes: Resource

@onready var Head: Node3D = $Head
@onready var Eyes: Camera3D = $Head/Eyes

var Un_LookUD := Vector2.ZERO
var Un_LookLR := Vector2.ZERO

func _ready() -> void:
	match PlayerRes.Control_Mode:
		"Key":
			PlayerRes.Un_Forward = "In_Forward"
			PlayerRes.Un_Backward = "In_Backward"
			PlayerRes.Un_Left = "In_Left"
			PlayerRes.Un_Right = "In_Right"
			PlayerRes.Un_Jump = "In_Jump"
			PlayerRes.Un_Use_UItem = "In_Use_Item"
			PlayerRes.Un_Sprint = "In_Sprint"
			PlayerRes.Un_Ready_Menu = "In_Pause"
			PlayerRes.Un_RPrimary_Tool_Use = "In_Mouse_R"
			PlayerRes.Un_LPrimary_Tool_Use = "In_Mouse_L"
			PlayerRes.Un_RSecondary_Tool_Use = ""
			PlayerRes.Un_LSecondary_Tool_Use = ""
			PlayerRes.Un_Tool_Alternive = "In_Tool_Alt"
			PlayerRes.Un_2Hand_Toggle = ""
		"Joy":
			PlayerRes.Un_Forward = "In_JoyL_Forward"
			PlayerRes.Un_Backward = "In_JoyL_Backward"
			PlayerRes.Un_Left = "In_JoyL_Left"
			PlayerRes.Un_Right = "In_JoyL_Right"
			PlayerRes.Un_Jump = "In_Joy_Jump"
			PlayerRes.Un_Use_UItem = "In_Joy_Use_Item"
			PlayerRes.Un_Sprint = "In_Joy_Sprint"
			PlayerRes.Un_Ready_Menu = "In_Joy_Pause"
			PlayerRes.Un_RPrimary_Tool_Use = "In_Joy_R2"
			PlayerRes.Un_LPrimary_Tool_Use = "In_Joy_L2"
			PlayerRes.Un_RSecondary_Tool_Use = ""
			PlayerRes.Un_LSecondary_Tool_Use = ""
			PlayerRes.Un_Tool_Alternive = "In_Joy_Tool_Alt"
			PlayerRes.Un_2Hand_Toggle = ""

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed(PlayerRes.Un_Jump) and is_on_floor():
		velocity.y = 4.5
	
	if Input.is_action_pressed(PlayerRes.Un_Sprint): #and PlayerValue.Stamina > 0:
		PlayerRes.Base_Speed = PlayerRes.Run # Current speed becomes running speed
		#Sprinting = true
		#PlayerValue.Stats_decrease("Stamina", 0.1)
	else: #Input.is_action_just_released("In_Sprint"):
		PlayerRes.Base_Speed = PlayerRes.Dummy_Speed # Current speed falls back to a set value
		#Sprinting = false
	
	
	var input_dir := Input.get_vector(PlayerRes.Un_Left, PlayerRes.Un_Right, PlayerRes.Un_Forward, PlayerRes.Un_Backward)
	var direction := (Head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * PlayerRes.Base_Speed
		velocity.z = direction.z * PlayerRes.Base_Speed
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.15)
		velocity.z = lerp(velocity.z, 0.0, 0.15)
	move_and_slide()

func _process(_delta: float) -> void:
	if PlayerRes.Control_Mode == "Joy":
		var look_in = Input.get_vector("In_JoyR_Up", "In_JoyR_Down", "In_JoyR_Left", "In_JoyR_Right")
		Head.rotation.y -= look_in.y * PlayerRes.Joy_Camera_Sens
		Eyes.rotation.x -= look_in.x * PlayerRes.Joy_Camera_Sens
		Eyes.rotation.x = clamp(Eyes.rotation.x, deg_to_rad(-85), deg_to_rad(85))


func _input(input: InputEvent) -> void:
	if PlayerRes.Control_Mode == "Key":
		if input is InputEventMouseMotion:
			Head.rotation.y -= input.relative.x * PlayerRes.Key_Camera_Sens
			Eyes.rotation.x -= input.relative.y * PlayerRes.Key_Camera_Sens
			Eyes.rotation.x = clamp(Eyes.rotation.x, deg_to_rad(-85), deg_to_rad(85))
