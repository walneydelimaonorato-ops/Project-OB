extends Node

var Current_Index: int = 6
var Min_Index: int = 1
var Max_Index: int = 6


func _ready() -> void:
	if Global.Player_Data.Developer_Mode == false:
		%"Debug Tree".queue_free()
		print_rich("[color=purple]CURRENTLY RUNNING IN: RETAIL MODE")
	else:
		print_rich("[color=purple]CURRENTLY RUNNING IN: DEVELOPER MODE")
		
		Page_Flip(false)
		%"Debug Backdrop".visible = false
		%"Context Backdrop".visible = false
		%"Focus Inspector".visible = false
		Global.Player_Data.Context_Debug = 0

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
			Global.Player_Data.Context_Debug = 0
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

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
		%"Page 1".text += str("\rPosition: ", $"../../..".position)
		%"Page 1".text += str("\rSpeed: ", $"../../..".velocity.length())
		%"Page 1".text += str("Sin: ", Global.Save_File_A.Sin)
	
	elif %"Page 2".visible == true:
		%"Page 2".text = str(Pager, "Stats")
		%"Page 2".text += str("\rHealth: ", Global.Player_Data.Health, "/", Global.Player_Data.Health_Max)
		%"Page 2".text += str("\rStamina: ", Global.Player_Data.Stamina, "/", Global.Player_Data.Stamina_Max)
	
	#Global.Player_Data.
	
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
		%"Page 4".text += str("\r>Sword: [Pick/Equi]: ", Global.Player_Data.Tool_ID["Sword"]["picked?"], " / ", Global.Player_Data.Tool_ID["Sword"]["equipped?"])
		%"Page 4".text += str("\r>Dagger: [Pick/Equi]: ", Global.Player_Data.Tool_ID["Dagger"]["picked?"], " / ", Global.Player_Data.Tool_ID["Dagger"]["equipped?"])
		%"Page 4".text += str("\r>HandGun: [Pick/Equi]: ", Global.Player_Data.Tool_ID["HandGun"]["picked?"], " / ", Global.Player_Data.Tool_ID["HandGun"]["equipped?"])
		%"Page 4".text += str("\r>AssaultRifle: [Pick/Equi]: ", Global.Player_Data.Tool_ID["AssaultRifle"]["picked?"], " / ", Global.Player_Data.Tool_ID["AssaultRifle"]["equipped?"])
		#%"Page 4".text += str("\r>AssaultRifle: [Pick/Equi]: ", Global.Player_Data.Tool_ID["AssaultRifle"]["picked?"], " / ", Global.Player_Data.Tool_ID["AssaultRifle"]["equipped?"])
	
	elif %"Page 5".visible == true:
		%"Page 5".text = str(Pager, "Save File Insight")
		%"Page 5".text += str("\rSin: ", Global.Save_File_A.Character_File_A["Sin"])
	
