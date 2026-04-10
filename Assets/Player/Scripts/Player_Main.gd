extends CharacterBody3D
@onready var PlayerVars: Node = %"Player Stats"
@onready var StatsMan: Node = %"Stats Management"

@onready var Head: Node3D = %Head
@onready var Eyes: Camera3D = %Eyes

var Un_LookUD := Vector2.ZERO
var Un_LookLR := Vector2.ZERO

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed(PlayerVars.data.Un_Jump) and is_on_floor():
		StatsMan.Stats_Decrease("Stamina", 5)
		PlayerVars.data.Health -= 1
		velocity.y = 4.5
	
	if Input.is_action_pressed(PlayerVars.data.Un_Sprint): #and PlayerValue.Stamina > 0:
		PlayerVars.data.Base_Speed = PlayerVars.data.Run # Current speed becomes running speed
		#Sprinting = true
		#PlayerValue.Stats_decrease("Stamina", 0.1)
	else: #Input.is_action_just_released("In_Sprint"):
		PlayerVars.data.Base_Speed = PlayerVars.data.Dummy_Speed # Current speed falls back to a set value
		#Sprinting = false
	
	
	var input_dir := Input.get_vector(PlayerVars.data.Un_Left, PlayerVars.data.Un_Right, PlayerVars.data.Un_Forward, PlayerVars.data.Un_Backward)
	var direction := (Head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * PlayerVars.data.Base_Speed
		velocity.z = direction.z * PlayerVars.data.Base_Speed
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.15)
		velocity.z = lerp(velocity.z, 0.0, 0.15)
	move_and_slide()

func _process(_delta: float) -> void:
	if PlayerVars.data.Control_Mode == "Joy":
		var look_in = Input.get_vector("In_JoyR_Up", "In_JoyR_Down", "In_JoyR_Left", "In_JoyR_Right")
		Head.rotation.y -= look_in.y * PlayerVars.data.Joy_Camera_Sens
		Eyes.rotation.x -= look_in.x * PlayerVars.data.Joy_Camera_Sens
		Eyes.rotation.x = clamp(Eyes.rotation.x, deg_to_rad(-85), deg_to_rad(85))


func _input(input: InputEvent) -> void:
	if Input.is_action_just_pressed(PlayerVars.data.Un_Ready_Menu):
		PlayerVars.data.Ready_Menu_Active = !PlayerVars.data.Ready_Menu_Active
		PlayerVars.data.emit_signal("Ready_Menu_Toggled", PlayerVars.data.Ready_Menu_Active)
	
	if PlayerVars.data.Control_Mode == "Key":
		if input is InputEventMouseMotion:
			Head.rotation.y -= input.relative.x * PlayerVars.data.Key_Camera_Sens
			Eyes.rotation.x -= input.relative.y * PlayerVars.data.Key_Camera_Sens
			Eyes.rotation.x = clamp(Eyes.rotation.x, deg_to_rad(-85), deg_to_rad(85))
