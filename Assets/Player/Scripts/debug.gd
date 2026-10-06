extends Node

@onready var player_stats: Node = $"../../../Script Nodes/Player Stats"
#@onready var stats_management: Node = $"../../../Script Nodes/Stats Management"

@onready var health: TextureProgressBar = %Health
@onready var stamina: TextureProgressBar = %Stamina

@onready var debug_backdrop: PanelContainer = $"../Debug Backdrop"
@onready var page_1: Label = $"../Debug Backdrop/Page 1"
@onready var page_2: Label = $"../Debug Backdrop/Page 2"
@onready var page_3: Label = $"../Debug Backdrop/Page 3"
@onready var Page_4S: HBoxContainer = $"../Debug Backdrop/Page 4s"
@onready var page_4: Label = $"../Debug Backdrop/Page 4s/Page 4"
@onready var page_4A: Label = $"../Debug Backdrop/Page 4s/Page 4A"
@onready var page_5s: HBoxContainer = $"../Debug Backdrop/Page 5s"
@onready var focus_node: Label = $"../Focus Node"

var Active: bool = false
var Page: int = 1

func _ready() -> void:
	print_rich("[color=#ffdf00]Debug Working[/color]")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Deb_Toggle"):
		Active = not Active
		GLOBAL.Player_Data.Debug_Fly = not GLOBAL.Player_Data.Debug_Fly
		$"../../../Collision 1".disabled = not $"../../../Collision 1".disabled
	if Input.is_action_just_pressed("Deb_Increase"):
		Page += 1
	if Input.is_action_just_pressed("Deb_Decrease"):
		Page -= 1
	if Input.is_action_just_pressed("Deb_Quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("Deb_Reload"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("Deb_Lvl_Select"):
		GLOBAL.Next_Scene = "uid://1vffiiuaho52"
		get_tree().change_scene_to_packed(GLOBAL.Load_New)
	
	
	Page = clamp(Page, 1, 5)
	
	if Active == true:
		debug_backdrop.visible = true
	elif Active == false:
		debug_backdrop.visible = false
	
	match Page:
		1:
			page_1.visible = true
			page_2.visible = false
			page_3.visible = false
			Page_4S.visible = false
			page_5s.visible = false
		2:
			page_1.visible = false
			page_2.visible = true
			page_3.visible = false
			Page_4S.visible = false
			page_5s.visible = false
		3:
			page_1.visible = false
			page_2.visible = false
			page_3.visible = true
			Page_4S.visible = false
			page_5s.visible = false
		4:
			page_1.visible = false
			page_2.visible = false
			page_3.visible = false
			Page_4S.visible = true
			page_5s.visible = false
		5:
			page_1.visible = false
			page_2.visible = false
			page_3.visible = false
			Page_4S.visible = false
			page_5s.visible = true
	
	page_1.text = "TST Vars"
	page_1.text += str("\rPosition: ", $"../../..".position)
	page_1.text += str("\rSpeed: ", $"../../..".velocity.length())
	
	page_2.text = "HUD Vars"
	page_2.text += str("\rControl_Mode: " + GLOBAL.Player_Data.Control_Mode)
	page_2.text += str("\rHealth_Max: %d") % GLOBAL.Player_Data.Health_Max
	page_2.text += str(" // Stamina_Max: %d") % GLOBAL.Player_Data.Stamina_Max
	page_2.text += "\rHealth: %d" % GLOBAL.Player_Data.Health
	page_2.text += "\rStamina: %.2f" % GLOBAL.Player_Data.Stamina
	page_2.text += str("\rBar_Health: %d") % health.value
	page_2.text += str("\rBar_Stamina: %d") % stamina.value
	page_2.text += "\r."
	page_2.text += str("\rTH_Active: ", GLOBAL.Player_Data.TH_Active)
	page_2.text += str("\rTH_Active_Valid: ", GLOBAL.Player_Data.TH_Active_Valid)
	page_2.text += str("\rTH_Tapped: ", GLOBAL.Player_Data.TH_Tapped)
	page_2.text += str("\rTH_Held: ", GLOBAL.Player_Data.TH_Held)
	#page_2.text += str("\r: ", GLOBAL.Player_Data.)
	page_2.text += str("\rTH_Timing: ", GLOBAL.Player_Data.TH_Timing)
	
	page_3.text = "Menu Vars"
	page_3.text += str("\rCurrent_Menu: " + GLOBAL.Player_Data.Current_Menu)
	page_3.text += str("\rCurrent_SubMenu: " + PLY_Flags.Menus["Current SubMenu"])
	page_3.text += str("\rReady_Menu_Active: ", GLOBAL.Player_Data.Ready_Menu_Active)
	page_3.text += str("\rSeletion_Menu_Active: ", GLOBAL.Player_Data.Seletion_Menu_Active)
	page_3.text += str("\rChoice_Menu_Active: ", GLOBAL.Player_Data.Choice_Menu_Active)
	
	page_3.text += "\r........."
	page_3.text += str("\rInv_Brace: ", GLOBAL.Player_Data.Inv_Brace_Equiped)
	page_3.text += str("\rInv_Wear: ", GLOBAL.Player_Data.Inv_Wear_Equiped)
	page_3.text += str("\rInv_ToolL: ", GLOBAL.Player_Data.Inv_ToolL_Equiped)
	page_3.text += str("\rInv_ToolR: ", GLOBAL.Player_Data.Inv_ToolR_Equiped)
	page_3.text += str("\rInv_Spell: ", GLOBAL.Player_Data.Inv_Spell_Equiped)
	page_3.text += str("\rInv_Uitem1: ", GLOBAL.Player_Data.Inv_Uitem1_Equiped)
	page_3.text += str("\rInv_Uitem2: ", GLOBAL.Player_Data.Inv_Uitem2_Equiped)
	page_3.text += str("\rInv_Uitem3: ", GLOBAL.Player_Data.Inv_Uitem3_Equiped)
	page_3.text += str("\rCycle_Uitem_Active: ", GLOBAL.Player_Data.Cycle_Uitem_Active)
	page_3.text += str("\rCycle_Uitem_Index: ", GLOBAL.Player_Data.Cycle_Uitem_Index)
	
	page_4.text = "Can // Can"
	page_4.text += "\rStates........."
	page_4.text += "\rPlayer_Status_Master: " + GLOBAL.Player_Data.Player_Status_Master
	page_4.text += "\rPlayer_Status_1: " + GLOBAL.Player_Data.Player_Status_1
	page_4.text += "\rPlayer_Status_2: " + GLOBAL.Player_Data.Player_Status_2
	page_4.text += "\rPlayer_Status_3: " + GLOBAL.Player_Data.Player_Status_3
	
	page_4.text += "\rMovement........."
	page_4.text += str("\rCan_Move: ", GLOBAL.Player_Data.Player_Perms.Can_Move)
	page_4.text += str("\rCan_Sprint: ", GLOBAL.Player_Data.Player_Perms.Can_Sprint)
	page_4.text += str("\rCan_Look: ", GLOBAL.Player_Data.Player_Perms.Can_Look)
	
	page_4.text += "\rTool........."
	page_4.text += str("\rCan_Use_Sword: ", GLOBAL.Player_Data.Player_Perms.Can_Use_Sword)
	page_4.text += str("\rCan_Use_Dagger: ", GLOBAL.Player_Data.Player_Perms.Can_Use_Dagger)
	page_4.text += str("\rCan_Use_HandGun: ", GLOBAL.Player_Data.Player_Perms.Can_Use_HandGun)
	page_4.text += str("\rCan_Use_AssaultRifle: ", GLOBAL.Player_Data.Player_Perms.Can_Use_AssaultRifle)
	page_4.text += str("\rCan_Use_UItems: ", GLOBAL.Player_Data.Player_Perms.Can_Use_UItems)
	
	page_4A.text = " "
	page_4A.text += "\rUser Interface........."
	page_4A.text += str("\rCan_Open_Menus: ", GLOBAL.Player_Data.Player_Perms.Can_Open_Menus)
	page_4A.text += str("\rCan_Show_UI_Side: ", GLOBAL.Player_Data.Player_Perms.Can_Show_UI_Side)
	page_4A.text += str("\rCan_Show_UI_Stats: ", GLOBAL.Player_Data.Player_Perms.Can_Show_UI_Stats)
	page_4A.text += str("\rCan_Show_Prompts: ", GLOBAL.Player_Data.Player_Perms.Can_Show_Prompts)
	page_4A.text += str("\rCan_Use_Menus: ", GLOBAL.Player_Data.Player_Perms.Can_Use_Menus)
	
	#page_4.text += str("\r: ", GLOBAL.Player_Data.)
	#page_4.text += str("\r: ", GLOBAL.Player_Data.)
	#page_4.text += str("\r: ", GLOBAL.Player_Data.)
	#page_4.text += str("\r: ", GLOBAL.Player_Data.)
	#page_4.text += str("\r: ", GLOBAL.Player_Data.)
	
	
	
	focus_node.text = GLOBAL.Player_Data.Current_Focus
