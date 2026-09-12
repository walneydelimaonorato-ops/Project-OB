extends CharacterBody3D

var togg: bool = false

var Free_Cam_Speed: float = 4.0
var Free_Cam_Rise: float = 4.0

func _input(input: InputEvent) -> void:
	if input is InputEventMouseMotion and %"Free Cam Backdrop".visible == true:
		%"Free Cam Body".rotation.y -= input.relative.x * 0.003
		%"Free Cam".rotation.x -= input.relative.y * 0.003
		%"Free Cam".rotation.x = clamp(%"Free Cam".rotation.x, deg_to_rad(-85), deg_to_rad(85))
	
	if Input.is_action_just_pressed("In_Tool_Alt"):
		velocity.y = Free_Cam_Rise
	elif Input.is_action_just_released("In_Tool_Alt"):
		velocity.y = 0
	if Input.is_action_just_pressed("In_Use_Item"):
		velocity.y = -Free_Cam_Rise
	elif Input.is_action_just_released("In_Use_Item"):
		velocity.y = 0
	
	if Input.is_action_just_pressed("In_Sprint"):
		
		togg = !togg
		if togg == true:
			Free_Cam_Speed = 20.0
			Free_Cam_Rise = 12.0
		elif togg == false:
			Free_Cam_Speed = 4.0
			Free_Cam_Rise = 4.0

func _physics_process(delta: float) -> void:
	if %"Free Cam Backdrop".visible == true:
		var input_dir = Input.get_vector("In_Left", "In_Right", "In_Forward", "In_Backward")
		var direction = (%"Free Cam Body".transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * Free_Cam_Speed
			velocity.z = direction.z * Free_Cam_Speed
		else:
			velocity.x = 0
			velocity.z = 0
	
	move_and_slide()
