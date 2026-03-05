extends CharacterBody3D


# Important references
@onready var Tool_Script = $Tool_Node # Separate script (handles everything about tools)
@onready var Animation_Script: Node3D = $Animation_Handler # Separate script (handles everything about animations)
@onready var player_value: Node3D = $Player_Values

@onready var head: Node3D = $Head # Head of the player
@onready var camera_player: Camera3D = $Head/CameraPlayer # Camera of the player
@onready var Player_Collision: CollisionShape3D = $"Player Collision" # Collision of the player

var Dummy_Speed = 4.0 # Fallback speed value
var Key_Camera_Sens = 0.003 # Keyboard camera sensistivity
var Joy_Camera_Sens = 0.075 # Joypads camera sensistivity

@export_group("variables")
@export var Base_Speed = 4.0 # Speed used to move
@export var Run = 6.0 # Speed used when running
@export var Jump_Height = 4.5 # Jump velocity aplied
@export var Joy_C : bool = false # Joypad enabler/disabler
@export var Key_C : bool = false # Keyboard enabler/disabler

func _ready():
	global.Gplayer = self
	if global.Control_Type == true:
		Joy_C = true
	elif global.Control_Type == false:
		Key_C = true
	
	player_value.Reg_Timer_Startup()
	player_value.Reg_Delay_Timer.timeout.connect(player_value._start_Reg)

func _physics_process(delta: float) -> void:
	if player_value.Alive == true:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta
			player_value.Player_State_Update("SPC", "Airborne")
		else:
			player_value.Player_State_Update("SPC", "Grounded")
		
		# Jump
		if player_value.Stamina >= player_value.Stamina_Jump_Tax:
			# Keyboard
			if Key_C and player_value.Menu_mode == false:
				if Input.is_action_just_pressed("In_Jump") and is_on_floor():
					velocity.y = Jump_Height # Burst of Y velocity is temporarily applied to character
					player_value.Player_State_Update("MVM", "Jumped")
					player_value.Stats_decrease("Stamina", 10)
			# Joypad
			if Joy_C and player_value.Menu_mode == false:
				if Input.is_action_just_pressed("In_Joy_Jump")  and is_on_floor():
					velocity.y = Jump_Height
					player_value.Player_State_Update("MVM", "Jumped")
					player_value.Stats_decrease("Stamina", 10)
		
		# Sprinting
		# Keyboard
		if Key_C:
			if Input.is_action_pressed("In_Sprint") and player_value.Stamina > 0:
				Base_Speed = Run # Current speed becomes running speed
				player_value.Stats_decrease("Stamina", 0.1)
			else: #Input.is_action_just_released("In_Sprint"):
				Base_Speed = Dummy_Speed # Current speed falls back to a set value
		# Joycon
		if Joy_C:
			if Input.is_action_pressed("In_Joy_Sprint") and player_value.Stamina > 0:
				Base_Speed = Run
				player_value.Stats_decrease("Stamina", 0.1)
			else: # Input.is_action_just_released("In_Joy_Sprint"):
				Base_Speed = Dummy_Speed
		
		# Movement
		# Keyboard
		if Key_C:
			var input_dir := Input.get_vector("In_Left", "In_Right", "In_Up", "In_Down")
			var direction := (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		
			if direction:
				velocity.x = direction.x * Base_Speed
				velocity.z = direction.z * Base_Speed
				player_value.Player_State_Update("MVM", "Moved")
			
			else:
				velocity.x = move_toward(velocity.x, 0, Base_Speed)
				velocity.z = move_toward(velocity.z, 0, Base_Speed)
				player_value.Player_State_Update("MVM", "Idle")
		
		# Joypad
		if Joy_C:
			var input_dir := Input.get_vector("In_JoyL_Left", "In_JoyL_Right", "In_JoyL_Up", "In_JoyL_Down") # walk_r, walk_l, walk_u, walk_d
			var direction := (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		
			if direction:
				velocity.x = direction.x * Base_Speed
				velocity.z = direction.z * Base_Speed
				player_value.Player_State_Update("MVM", "Moved")
			
			else:
				velocity.x = 0 #move_toward(velocity.x, 0, Base_Speed)
				velocity.z = 0 #move_toward(velocity.z, 0, Base_Speed)
				player_value.Player_State_Update("MVM", "Idle")
		
		move_and_slide()

func _process(delta: float) -> void:
	player_value.Reg_Process(delta)
	if player_value.Alive == true and player_value.Menu_mode == false:
		Tool_Script.Use_UItem()
		Tool_Script.Tool_Rotate() # Callsed when switching Tools
		Tool_Script.UItem_Rotate()
		# Camera
		# Joypad
		if Joy_C: # OPTIMIZE SOMEDAY LMAO
			var look_r = Input.get_action_strength("In_JoyR_Right")
			var look_l = Input.get_action_strength("In_JoyR_Left")
			var look_u = Input.get_action_strength("In_JoyR_Up")
			var look_d = Input.get_action_strength("In_JoyR_Down")
			var total_look_horizontal = look_r + look_l
			var total_look_vertical = look_u + look_d
			if Input.is_action_pressed("In_JoyR_Right"):
				head.rotation.y -= total_look_horizontal * Joy_Camera_Sens
			if Input.is_action_pressed("In_JoyR_Left"):
				head.rotation.y += total_look_horizontal * Joy_Camera_Sens
			if Input.is_action_pressed("In_JoyR_Up"):
				camera_player.rotation.x += total_look_vertical * Joy_Camera_Sens
			if Input.is_action_pressed("In_JoyR_Down"):
				camera_player.rotation.x -= total_look_vertical * Joy_Camera_Sens
			camera_player.rotation.x = clamp(camera_player.rotation.x, deg_to_rad(-85), deg_to_rad(85))

func _input(event):
	# Exit
	#Keyboard
	if event.is_action_pressed("In_Pause"): # Exit game window
		$"Head/CanvasLayer/face/GUI/Control/Menus/Ready Menu".Pause()
	#Joypad
	if event.is_action_pressed("In_Joy_Pause"):
		$"Head/CanvasLayer/face/GUI/Control/Menus/Ready Menu".Pause()
	# Reload map
	# Keyboard
	if event.is_action_pressed("In_Restart"): # Reload current scene
		get_tree().reload_current_scene()
	# Force quit
	if event.is_action_pressed("InD_Force_Quit"):
		get_tree().quit()
	
	if player_value.Alive == true and player_value.Menu_mode == false:
		Tool_Script.Use_Tool_Primary() # Called when a Tool is used (primary)
		Tool_Script.Use_Tool_Alternatuve() # Called when a Tool's alternative is used 
		player_value.ToolR_Get_ID()
		player_value.ToolLGet_ID()
		# Camera
		# Keyboard
		if Key_C:
			if event is InputEventMouseMotion:
				head.rotation.y -= event.relative.x * Key_Camera_Sens
				camera_player.rotation.x -= event.relative.y * Key_Camera_Sens
				camera_player.rotation.x = clamp(camera_player.rotation.x, deg_to_rad(-85), deg_to_rad(85))
