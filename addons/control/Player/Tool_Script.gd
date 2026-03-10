extends Node3D

@onready var player: CharacterBody3D = $".." # Player
@onready var Animation_Script: Node3D = $"../Animation_Handler" # Separate script (handles everything about animations)
@onready var player_value: Node3D = $"../Player_Values"

@onready var Gun_Ray: RayCast3D = $"../Head/CameraPlayer/Gun_Ray" # Ray used for the gun tool
@onready var Interact_Ray: RayCast3D = $"../Head/CameraPlayer/Interact_Ray" # ray used for the hand tool

# Bellow is everything related to the "gun" tool. Sprites and SFX
@onready var TST_M1911: Node3D = $"../Head/CameraPlayer/Player_Model/Tool Gun/TST_M1911"
@onready var m1911_anims: AnimationPlayer = $"../Head/CameraPlayer/Player_Model/Tool Gun/TST_M1911/M1911 Anims"
@onready var TST_M14: Node3D = $"../Head/CameraPlayer/Player_Model/Tool Gun/TST_M14"
@onready var m14_anims: AnimationPlayer = $"../Head/CameraPlayer/Player_Model/Tool Gun/TST_M14/M14 Anims"

@onready var gun_shoot: AudioStreamPlayer2D = $"../Player_sfx/Gun sfx/gun shoot"
@onready var gun_click: AudioStreamPlayer2D = $"../Player_sfx/Gun sfx/gun click"
@onready var gun_reload: AudioStreamPlayer2D = $"../Player_sfx/Gun sfx/gun reload"

# Bellow is everything related to the "hand" tool. Sprites
@onready var TST_Arm_R: Node3D = $"../Head/CameraPlayer/Player_Model/TST_ArmR"
@onready var TST_Arm_L: Node3D = $"../Head/CameraPlayer/Player_Model/TST_ArmL"
@onready var arm_anims_R: AnimationPlayer = $"../Head/CameraPlayer/Player_Model/TST_ArmR/Arm_Anims_R"
@onready var arm_anims_L: AnimationPlayer = $"../Head/CameraPlayer/Player_Model/TST_ArmL/Arm_Anims_L"

#@onready var TST_Sword: Node3D = $"../Head/CameraPlayer/Player_Model/TST_Sword"

# The sprites related to usable items
@onready var Usable_Item: AnimatedSprite2D = $"../Head/CanvasLayer/face/GUI/Control/Usable items/UItem"

func _process(delta: float) -> void:
	Passive_Items()
	player_value.Tool_Fatigue = clamp(player_value.Tool_Fatigue, 0, 10)
	if player_value.Tool_Fatigue <= 10:
		player_value.Tool_Fatigue += 0.03
	if player_value.Tool_Fatigue >= 10: 
		player_value.Player_State_Update("ToolR", "Idle")
		player_value.Player_State_Update("ToolL", "Idle")

var Right_Tool_Position = 0.080
var Right_Tool_Rotation = 1.2
var Left_Toll_Position = -0.075
var Left_Tool_Rotation = 1.8

var max_tools = 3 # Maximum weapons in rotation

var Max_MagA = 3 # Maximum number of magazines type A at all given times
var Max_Ammo_MagA = 8 # Maximum bullet quantity at all given times in MagA
var MagA_Num = 0 # Number of bullet in MagA
var Ammo_MagA = 3 # Current number of bullets held in MagA
var Ammo_MagA_MinR = 6 # Minimum amount of bullets to allow reloading
var MagA_ExcessR = false # false: enables reload. true: disables reload due to excess ammo

var Max_MagB = 5 # Maximum number of magazines type B at all given times
var Max_Ammo_MagB = 30 # Maximum bullet quantity at all given times in MagB
var MagB_Num = 2 # Number of bullet in MagB
var Ammo_MagB = 25 # Current number of bullets held in MagB
var Ammo_MagB_MinR = 28 # Minimum amount of bullets to allow reloading
var MagB_ExcessR = false # false: enables reload. true: disables reload due to excess ammo

var TSR_Held = false

var Can_use_Range = true # Enables use of gun
var Can_use_Range_Handgun_alt = true # enables alternatie use of gun 
var Can_use_Range_Assalt_alt = true

var Can_use_Close = true # Enables use of hand
var Can_use_Close_alt = true # enables alternatie use of hand 

func Use_Tool_Primary():
	if player_value.Alive == true:
		#Use tool
		#Keyboard
		if player.Key_C:
			if Input.is_action_just_pressed("In_Mouse_R"):
				Tool_HandlingR()
				player_value.Tool_Get_ID()
			if Input.is_action_just_pressed("In_Mouse_L"):
				Tool_HandlingL()
				player_value.Tool_Get_ID()

		#Joypad
		if player.Joy_C:
			if Input.is_action_just_pressed("In_Joy_R2"):
				Tool_HandlingR()
			if Input.is_action_just_pressed("In_Joy_L2"):
				Tool_HandlingL()

		#false:
		#pass

#func Use_Tool_Secondary():
	#if player_value.Alive == true:
		##Joypad
		#if player.Joy_C:
			#if Input.is_action_just_pressed("In_Joy_R1"):
				#TSR_Held = true
				#Tool_Secondary_R()
			#else:
				#TSR_Held = false
				#Tool_Secondary_R()
			#if Input.is_action_just_pressed("In_Joy_L1"):
				#Tool_Secondary_L()

func Use_Tool_Alternatuve():
	if player_value.Alive == true:
		# Tool alternative use
		if player.Key_C:
			if Input.is_action_just_pressed("In_Key_Tool_Alt"):
				pass
		if player.Joy_C:
			if Input.is_action_pressed("In_joy_Tool_Alt"):
				pass

		if Ammo_MagA > Max_Ammo_MagA:
			Ammo_MagA = Max_Ammo_MagA
		
	MagA_ExcessR = false
	MagB_ExcessR = false
	if Ammo_MagA <= Ammo_MagA_MinR:
		MagA_ExcessR = true
	if Ammo_MagB <= Ammo_MagB_MinR:
		MagB_ExcessR = true
		
	if MagA_Num <= 0:
		Can_use_Range_Handgun_alt = false
	elif MagA_Num > 0:
		Can_use_Range_Handgun_alt = true
	
	if MagB_Num <= 0:
		Can_use_Range_Assalt_alt = false
	elif MagB_Num > 0:
		Can_use_Range_Assalt_alt = true

func Use_UItem():
	if player.Key_C == true:
		if Input.is_action_just_pressed("In_Key_Use_Item"):
			UItem()
	elif player.Joy_C == true:
		if Input.is_action_just_pressed("In_Joy_Use_Item"):
			UItem()

func Passive_Items():
	if player_value.Inv_Brace_Equiped == "Golden Bra.":
		player_value.Health_Bonus = 20
	elif player_value.Inv_Brace_Equiped != "Golden Bra.":
		player_value.Health_Bonus = 0
	if player_value.Inv_Brace_Equiped == "Clorophyl Bra.":
		player_value.Reg_Rate = 10
	elif player_value.Inv_Brace_Equiped != "Clorophyl Bra.":
		player_value.Reg_Rate = player_value.Dummy_Reg_Rate
	if player_value.Inv_Brace_Equiped == "Power Bra.":
		player_value.Damage_Bonus = 5
	elif player_value.Inv_Brace_Equiped != "Power Bra.":
		player_value.Damage_Bonus = 0

func Alternative_Timer(Action_Released, Press_Function, Hold_Function, delta: float) -> void:
	player_value.inter_button_tapped = true
	player_value.inter_button_held = true
	
	if player_value.inter_button_tapped:
		player_value.inter_press_time += delta
		
		if Input.is_action_just_released(Action_Released):
			if !player_value.inter_button_held:
				Hold_Function
				player_value.inter_button_tapped = false
				player_value.inter_press_time = 0.0
			
		if player_value.inter_press_time >= player_value.inter_hold_treshold and !player_value.inter_button_held:
			player_value.inter_button_held = false
			Press_Function
			player_value.inter_press_time = 0.0
	


func Tool_HandlingR():
	Can_use_Range = true
	match player_value.Inv_ToolR_Equiped:
		"null":
			pass
		"Hand gun":
			if Can_use_Range == true and Ammo_MagA > 0 and Animation_Script.Current_Anim_Playing == false and player_value.Anim_HM_Done1 == true:
				Animation_Script.Current_Anim_Playing = true
				gun_shoot.play()
				m1911_anims.play("TST_M1911_Shoot")
				player_value.Player_State_Update("ToolR", "M1911 Shot")
				if Gun_Ray.is_colliding() and Gun_Ray.get_collider().has_method("damage"):
						Gun_Ray.get_collider().damage()
				Ammo_MagA = Ammo_MagA - 1 # Deduces the number of bullets in magazine
				if Ammo_MagA <= 0: # If 0 bullets in magazine, no longer shoots
					Can_use_Range = false
			elif Ammo_MagA <= 0:
				gun_click.play()
		"Assalt rifle":
			if Can_use_Range == true and Ammo_MagB > 0 and Animation_Script.Current_Anim_Playing == false and player_value.Anim_HM_Done2 == true:
				player_value.Player_State_Update("ToolDir", "Right")
				Animation_Script.Current_Anim_Playing = true
				gun_shoot.play()
				m14_anims.play("TST_M14_Shoot")
				player_value.Player_State_Update("ToolR", "M14 Shot")
				if Gun_Ray.is_colliding() and Gun_Ray.get_collider().has_method("damage"):
						Gun_Ray.get_collider().damage()
				Ammo_MagB = Ammo_MagB - 1 # Deduces the number of bullets in magazine
				if Ammo_MagB <= 0: # If 0 bullets in magazine, no longer shoots
					Can_use_Range = false
			elif Ammo_MagB <= 0:
				gun_click.play()
		
		"Sword":
			player_value.Player_State_Update("ToolR", "Sword Swung")
			if Interact_Ray.is_colliding() and Interact_Ray.get_collider().has_method("damage"): # Check is ray is coliding, and if so, get #damage method
				Interact_Ray.get_collider().damage() # Gets "damage method and executes it"
func Tool_HandlingL():
	Can_use_Range = true
	match player_value.Inv_ToolL_Equiped:
		"null":
			pass
		"Hand gun":
			if Can_use_Range == true and Ammo_MagA > 0 and Animation_Script.Current_Anim_Playing == false and player_value.Anim_HM_Done1 == true:
				player_value.Tool_Direction_Use = "Left"
				Animation_Script.Current_Anim_Playing = true
				gun_shoot.play()
				m1911_anims.play("TST_M1911_Shoot")
				player_value.Player_State_Update("ToolL", "M1911 Shot")
				if Gun_Ray.is_colliding() and Gun_Ray.get_collider().has_method("damage"):
						Gun_Ray.get_collider().damage()
				Ammo_MagA = Ammo_MagA - 1 # Deduces the number of bullets in magazine
				if Ammo_MagA <= 0: # If 0 bullets in magazine, no longer shoots
					Can_use_Range = false
			elif Ammo_MagA <= 0:
				gun_click.play()
		"Assalt rifle":
			if Can_use_Range == true and Ammo_MagB > 0 and Animation_Script.Current_Anim_Playing == false and player_value.Anim_HM_Done2 == true:
				Animation_Script.Current_Anim_Playing = true
				gun_shoot.play()
				m14_anims.play("TST_M14_Shoot")
				player_value.Player_State_Update("ToolL", "M14 Shot")
				if Gun_Ray.is_colliding() and Gun_Ray.get_collider().has_method("damage"):
						Gun_Ray.get_collider().damage()
				Ammo_MagB = Ammo_MagB - 1 # Deduces the number of bullets in magazine
				if Ammo_MagB <= 0: # If 0 bullets in magazine, no longer shoots
					Can_use_Range = false
			elif Ammo_MagB <= 0:
				gun_click.play()
		
		"Sword":
			player_value.Player_State_Update("ToolL", "Sword Swung")
			if Interact_Ray.is_colliding() and Interact_Ray.get_collider().has_method("damage"): # Check is ray is coliding, and if so, get #damage method
				Interact_Ray.get_collider().damage() # Gets "damage method and executes it"

#func Tool_Secondary_R():
	#match player_value.Inv_ToolR_Equiped:
		#"Assalt rifle":
			##TST_M14.rotation.y = Right_Tool_Rotation + 0.35
			#m14_anims.play("TST_M14_ADS_R")
	##else:
		###pass
		##m14_anims.play_backwards("TST_M14_ADS_R")
		###TST_M14.rotation.y = 0
#func Tool_Secondary_L():
	#match player_value.Inv_ToolL_Equiped:
		#pass

func Tool_Rotate():
	TST_Arm_R.visible = false
	TST_Arm_L.visible = false
	
	TST_M1911.visible = false
	TST_M14.visible = false
	
	if player_value.Alive == true and player_value.Undeath == false:
		if player_value.Inv_ToolR_Equiped == "null": # RIGHT TOOL
			TST_Arm_R.visible = true
			if Animation_Script.Current_Anim_Playing == false:
				TST_Arm_R.visible = true
				Can_use_Close = true
		
		if player_value.Inv_ToolL_Equiped == "null": # LEFT TOOL
			TST_Arm_L.visible = true
			if Animation_Script.Current_Anim_Playing == false:
				TST_Arm_L.visible = true
				Can_use_Close = true
		
		
		if player_value.Inv_ToolR_Equiped == "Hand gun" and player_value.Anim_HM_Done1 == false: # RIGHT TOOL TRANS. ANIMATION
			TST_M1911.position.x = Right_Tool_Position
			TST_M1911.rotation.y = Right_Tool_Rotation
			TST_M1911.visible = true
			m1911_anims.play("TST_M1911_Pop_up")
		elif player_value.Inv_ToolR_Equiped == "Hand gun": # RIGHT TOOL
			TST_M1911.position.x = Right_Tool_Position
			TST_M1911.rotation.y = Right_Tool_Rotation
			TST_M1911.visible = true
		
		if player_value.Inv_ToolL_Equiped == "Hand gun" and player_value.Anim_HM_Done1 == false: # LEFT TOOL TRANS. ANIMATION
			TST_M1911.visible = true
			TST_M1911.position.x = Left_Toll_Position
			TST_M1911.rotation.y = Left_Tool_Rotation
			m1911_anims.play("TST_M1911_Pop_up")
		elif player_value.Inv_ToolL_Equiped == "Hand gun": # LRFT TOOL
			TST_M1911.position.x = Left_Toll_Position
			TST_M1911.rotation.y = Left_Tool_Rotation
			TST_M1911.visible = true
		
		
		if player_value.Inv_ToolR_Equiped == "Assalt rifle" and player_value.Anim_HM_Done2 == false: # RIGHT TOOL TRANS. ANIMATION
			TST_M14.visible = true
			TST_M14.position.x = Right_Tool_Position
			TST_M14.rotation.y = Right_Tool_Rotation
			m14_anims.play("TST_M14_Pop_up")
		elif player_value.Inv_ToolR_Equiped == "Assalt rifle": # RIGHT TOOL
			TST_M14.visible = true
			TST_M14.position.x = Right_Tool_Position
			TST_M14.rotation.y = Right_Tool_Rotation
		
		if player_value.Inv_ToolL_Equiped == "Assalt rifle" and player_value.Anim_HM_Done2 == false: # RIGHT TOOL TRANS. ANIMATION
			TST_M14.visible = true
			TST_M14.position.x = Left_Toll_Position
			TST_M14.rotation.y = Left_Tool_Rotation
			m14_anims.play("TST_M14_Pop_up")
		elif player_value.Inv_ToolL_Equiped == "Assalt rifle": # RIGHT TOOL
			TST_M14.visible = true
			TST_M14.position.x = Left_Toll_Position
			TST_M14.rotation.y = Left_Tool_Rotation
		
		
		#if player_value.Inv_ToolR_Equiped == "Sword" and player_value.Anim_HM_Done2 == false: # RIGHT TOOL TRANS. ANIMATION
			#pass
		elif player_value.Inv_ToolR_Equiped == "Sword": # RIGHT TOOL
			if Animation_Script.Current_Anim_Playing == false:
				pass
				#TST_Sword.visible = true
				#TST_Sword.position.x = Right_Tool_Position
				#TST_Sword.rotation.y = Right_Tool_Rotation
		
		if player_value.Inv_ToolL_Equiped == "Sword" and player_value.Anim_HM_Done2 == false: # LEFT TOOL TRANS. ANIMATION
			pass
		elif player_value.Inv_ToolL_Equiped == "Sword": # LEFT TOOL
			if Animation_Script.Current_Anim_Playing == false:
				pass

		else:
			pass

func Tool_AltR():	
	match player_value.Inv_ToolR_Equiped:
		"null":
			if Can_use_Close == true and player_value.Stamina >= player_value.Stamina_Act1_Tax and Animation_Script.Current_Anim_Playing == false:
				Animation_Script.Current_Anim_Playing = true
				arm_anims_R.play("TST_Arms_Interact") # Play animation
				player_value.Player_State_Update("ToolR", "Hand Interact")
				Tool_Gen_Interaction()
				player_value.Stats_decrease("Stamina", 3)
		"Hand gun":
			if Can_use_Range_Handgun_alt == true and Animation_Script.Current_Anim_Playing == false and MagA_ExcessR == true:
				Animation_Script.Current_Anim_Playing = true
				m1911_anims.play("TST_M1911_Reload_R")
				player_value.Player_State_Update("ToolR", "M1911 reload")
				gun_reload.play()
				if m1911_anims.current_animation == "TST_M1911_Reload_R":
					Ammo_MagA = Max_Ammo_MagA # Deduces the number of bullets in magazine
					MagA_Num -= 1
		"Assalt rifle":
			if Can_use_Range_Assalt_alt == true and Animation_Script.Current_Anim_Playing == false and MagB_ExcessR == true:
				Animation_Script.Current_Anim_Playing = true
				m14_anims.play("TST_M14_Reload_R")
				player_value.Player_State_Update("ToolR", "M14 Reload")
				gun_reload.play()
				if m14_anims.current_animation == "TST_M14_Reload_R":
					Ammo_MagB = Max_Ammo_MagB # Deduces the number of bullets in magazine
					MagB_Num -= 1
func Tool_AltL():
	if Interact_Ray.is_colliding() and Interact_Ray.get_collider().has_method("interact"):
		if Can_use_Close == true and player_value.Stamina >= player_value.Stamina_Act1_Tax and Animation_Script.Current_Anim_Playing == false:
				Animation_Script.Current_Anim_Playing = true
				arm_anims_L.play("TST_Arms_Interact") # Play animation
				player_value.Player_State_Update("ToolL", "Hand Interact")
				Tool_Gen_Interaction()
				player_value.Stats_decrease("Stamina", 3)
	else:
		match player_value.Inv_ToolL_Equiped:
			"Hand gun":
				if Can_use_Range_Handgun_alt == true and Animation_Script.Current_Anim_Playing == false and MagA_ExcessR == true:
					Animation_Script.Current_Anim_Playing = true
					m1911_anims.play("TST_M1911_Reload_L")
					player_value.Player_State_Update("ToolL", "M1911 Reload")
					gun_reload.play()
					if m1911_anims.current_animation == "TST_M1911_Reload_L":
						Ammo_MagA = Max_Ammo_MagA # Deduces the number of bullets in magazine
						MagA_Num -= 1
			"Assalt rifle":
				if Can_use_Range_Assalt_alt == true and Animation_Script.Current_Anim_Playing == false and MagB_ExcessR == true:
					Animation_Script.Current_Anim_Playing = true
					m14_anims.play("TST_M14_Reload_L")
					player_value.Player_State_Update("ToolL", "M14 Reload")
					gun_reload.play()
					if m14_anims.current_animation == "TST_M14_Reload_L":
						Ammo_MagB = Max_Ammo_MagB # Deduces the number of bullets in magazine
						MagB_Num -= 1

func UItem():
	match player_value.Usable_Item_Selected:
		1:
			if player_value.UItem_Get_ID()["quantity"] > 0 and player_value.Health < player_value.Health_Max:
				var amount = player_value.UItem_Get_ID()["heal_value"]
				player_value.Heal("Partial", amount)
				player_value.UItem_Get_ID()["quantity"] -= 1
				$"../Player_sfx/General sfx/heal".play()
		2:
			if player_value.UItem_Get_ID()["quantity"] > 0 and player_value.Health < player_value.Health_Max:
				var amount = player_value.UItem_Get_ID()["heal_value"]
				player_value.Heal("Partial", amount)
				player_value.UItem_Get_ID()["quantity"] -= 1
				$"../Player_sfx/General sfx/heal".play()

func UItem_Rotate():
	if player_value.Usable_Item_Selected == 0 or player_value.Alive == false or player_value.Undeath == true:
		Usable_Item.visible = false
	else:
		Usable_Item.visible = true
	
	match player_value.Usable_Item_Selected:
		1:
			Usable_Item.play("Glass flask")
		2:
			Usable_Item.play("Wild Gold Petal")
	
	# Item Rotation
	# Keyboard
	if player.Key_C and player_value.Menu_mode == false:
		if Input.is_action_just_pressed("In_Key_Rot_Down"): # Rotates "Usable Item selection" index
			player_value.Usable_Item_Selected += 1
	# Joypad
	if player.Joy_C  and player_value.Menu_mode == false:
		if Input.is_action_just_released("In_Joy_Rot_Down"):
			player_value.Usable_Item_Selected += 1
	
	player_value.Usable_Item_Selected = wrapi(player_value.Usable_Item_Selected, 1, player_value.UItem_Max)

func Tool_Gen_Interaction():
	if not Interact_Ray.is_colliding():
		return
	var target = Interact_Ray.get_collider()
	if target.has_method("interact"):
		var hit_pos = Interact_Ray.get_collision_point()
		var dir = Interact_Ray.global_transform.basis.z.normalized()
		target.interact(hit_pos, dir)
