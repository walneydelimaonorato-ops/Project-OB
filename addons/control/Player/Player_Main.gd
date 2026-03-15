extends CharacterBody3D

var Roting = 0

# Important references
@onready var Tool_Script = $Tool_Node # Separate script (handles everything about tools)
@onready var Animation_Script: Node3D = $Animation_Handler # Separate script (handles everything about animations)
#@onready var PlayerValue: Node3D = $PlayerValues

@onready var head: Node3D = $Head # Head of the player
@onready var camera_player: Camera3D = $Head/CameraPlayer # Camera of the player
@onready var Player_Collision: CollisionShape3D = $"Player Collision" # Collision of the player

var Dummy_Speed = 4.0 # Fallback speed value
var Key_Camera_Sens = 0.003 # Keyboard camera sensistivity
var Joy_Camera_Sens = 0.075 # Joypads camera sensistivity

@export_group("variables")
@export var Base_Speed = 4 # Speed used to move
@export var Run = 6.0 # Speed used when running
@export var Jump_Height = 4.5 # Jump velocity aplied
@export var Joy_C : bool = false # Joypad enabler/disabler
@export var Key_C : bool = false # Keyboard enabler/disabler

func _ready():
	Tool_Script.Tool_Rotate()
	global.Gplayer = self
	if global.Control_Type == true:
		Joy_C = true
	elif global.Control_Type == false:
		Key_C = true
	
	PlayerValue.Reg_Timer_Startup()
	PlayerValue.Reg_Delay_Timer.timeout.connect(PlayerValue._start_Reg)

func _physics_process(delta: float) -> void:
	if PlayerValue.Alive == true:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta
			PlayerValue.Player_State_Update("SPC", "Airborne")
		else:
			PlayerValue.Player_State_Update("SPC", "Grounded")
		
		# Jump
		if PlayerValue.Stamina >= PlayerValue.Stamina_Jump_Tax:
			# Keyboard
			if Key_C and PlayerValue.Menu_mode == false:
				if Input.is_action_just_pressed("In_Jump") and is_on_floor():
					velocity.y = Jump_Height # Burst of Y velocity is temporarily applied to character
					PlayerValue.Player_State_Update("MVM", "Jumped")
					PlayerValue.Stats_decrease("Stamina", 10)
			# Joypad
			if Joy_C and PlayerValue.Menu_mode == false:
				if Input.is_action_just_pressed("In_Joy_Jump")  and is_on_floor():
					velocity.y = Jump_Height
					PlayerValue.Player_State_Update("MVM", "Jumped")
					PlayerValue.Stats_decrease("Stamina", 10)
		
		# Sprinting
		var Sprinting = false
		# Keyboard
		if Key_C:
			if Input.is_action_pressed("In_Sprint") and PlayerValue.Stamina > 0:
				Base_Speed = Run # Current speed becomes running speed
				Sprinting = true
				#PlayerValue.Stats_decrease("Stamina", 0.1)
			else: #Input.is_action_just_released("In_Sprint"):
				Base_Speed = Dummy_Speed # Current speed falls back to a set value
				Sprinting = false
		# Joycon
		if Joy_C:
			if Input.is_action_pressed("In_Joy_Sprint") and PlayerValue.Stamina > 0:
				Base_Speed = Run
				Sprinting = true
				#PlayerValue.Stats_decrease("Stamina", 0.1)
			else: # Input.is_action_just_released("In_Joy_Sprint"):
				Base_Speed = Dummy_Speed
				Sprinting = false
		
		# Movement
		# Keyboard
		if Key_C:
			var input_dir := Input.get_vector("In_Left", "In_Right", "In_Up", "In_Down")
			var direction := (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		
			if direction:
				velocity.x = direction.x * Base_Speed
				velocity.z = direction.z * Base_Speed
				PlayerValue.Player_State_Update("MVM", "Moved")
				if Sprinting == true:
					PlayerValue.Stats_decrease("Stamina", 0.1)
			
			else:
				velocity.x = lerp(velocity.x, 0.0, 0.15)
				velocity.z = lerp(velocity.z, 0.0, 0.15)
				PlayerValue.Player_State_Update("MVM", "Idle")
		
		# Joypad
		if Joy_C:
			var input_dir := Input.get_vector("In_JoyL_Left", "In_JoyL_Right", "In_JoyL_Up", "In_JoyL_Down") # walk_r, walk_l, walk_u, walk_d
			var direction := (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		
			if direction:
				velocity.x = direction.x * Base_Speed
				velocity.z = direction.z * Base_Speed
				PlayerValue.Player_State_Update("MVM", "Moved")
			
			else:
				velocity.x = 0 #move_toward(velocity.x, 0, Base_Speed)
				velocity.z = 0 #move_toward(velocity.z, 0, Base_Speed)
				PlayerValue.Player_State_Update("MVM", "Idle")
		
		move_and_slide()

func _process(delta: float) -> void:
	PlayerValue.Reg_Process(delta)
	if PlayerValue.Menu_mode == false: #and PlayerValue.Menu_mode == false:
		if Key_C:
			if Input.is_action_just_pressed("In_Key_Tool_Alt"):
				#Tool_Script.Alternative_Timer("In_Key_Tool_Alt", Tool_Script.Tool_AltR(), Tool_Script.Tool_AltL(), delta)
				PlayerValue.inter_button_tapped = true
				PlayerValue.inter_button_held = false
				PlayerValue.inter_press_time = 0.0
				
			if PlayerValue.inter_button_tapped:
				PlayerValue.inter_press_time += delta
				if PlayerValue.inter_press_time >= PlayerValue.inter_hold_treshold and !PlayerValue.inter_button_held:
					PlayerValue.inter_button_held = true
					Tool_Script.Tool_AltL()
				
				if Input.is_action_just_released("In_Key_Tool_Alt"):
					if !PlayerValue.inter_button_held:
						Tool_Script.Tool_AltR()
						PlayerValue.inter_button_tapped = false
		if Joy_C:
			if Input.is_action_just_pressed("In_joy_Tool_Alt"):
				PlayerValue.inter_button_tapped = true
				PlayerValue.inter_button_held = false
				PlayerValue.inter_press_time = 0.0
				
			if PlayerValue.inter_button_tapped:
				PlayerValue.inter_press_time += delta
				if PlayerValue.inter_press_time >= PlayerValue.inter_hold_treshold and !PlayerValue.inter_button_held:
					PlayerValue.inter_button_held = true
					Tool_Script.Tool_AltL()
	
				if Input.is_action_just_released("In_joy_Tool_Alt"):
					if !PlayerValue.inter_button_held:
						Tool_Script.Tool_AltR()
						PlayerValue.inter_button_tapped = false
		
		Tool_Script.Use_UItem()

		Tool_Script.UItem_Rotate()
	if PlayerValue.Alive == true:
		# Camera
		# Joypad
		if Joy_C:
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
	if event.is_action_pressed("InD_Heal"):
		Roting -= 0.01
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
	# Camera
	# Keyboard
	if Key_C:
		if event is InputEventMouseMotion:
			head.rotation.y -= event.relative.x * Key_Camera_Sens
			camera_player.rotation.x -= event.relative.y * Key_Camera_Sens
			camera_player.rotation.x = clamp(camera_player.rotation.x, deg_to_rad(-85), deg_to_rad(85))
	
	if PlayerValue.Alive == true and PlayerValue.Menu_mode == false:
		Tool_Script.Use_Tool_Primary() # Called when a Tool is used (primary)
		#Tool_Script.Use_Tool_Secondary()
		Tool_Script.Use_Tool_Alternatuve() # Called when a Tool's alternative is used 
		#PlayerValue.ToolLGet_ID()
