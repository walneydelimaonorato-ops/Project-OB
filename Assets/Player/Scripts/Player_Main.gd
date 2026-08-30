extends CharacterBody3D
@onready var PlayerRes: Node = %"Player Stats"
# STATSMAN Node = %"Stats Management"
@onready var Action: Node = %Action

@onready var Head: Node3D = %Head
@onready var Eyes: Camera3D = %Eyes

var Running: bool

#var Un_LookUD := Vector2.ZERO
#var Un_LookLR := Vector2.ZERO

func _ready() -> void:
	print_rich("[color=green]Player Working[/color] [color=#b76e79]\r========================= \r. \r. \r. \r. \r.[/color]")
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#Input.mouse_mode = Input.MOUSE_MODE_MAX

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and Global.Player_Data.Debug_Fly == false:
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Global.Player_Data.Debug_Fly == false:
		if Input.is_action_just_pressed(Global.Player_Data.Un_Jump) and is_on_floor():
			velocity.y = 4.5
	
	elif Global.Player_Data.Debug_Fly == true:
		if Input.is_action_pressed(Global.Player_Data.Un_Jump):
			position.y += 0.1
			velocity.y = 0
		if Input.is_action_pressed(Global.Player_Data.Un_Sprint):
			position.y -= 0.1
			velocity.y = 0
	
	
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
			SignalBus.emit_signal("Variable_Operation", "Decrease", "Stamina", 0.2)
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.15)
		velocity.z = lerp(velocity.z, 0.0, 0.15)
	
	if Global.Player_Data.Player_Perms.Can_Move == true:
		move_and_slide()
		Camera_Tilt(input_dir.x, input_dir.y, delta)

func _process(_delta: float) -> void:
	Global.Player_Data.Player_Position = self.global_position
	Global.Player_Data.Player_Rotation = self.global_rotation
	
	if Global.Player_Data.Control_Mode == "Joy":
		var look_in = Input.get_vector("In_JoyR_Up", "In_JoyR_Down", "In_JoyR_Left", "In_JoyR_Right")
		Head.rotation.y -= look_in.y * Global.Player_Data.Joy_Camera_Sens
		Eyes.rotation.x -= look_in.x * Global.Player_Data.Joy_Camera_Sens
		Eyes.rotation.x = clamp(Eyes.rotation.x, deg_to_rad(-85), deg_to_rad(85))

func _input(input: InputEvent) -> void:
	if Input.is_action_just_pressed(Global.Player_Data.Un_Ready_Menu):
		if Global.Player_Data.Current_Menu == "null" or Global.Player_Data.Current_Menu == "Ready":
			SignalBus.emit_signal("Menu_Setting", "Ready")
	
	if Input.is_action_just_pressed(Global.Player_Data.Un_LPrimary_Tool_Use):
		
		SignalBus.emit_signal("Action_Primary", "Left")
	if Input.is_action_just_pressed(Global.Player_Data.Un_RPrimary_Tool_Use):
		
		SignalBus.emit_signal("Action_Primary", "Right")
	
	if Input.is_action_just_pressed(Global.Player_Data.Un_Cycle_UItem):
		SignalBus.emit_signal("UItem_Cycle")
	
	if Input.is_action_just_pressed(Global.Player_Data.Un_Use_UItem):
		SignalBus.emit_signal("UItem_Use") #UItem_Use
	
	if Input.is_action_just_pressed(Global.Player_Data.Un_Tool_Alternive):
		SignalBus.emit_signal("Tap_Hold_Interval")
		#print(SignalBus.Tap_Hold_Interval.get_connections())
	
	if Global.Player_Data.Control_Mode == "Key" and Global.Player_Data.Context_Debug == 0:
		if input is InputEventMouseMotion and Global.Player_Data.Player_Perms.Can_Look == true:
			Head.rotation.y -= input.relative.x * Global.Player_Data.Key_Camera_Sens
			Eyes.rotation.x -= input.relative.y * Global.Player_Data.Key_Camera_Sens
			Eyes.rotation.x = clamp(Eyes.rotation.x, deg_to_rad(-85), deg_to_rad(85))

func Camera_Tilt(input_x, input_z, delta):
	if Eyes:
		Eyes.rotation.z = lerp(Eyes.rotation.z, -input_x * 0.1, 10 * delta)
	if %Models:
		%Models.rotation.z = lerp(%Models.rotation.z, -input_x * 0.05, 10 * delta)
	if Head:
		Head.rotation.x = lerp(Head.rotation.x, input_z * 0.1, 10 * delta)
