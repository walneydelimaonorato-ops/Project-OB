extends Node

var Current_Index: int = 1
var Min_Index: int = 1
var Max_Index: int = 5

func _ready() -> void:
	if Global.Player_Data.Developer_Mode == false:
		$"..".queue_free()
		print_rich("[color=purple]CURRENTLY RUNNING IN: RETAIL MODE")
	else:
		print_rich("[color=purple]CURRENTLY RUNNING IN: DEVELOPER MODE")
		
		Page_Flip(false)
		%"Debug Backdrop".visible = false
		%"Context Backdrop".visible = false
		%"Focus Inspector".visible = false
		%"Free Cam Backdrop".visible = false
		Global.Player_Data.Context_Debug = 0
		Global.Player_Data.Free_Cam_Mode = false
		$"../../../Head/Eyes".make_current()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Deb_Quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("Deb_Toggle"):
		%"Debug Backdrop".visible = !%"Debug Backdrop".visible
		%"Focus Inspector".visible = %"Debug Backdrop".visible
	
	
	if Input.is_action_just_pressed("Deb_Increase"):
		Page_Flip(true)
	if Input.is_action_just_pressed("Deb_Decrease"):
		Page_Flip(false)
	
	
	elif Input.is_action_just_pressed("Deb_Lvl_Select"):
		Global.Next_Scene = "uid://1vffiiuaho52"
		get_tree().change_scene_to_packed(Global.Load_New)
	elif Input.is_action_just_pressed("Deb_Context_Menu"):
		%"Context Backdrop".visible = !%"Context Backdrop".visible
		if %"Context Backdrop".visible == true:
			Global.Player_Data.Context_Debug = 1
			Input.mouse_mode = Input.MOUSE_MODE_CONFINED
		else:
			%"Context Tree".visible = false
			Global.Player_Data.Context_Debug = 0
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	elif Input.is_action_just_pressed("Deb_Free_Cam"):
		Global.Player_Data.Free_Cam_Mode = !Global.Player_Data.Free_Cam_Mode
		%"Free Cam Backdrop".visible = Global.Player_Data.Free_Cam_Mode
		if Global.Player_Data.Free_Cam_Mode == true:
			%"Free Cam".make_current()
			Global.Player_Data.Player_Perms.Can_Show_UI_Side = false
			Global.Player_Data.Player_Perms.Can_Show_UI_Stats = false
			Global.Player_Data.Player_Perms.Can_Move = false
			Global.Player_Data.Player_Perms.Can_Look = false
		elif Global.Player_Data.Free_Cam_Mode == false:
			$"../../../Head/Eyes".make_current()
			Global.Player_Data.Player_Perms.Can_Show_UI_Side = true
			Global.Player_Data.Player_Perms.Can_Show_UI_Stats = true
			Global.Player_Data.Player_Perms.Can_Move = true
			Global.Player_Data.Player_Perms.Can_Look = true

func _process(delta: float) -> void:
	if %"Debug Backdrop".visible == true:
		Monitoring()

func Page_Flip(Operate: bool):
	if Operate == false:
		Current_Index -= 1
	elif Operate == true:
		Current_Index += 1
	
	Current_Index = clamp(Current_Index, Min_Index, Max_Index)
	
	var Pages = {
		"1" = %"Page 1",
		"2" = %"Page 2",
		"3" = %"Page 3",
		"4" = %"Page 4",
		"5" = %"Page 5",
		"6" = %"Page 6",
	}
	
	%"Page 1".visible = false
	%"Page 2".visible = false
	%"Page 3".visible = false
	%"Page 4".visible = false
	%"Page 5".visible = false
	%"Page 6".visible = false
	
	Pages.values()[Current_Index - 1].visible = true

func Monitoring():
	if %"Focus Inspector".visible == true:
		%"Focus Node".text = Global.Player_Data.Current_Focus
	
	var Pager: String = str("(", Current_Index, "/", Max_Index, ")")
	if %"Page 1".visible == true:
		%"Page 1".text = str(Pager, "Ready Debug")
		%"Page 1".text += str("\rFPS: ", Engine.get_frames_per_second())
		%"Page 1".text += str("\rDFPS: ", Engine.get_frames_drawn())
		%"Page 1".text += str("\rPosition: ", floor($"../../..".position * 1000.0) / 1000.0)
		%"Page 1".text += str("\rRotation: ", floor($"../../..".rotation.y * 100.0) / 100.0)
		%"Page 1".text += str("\rSpeed: ", floor($"../../..".velocity.length() * 100.0) / 100.0)
	
	elif %"Page 2".visible == true:
		%"Page 2".text = str(Pager, "Stats")
		%"Page 2".text += str("\rHealth: ", Global.Player_Data.Health, "/", Global.Player_Data.Health_Max)
		%"Page 2".text += str("\rStamina: ", Global.Player_Data.Stamina, "/", Global.Player_Data.Stamina_Max)
	
	elif %"Page 3".visible == true:
		%"Page 3".text = str(Pager, "Superf. Inventory Inspect")
		%"Page 3".text += str("\rInv_Brace: ", Global.Player_Data.Inv_Brace_Equiped)
		%"Page 3".text += str("\rInv_Wear: ", Global.Player_Data.Inv_Wear_Equiped)
		%"Page 3".text += str("\rInv_ToolL: ", Global.Player_Data.Inv_ToolL_Equiped)
		%"Page 3".text += str("\rInv_ToolR: ", Global.Player_Data.Inv_ToolR_Equiped)
		%"Page 3".text += str("\rInv_Spell: ", Global.Player_Data.Inv_Spell_Equiped)
		%"Page 3".text += str("\rInv_Uitem1: ", Global.Player_Data.Inv_Uitem1_Equiped)
		%"Page 3".text += str("\rInv_Uitem2: ", Global.Player_Data.Inv_Uitem2_Equiped)
		%"Page 3".text += str("\rInv_Uitem3: ", Global.Player_Data.Inv_Uitem3_Equiped)
		%"Page 3".text += str("\rCycle_Uitem_Active: ", Global.Player_Data.Cycle_Uitem_Active)
		%"Page 3".text += str("\rCycle_Uitem_Index: ", Global.Player_Data.Cycle_Uitem_Index)
	
	elif %"Page 4".visible == true:
		%"Page 4".text = str(Pager, "Tools Insight")
		#%"Page 4".text += str("\r>Sword: [Pick/Equi]: ", Global.Player_Data.Tool_ID["Sword"]["picked?"], " / ", Global.Player_Data.Tool_ID["Sword"]["equipped?"])
		#%"Page 4".text += str("\r>Dagger: [Pick/Equi]: ", Global.Player_Data.Tool_ID["Dagger"]["picked?"], " / ", Global.Player_Data.Tool_ID["Dagger"]["equipped?"])
		#%"Page 4".text += str("\r>HandGun: [Pick/Equi]: ", Global.Player_Data.Tool_ID["HandGun"]["picked?"], " / ", Global.Player_Data.Tool_ID["HandGun"]["equipped?"])
		#%"Page 4".text += str("\r>AssaultRifle: [Pick/Equi]: ", Global.Player_Data.Tool_ID["AssaultRifle"]["picked?"], " / ", Global.Player_Data.Tool_ID["AssaultRifle"]["equipped?"])
		#%"Page 4".text += str("\r>AssaultRifle: [Pick/Equi]: ", Global.Player_Data.Tool_ID["AssaultRifle"]["picked?"], " / ", Global.Player_Data.Tool_ID["AssaultRifle"]["equipped?"])
	
	elif %"Page 5".visible == true:
		%"Page 5".text = str(Pager, "PLayer Permissions Insight")
		%"Page 5".text += str("\rCan_Open_Menus", "[color=red]", Global.Player_Data.Player_Perms["Can_Open_Menus"], "[/color]")
		%"Page 5".text += str("\rCan_Use_Sword", "[color=red]", Global.Player_Data.Player_Perms["Can_Use_Sword"], "[/color]")
		%"Page 5".text += str("\rCan_Use_Dagger", "[color=red]", Global.Player_Data.Player_Perms["Can_Use_Dagger"], "[/color]")
		%"Page 5".text += str("\rCan_Use_HandGun", "[color=red]", Global.Player_Data.Player_Perms["Can_Use_HandGun"], "[/color]")
		%"Page 5".text += str("\rCan_Use_AssaultRifle", "[color=red]", Global.Player_Data.Player_Perms["Can_Use_AssaultRifle"], "[/color]")
		%"Page 5".text += str("\rCan_Show_UI_Side", "[color=red]", Global.Player_Data.Player_Perms["Can_Show_UI_Side"], "[/color]")
		%"Page 5".text += str("\rCan_Show_UI_Stats", "[color=red]", Global.Player_Data.Player_Perms["Can_Show_UI_Stats"], "[/color]")
		%"Page 5".text += str("\rCan_Show_Prompts", "[color=red]", Global.Player_Data.Player_Perms["Can_Show_Prompts"], "[/color]")
		%"Page 5".text += str("\rCan_Move", "[color=red]", Global.Player_Data.Player_Perms["Can_Move"], "[/color]")
		%"Page 5".text += str("\rCan_Sprint", "[color=red]", Global.Player_Data.Player_Perms["Can_Sprint"], "[/color]")
		%"Page 5".text += str("\rCan_Look", "[color=red]", Global.Player_Data.Player_Perms["Can_Look"], "[/color]")
		%"Page 5".text += str("\rCan_Use_Menus", "[color=red]", Global.Player_Data.Player_Perms["Can_Use_Menus"], "[/color]")
		%"Page 5".text += str("\rCan_Use_UItems", "[color=red]", Global.Player_Data.Player_Perms["Can_Use_UItems"], "[/color]")
		#%"Page 5".text += str("\raa", "[color=red]", Global.Player_Data.Player_Perms["ada"], "[/color]")
