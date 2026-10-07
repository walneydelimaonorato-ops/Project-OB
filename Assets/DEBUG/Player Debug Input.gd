extends Node

func _ready() -> void:
	if BugBus.Developer_Mode == false:
		$"..".queue_free()
		print_rich("[color=purple]CURRENTLY RUNNING IN: RETAIL MODE")
	else:
		print_rich("[color=purple]CURRENTLY RUNNING IN: DEVELOPER MODE")
		
		%"Debug Backdrop".visible = false
		%"Context Backdrop".visible = false
		%"Focus Inspector".visible = false
		
		
		#GLOBAL.Player_Data.Context_Debug = 0
		#GLOBAL.Player_Data.Free_Cam_Mode = false
		#
#
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Deb_Toggle"):
		%"Debug Backdrop".visible = !%"Debug Backdrop".visible
		%"Focus Inspector".visible = %"Debug Backdrop".visible
	
	
	elif Input.is_action_just_pressed("Deb_Context_Menu"):
		%"Context Backdrop".visible = !%"Context Backdrop".visible
		if %"Context Backdrop".visible == true:
			Input.mouse_mode = Input.MOUSE_MODE_CONFINED
		else:
			%"Context Tree".visible = false
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	
	elif Input.is_action_just_pressed("Deb_Lvl_Select"):
		GLOBAL.Next_Scene = "uid://1vffiiuaho52"
		get_tree().change_scene_to_packed(GLOBAL.Load_New)
	
	elif Input.is_action_just_pressed("Deb_Free_Cam"):
		pass
	
	
	if Input.is_action_just_pressed("Deb_Increase"):
		if %"Debug Backdrop".visible == true:
			%"Debug Cont".current_tab += 1
	if Input.is_action_just_pressed("Deb_Decrease"):
		if %"Debug Backdrop".visible == true:
			%"Debug Cont".current_tab -= 1
	
	
	#elif Input.is_action_just_pressed("Deb_Free_Cam"):
		#GLOBAL.Player_Data.Free_Cam_Mode = !GLOBAL.Player_Data.Free_Cam_Mode
		#%"Free Cam Backdrop".visible = GLOBAL.Player_Data.Free_Cam_Mode
		#if GLOBAL.Player_Data.Free_Cam_Mode == true:
			#%"Free Cam".make_current()
			#GLOBAL.Player_Data.Player_Perms.Can_Show_UI_Side = false
			#GLOBAL.Player_Data.Player_Perms.Can_Show_UI_Stats = false
			#GLOBAL.Player_Data.Player_Perms.Can_Move = false
			#GLOBAL.Player_Data.Player_Perms.Can_Look = false
		#elif GLOBAL.Player_Data.Free_Cam_Mode == false:
			#$"../../../Head/Eyes".make_current()
			#GLOBAL.Player_Data.Player_Perms.Can_Show_UI_Side = true
			#GLOBAL.Player_Data.Player_Perms.Can_Show_UI_Stats = true
			#GLOBAL.Player_Data.Player_Perms.Can_Move = true
			#GLOBAL.Player_Data.Player_Perms.Can_Look = true
#
#func _process(delta: float) -> void:
	#if %"Debug Backdrop".visible == true:
		#Monitoring()
#

#
#func Monitoring():
	#if %"Focus Inspector".visible == true:
		#%"Focus Node".text = GLOBAL.Player_Data.Current_Focus
	#
	#var Pager: String = str("(", Current_Index, "/", Max_Index, ")")
	#if %"Page 1".visible == true:
		#%"Page 1".text = str(Pager, "Ready Debug")
		#%"Page 1".text += str("\rFPS: ", Engine.get_frames_per_second())
		#%"Page 1".text += str("\rDFPS: ", Engine.get_frames_drawn())
		#%"Page 1".text += str("\rPosition: ", floor($"../../..".position * 1000.0) / 1000.0)
		#%"Page 1".text += str("\rRotation: ", floor($"../../..".rotation.y * 100.0) / 100.0)
		#%"Page 1".text += str("\rSpeed: ", floor($"../../..".velocity.length() * 100.0) / 100.0)
	#
	#elif %"Page 2".visible == true:
		#%"Page 2".text = str(Pager, "Stats")
		#%"Page 2".text += str("\rHealth: ", GLOBAL.Player_Data.Health, "/", GLOBAL.Player_Data.Health_Max)
		#%"Page 2".text += str("\rStamina: ", GLOBAL.Player_Data.Stamina, "/", GLOBAL.Player_Data.Stamina_Max)
	#
	#elif %"Page 3".visible == true:
		#%"Page 3".text = str(Pager, "Superf. Inventory Inspect")
		#%"Page 3".text += str("\rInv_Brace: ", GLOBAL.Player_Data.Inv_Brace_Equiped)
		#%"Page 3".text += str("\rInv_Wear: ", GLOBAL.Player_Data.Inv_Wear_Equiped)
		#%"Page 3".text += str("\rInv_ToolL: ", GLOBAL.Player_Data.Inv_ToolL_Equiped)
		#%"Page 3".text += str("\rInv_ToolR: ", GLOBAL.Player_Data.Inv_ToolR_Equiped)
		#%"Page 3".text += str("\rInv_Spell: ", GLOBAL.Player_Data.Inv_Spell_Equiped)
		#%"Page 3".text += str("\rInv_Uitem1: ", GLOBAL.Player_Data.Inv_Uitem1_Equiped)
		#%"Page 3".text += str("\rInv_Uitem2: ", GLOBAL.Player_Data.Inv_Uitem2_Equiped)
		#%"Page 3".text += str("\rInv_Uitem3: ", GLOBAL.Player_Data.Inv_Uitem3_Equiped)
		#%"Page 3".text += str("\rCycle_Uitem_Active: ", GLOBAL.Player_Data.Cycle_Uitem_Active)
		#%"Page 3".text += str("\rCycle_Uitem_Index: ", GLOBAL.Player_Data.Cycle_Uitem_Index)
	#
	#elif %"Page 4".visible == true:
		#%"Page 4".text = str(Pager, "Tools Insight")
		#%"Page 4".text += str("\r>Sword: [Pick/Equi]: ", GLOBAL.Player_Data.Tool_ID["Sword"]["picked?"], " / ", GLOBAL.Player_Data.Tool_ID["Sword"]["equipped?"])
		#%"Page 4".text += str("\r>Dagger: [Pick/Equi]: ", GLOBAL.Player_Data.Tool_ID["Dagger"]["picked?"], " / ", GLOBAL.Player_Data.Tool_ID["Dagger"]["equipped?"])
		#%"Page 4".text += str("\r>HandGun: [Pick/Equi]: ", GLOBAL.Player_Data.Tool_ID["HandGun"]["picked?"], " / ", GLOBAL.Player_Data.Tool_ID["HandGun"]["equipped?"])
		#%"Page 4".text += str("\r>AssaultRifle: [Pick/Equi]: ", GLOBAL.Player_Data.Tool_ID["AssaultRifle"]["picked?"], " / ", GLOBAL.Player_Data.Tool_ID["AssaultRifle"]["equipped?"])
		#%"Page 4".text += str("\r>AssaultRifle: [Pick/Equi]: ", GLOBAL.Player_Data.Tool_ID["AssaultRifle"]["picked?"], " / ", GLOBAL.Player_Data.Tool_ID["AssaultRifle"]["equipped?"])
	#
	#elif %"Page 5".visible == true:
		#%"Page 5".text = str(Pager, "PLayer Permissions Insight")
		#%"Page 5".text += str("\rCan_Open_Menus", "[color=red]", GLOBAL.Player_Data.Player_Perms["Can_Open_Menus"], "[/color]")
		#%"Page 5".text += str("\rCan_Use_Sword", "[color=red]", GLOBAL.Player_Data.Player_Perms["Can_Use_Sword"], "[/color]")
		#%"Page 5".text += str("\rCan_Use_Dagger", "[color=red]", GLOBAL.Player_Data.Player_Perms["Can_Use_Dagger"], "[/color]")
		#%"Page 5".text += str("\rCan_Use_HandGun", "[color=red]", GLOBAL.Player_Data.Player_Perms["Can_Use_HandGun"], "[/color]")
		#%"Page 5".text += str("\rCan_Use_AssaultRifle", "[color=red]", GLOBAL.Player_Data.Player_Perms["Can_Use_AssaultRifle"], "[/color]")
		#%"Page 5".text += str("\rCan_Show_UI_Side", "[color=red]", GLOBAL.Player_Data.Player_Perms["Can_Show_UI_Side"], "[/color]")
		#%"Page 5".text += str("\rCan_Show_UI_Stats", "[color=red]", GLOBAL.Player_Data.Player_Perms["Can_Show_UI_Stats"], "[/color]")
		#%"Page 5".text += str("\rCan_Show_Prompts", "[color=red]", GLOBAL.Player_Data.Player_Perms["Can_Show_Prompts"], "[/color]")
		#%"Page 5".text += str("\rCan_Move", "[color=red]", GLOBAL.Player_Data.Player_Perms["Can_Move"], "[/color]")
		#%"Page 5".text += str("\rCan_Sprint", "[color=red]", GLOBAL.Player_Data.Player_Perms["Can_Sprint"], "[/color]")
		#%"Page 5".text += str("\rCan_Look", "[color=red]", GLOBAL.Player_Data.Player_Perms["Can_Look"], "[/color]")
		#%"Page 5".text += str("\rCan_Use_Menus", "[color=red]", GLOBAL.Player_Data.Player_Perms["Can_Use_Menus"], "[/color]")
		#%"Page 5".text += str("\rCan_Use_UItems", "[color=red]", GLOBAL.Player_Data.Player_Perms["Can_Use_UItems"], "[/color]")
		##%"Page 5".text += str("\raa", "[color=red]", GLOBAL.Player_Data.Player_Perms["ada"], "[/color]")
