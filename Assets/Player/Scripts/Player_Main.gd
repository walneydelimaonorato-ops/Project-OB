extends CharacterBody3D
@onready var PlayerRes: Node = %"Player Stats"
@onready var StatsMan: Node = %"Stats Management"
@onready var Action: Node = %Action

@onready var Head: Node3D = %Head
@onready var Eyes: Camera3D = %Eyes

var Running: bool

#var Un_LookUD := Vector2.ZERO
#var Un_LookLR := Vector2.ZERO

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed(Global.Player_Data.Un_Jump) and is_on_floor():
		StatsMan.Stats_Decrease("Stamina", 5)
		velocity.y = 4.5
	
	if Input.is_action_pressed(Global.Player_Data.Un_Sprint): #and PlayerValue.Stamina > 0:
		Global.Player_Data.Base_Speed = Global.Player_Data.Run # Current speed becomes running speed
		Running = true
	else:
		Global.Player_Data.Base_Speed = Global.Player_Data.Dummy_Speed # Current speed falls back to a set value
		Running = false
	
	
	var input_dir = Input.get_vector(Global.Player_Data.Un_Left, Global.Player_Data.Un_Right, Global.Player_Data.Un_Forward, Global.Player_Data.Un_Backward)
	var direction = (Head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * Global.Player_Data.Base_Speed
		velocity.z = direction.z * Global.Player_Data.Base_Speed
		if Running:
			StatsMan.Stats_Decrease("Stamina", 0.15)
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.15)
		velocity.z = lerp(velocity.z, 0.0, 0.15)
	move_and_slide()

func _process(_delta: float) -> void:
	if Global.Player_Data.Control_Mode == "Joy":
		var look_in = Input.get_vector("In_JoyR_Up", "In_JoyR_Down", "In_JoyR_Left", "In_JoyR_Right")
		Head.rotation.y -= look_in.y * Global.Player_Data.Joy_Camera_Sens
		Eyes.rotation.x -= look_in.x * Global.Player_Data.Joy_Camera_Sens
		Eyes.rotation.x = clamp(Eyes.rotation.x, deg_to_rad(-85), deg_to_rad(85))


func _input(input: InputEvent) -> void:
	if Input.is_action_just_pressed(Global.Player_Data.Un_Ready_Menu):
		if Global.Player_Data.Current_Menu == "Ready" or Global.Player_Data.Current_Menu == "none" or Global.Player_Data.Current_Menu == "":
			Global.Player_Data.Ready_Menu_Active = !Global.Player_Data.Ready_Menu_Active
			Global.Player_Data.emit_signal("Ready_Menu_Toggled", Global.Player_Data.Ready_Menu_Active)
	
	if Input.is_action_just_pressed(Global.Player_Data.Un_LPrimary_Tool_Use):
		Action.Action_Primary("Left")
	if Input.is_action_just_pressed(Global.Player_Data.Un_RPrimary_Tool_Use):
		Action.Action_Primary("Right")
	
	if Input.is_action_just_pressed(Global.Player_Data.Un_Tool_Alternive):
		Action.Action_Alternative()
	
	if Global.Player_Data.Control_Mode == "Key":
		if input is InputEventMouseMotion:
			Head.rotation.y -= input.relative.x * Global.Player_Data.Key_Camera_Sens
			Eyes.rotation.x -= input.relative.y * Global.Player_Data.Key_Camera_Sens
			Eyes.rotation.x = clamp(Eyes.rotation.x, deg_to_rad(-85), deg_to_rad(85))
	
	
