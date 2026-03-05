extends Node3D

@onready var player: CharacterBody3D = $".." # Player
@onready var Animation_Script: Node3D = $"../Animation_Handler" # Separate script (handles everything about animations)
@onready var player_value: Node3D = $"../Player_Values"

@onready var Gun_Ray: RayCast3D = $"../Head/CameraPlayer/Gun_Ray" # Ray used for the gun tool
@onready var Point_Ray: RayCast3D = $"../Head/CameraPlayer/Point_Ray" # ray used for the hand tool

# Bellow is everything related to the "gun" tool. Sprites and SFX
@onready var Holding_GunR: AnimatedSprite2D = $"../Head/CanvasLayer/face/GUI/Control/Tools/gunR"
@onready var Holding_GunL: AnimatedSprite2D = $"../Head/CanvasLayer/face//GUI/Control/Tools/gunL"
@onready var gun_shoot: AudioStreamPlayer2D = $"../Player_sfx/Gun sfx/gun shoot"
@onready var gun_click: AudioStreamPlayer2D = $"../Player_sfx/Gun sfx/gun click"
@onready var gun_reload: AudioStreamPlayer2D = $"../Player_sfx/Gun sfx/gun reload"
# Bellow is everything related to the "hand" tool. Sprites
@onready var Holding_HandR: AnimatedSprite2D = $"../Head/CanvasLayer/face//GUI/Control/Tools/pointR"
@onready var Holding_HandL: AnimatedSprite2D = $"../Head/CanvasLayer/face//GUI/Control/Tools/pointL"
# Bellow is everything related to the "melee" tool. Sprites
@onready var Holding_MeleeR: AnimatedSprite2D = $"../Head/CanvasLayer/face//GUI/Control/Tools/swordR"
@onready var Holding_MeleeL: AnimatedSprite2D = $"../Head/CanvasLayer/face//GUI/Control/Tools/swordL"
# "Miscellaneous" relates to a transition animation
@onready var Hand_MiscellaneousR: AnimatedSprite2D = $"../Head/CanvasLayer/face//GUI/Control/Tools/hand miscR"
@onready var Hand_MiscellaneousL: AnimatedSprite2D = $"../Head/CanvasLayer/face//GUI/Control/Tools/hand miscL"
# The sprites related to usable items
@onready var Usable_Item: AnimatedSprite2D = $"../Head/CanvasLayer/face/GUI/Control/Usable items/UItem"

var max_tools = 3 # Maximum weapons in rotation

var Max_MagA = 3 # Maximum number of magazines type A at all given times
var Max_Ammo_MagA = 8 # Maximum bullet quantity at all given times in MagA
var MagA_Num = 0 # Number of bullet in MagA
var Ammo_MagA = 3 # Current number of bullets held in MagA
var Ammo_MagA_MinR = 6 # Minimum amount of bullets to allow reloading
var MagA_ExcessR = false # false: enables reload. true: disables reload due to excess ammo

var Can_use_Range = true # Enables use of gun
var Can_use_Range_alt = true # enables alternatie use of gun 

var Can_use_Close = true # Enables use of hand
var Can_use_Close_alt = true # enables alternatie use of hand 

func Use_Tool_Primary():
	if player_value.Alive == true:
		#Use tool
		#Keyboard
		if player.Key_C:
			if Input.is_action_just_pressed("In_Mouse_R"):
				Tool_HandlingR()
			if Input.is_action_just_pressed("In_Mouse_L"):
				Tool_HandlingL()
		#Joypad
		if player.Joy_C:
			if Input.is_action_just_pressed("In_Joy_R2"):
				Tool_HandlingR()
			if Input.is_action_just_pressed("In_Joy_L2"):
				Tool_HandlingL()
		#false:
		#pass

func Use_Tool_Secondary():
	if player_value.Alive == true:
		pass

func Use_Tool_Alternatuve():
	if player_value.Alive == true:
		# Tool alternative use
		if player.Key_C:
			if Input.is_action_just_pressed("In_Key_Tool_Alt"):
				Tool_AltR()
				Tool_AltL()
		if player.Joy_C:
			if Input.is_action_just_pressed("In_joy_Tool_Alt"):
				Tool_AltR()
				Tool_AltL()
		if Ammo_MagA > Max_Ammo_MagA:
			Ammo_MagA = Max_Ammo_MagA
		
	MagA_ExcessR = false
	if Ammo_MagA <= Ammo_MagA_MinR:
		MagA_ExcessR = true
		
	if MagA_Num == 0:
		Can_use_Range_alt = false
	elif MagA_Num > 0:
		Can_use_Range_alt = true

func Use_UItem():
	if player.Key_C == true:
		if Input.is_action_just_pressed("In_Key_Use_Item"):
			UItem()
	elif player.Joy_C == true:
		if Input.is_action_just_pressed("In_Joy_Use_Item"):
			UItem()

func Tool_HandlingR():
	Can_use_Range = true
	match player_value.R_Hand_In_Use:
		0:
			if Can_use_Close == true and player_value.Stamina >= player_value.Stamina_Act1_Tax and Animation_Script.Current_Anim_Playing == false:
				Animation_Script.Current_Anim_Playing = true
				Holding_HandR.play("hand_pointing") # Play animation
				Tool_Gen_Interaction()
				player_value.Stats_decrease("Stamina", 3)
		1:
			if Can_use_Range == true and Ammo_MagA > 0 and Animation_Script.Current_Anim_Playing == false and player_value.Anim_HM_Done1 == true:
				Animation_Script.Current_Anim_Playing = true
				Holding_GunR.play("gun_shoot")
				gun_shoot.play()
				if Gun_Ray.is_colliding() and Gun_Ray.get_collider().has_method("damage"):
						Gun_Ray.get_collider().damage()
				Ammo_MagA = Ammo_MagA - 1 # Deduces the number of bullets in magazine
				if Ammo_MagA <= 0: # If 0 bullets in magazine, no longer shoots
					Can_use_Range = false
			elif Ammo_MagA <= 0:
				gun_click.play()

		2:
			Holding_MeleeR.play("sword_swing")
			if Point_Ray.is_colliding() and Point_Ray.get_collider().has_method("damage"): # Check is ray is coliding, and if so, get #damage method
				Point_Ray.get_collider().damage() # Gets "damage method and executes it"
func Tool_HandlingL():
	Can_use_Range = true
	match player_value.L_Hand_In_Use:
		0:
			if Can_use_Close == true and Animation_Script.Current_Anim_Playing == false:
				Animation_Script.Current_Anim_Playing = true
				Holding_HandL.play("hand_pointing") # Play animation
				Tool_Gen_Interaction()
		1:
			if Can_use_Range == true and Ammo_MagA > 0 and Animation_Script.Current_Anim_Playing == false and player_value.Anim_HM_Done1 == true:
				Animation_Script.Current_Anim_Playing = true
				Holding_GunL.play("gun_shoot")
				gun_shoot.play()
				if Gun_Ray.is_colliding() and Gun_Ray.get_collider().has_method("damage"):
					Gun_Ray.get_collider().damage()
				Ammo_MagA = Ammo_MagA - 1 # Deduces the number of bullets in magazine
				if Ammo_MagA <= 0: # If 0 bullets in magazine, no longer shoots
					Can_use_Range = false
			elif Ammo_MagA <= 0:
				gun_click.play()

		2:
			Holding_MeleeL.play("sword_swing")
			if Point_Ray.is_colliding() and Point_Ray.get_collider().has_method("damage"): # Check is ray is coliding, and if so, get #damage method
				Point_Ray.get_collider().damage() # Gets "damage method and executes it"

func Tool_Rotate():
	Holding_HandR.visible = false
	Holding_HandL.visible = false
	
	Holding_GunR.visible = false # Defaults tool invisibility
	Holding_GunL.visible = false
	
	Holding_MeleeR.visible = false
	Holding_MeleeL.visible = false
	
	Hand_MiscellaneousR.visible = false
	Hand_MiscellaneousL.visible = false
	
	if player_value.Alive == true and player_value.Undeath == false:
		if player_value.R_Hand_In_Use == 0: # RIGHT TOOL
			Holding_HandR.visible = true
			if Animation_Script.Current_Anim_Playing == false:
				Holding_HandR.play("hand_idle")
				Can_use_Close = true
		
		if player_value.L_Hand_In_Use == 0: # LEFT TOOL
			Holding_HandL.visible = true
			if Animation_Script.Current_Anim_Playing == false:
				Holding_HandL.play("hand_idle")
				Can_use_Close = true
		
		
		if player_value.R_Hand_In_Use == 1 and player_value.Anim_HM_Done1 == false: # RIGHT TOOL TRANS. ANIMATION
			Hand_MiscellaneousR.visible = true
			Hand_MiscellaneousR.play("hand_misc_change_gun")
		elif player_value.R_Hand_In_Use == 1: # RIGHT TOOL
			Holding_GunR.visible = true
			if Animation_Script.Current_Anim_Playing == false:
				Holding_GunR.play("gun_idle")
		
		if player_value.L_Hand_In_Use == 1 and player_value.Anim_HM_Done1 == false: # LEFT TOOL TRANS. ANIMATION
			Hand_MiscellaneousL.visible = true
			Hand_MiscellaneousL.play("hand_misc_change_gun")
		elif player_value.L_Hand_In_Use == 1: # LRFT TOOL
			Holding_GunL.visible = true
			if Animation_Script.Current_Anim_Playing == false:
				Holding_GunL.play("gun_idle")
		
		
		if player_value.R_Hand_In_Use == 2 and player_value.Anim_HM_Done2 == false: # RIGHT TOOL TRANS. ANIMATION
			Hand_MiscellaneousR.visible = true
			Hand_MiscellaneousR.play("hand_misc_change_sword")
		elif player_value.R_Hand_In_Use == 2: # RIGHT TOOL
			if Animation_Script.Current_Anim_Playing == false:
				Holding_MeleeR.visible = true
		
		if player_value.L_Hand_In_Use == 2 and player_value.Anim_HM_Done2 == false: # LEFT TOOL TRANS. ANIMATION
			Hand_MiscellaneousL.visible = true
			Hand_MiscellaneousL.play("hand_misc_change_sword")
		elif player_value.L_Hand_In_Use == 2: # LEFT TOOL
			if Animation_Script.Current_Anim_Playing == false:
				Holding_MeleeL.visible = true
		else:
			pass
		
		# Item Rotation
		# Keyboard
		if player.Key_C:
			if Input.is_action_just_pressed("In_Key_Rot_Right"): # Rotates "Tool In Use" index
				player_value.R_Hand_In_Use += 1
			if Input.is_action_just_pressed("In_Key_Rot_Left"):
				player_value.L_Hand_In_Use += 1
			if Input.is_action_just_pressed("In_Disarm"):
				player_value.R_Hand_In_Use = 0
		# Joypad
		if player.Joy_C:
			if Input.is_action_just_released("In_JoyD_Right"):
				player_value.R_Hand_In_Use = player_value.R_Hand_In_Use + 1
			if Input.is_action_just_pressed("In_JoyD_Left"):
				player_value.L_Hand_In_Use += 1
			elif Input.is_action_just_pressed("In_Joy_Disarm"):
				player_value.R_Hand_In_Use = 0
		
		if player_value.R_Hand_In_Use == player_value.L_Hand_In_Use and player_value.R_Hand_In_Use != 0:
			player_value.L_Hand_In_Use += 1
		elif player_value.L_Hand_In_Use == player_value.R_Hand_In_Use and player_value.R_Hand_In_Use != 0:
			player_value.R_Hand_In_Use += 1
		player_value.R_Hand_In_Use = wrapi(player_value.R_Hand_In_Use, 0, max_tools)
		player_value.L_Hand_In_Use = wrapi(player_value.L_Hand_In_Use, 0, max_tools)

func Tool_AltR():	
	match player_value.R_Hand_In_Use:
		0:
			pass
			#Holding_HandR.play("hand_pointing") # Play animation
			#if Point_Ray.is_colliding() and Point_Ray.get_collider().has_method("interact"): # Check is ray is coliding, and if so, get #damage method
				#Point_Ray.get_collider().interact() # Gets "damage method and executes it"
		1:
			if Can_use_Range_alt == true and Animation_Script.Current_Anim_Playing == false and MagA_ExcessR == true:
				Animation_Script.Current_Anim_Playing = true
				Holding_GunR.play("gun_reload")
				gun_reload.play()
				if Holding_GunR.animation == "gun_reload":
					Ammo_MagA = Max_Ammo_MagA # Deduces the number of bullets in magazine
					MagA_Num -= 1
func Tool_AltL():	
	match player_value.L_Hand_In_Use:
		0:
			pass
			#Holding_HandR.play("hand_pointing") # Play animation
			#if Point_Ray.is_colliding() and Point_Ray.get_collider().has_method("interact"): # Check is ray is coliding, and if so, get #damage method
				#Point_Ray.get_collider().interact() # Gets "damage method and executes it"
		1:
			if Can_use_Range_alt == true and Animation_Script.Current_Anim_Playing == false and MagA_ExcessR == true:
				Animation_Script.Current_Anim_Playing = true
				Holding_GunL.play("gun_reload")
				gun_reload.play()
				if Holding_GunL.animation == "gun_reload":
					Ammo_MagA = Max_Ammo_MagA # Deduces the number of bullets in magazine
					MagA_Num -= 1

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
	if not Point_Ray.is_colliding():
		return
	var target = Point_Ray.get_collider()
	if target.has_method("interact"):
		var hit_pos = Point_Ray.get_collision_point()
		var dir = Point_Ray.global_transform.basis.z.normalized()
		target.interact(hit_pos, dir)
