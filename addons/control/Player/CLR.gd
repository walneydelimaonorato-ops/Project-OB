extends CanvasLayer

var ot = true
var ot1 = 1

@onready var player : CharacterBody3D = $"../../../.."
@onready var player_value = $"../../../../Player_Values"
@onready var Animation_Script: Node3D = $"../../../../Animation_Handler"
@onready var Tool_Script: Node3D = $"../../../../Tool_Node"

@onready var player_H_bar: ProgressBar = $Control/HUD/Health
@onready var player_E_bar: ProgressBar = $Control/HUD/Energy

@onready var ToolR: Label = $"Control/HUD/Tool UI Right"
@onready var ToolL: Label = $"Control/HUD/Tool UI Left"

@onready var UItem: Label = $"Control/HUD/UItem UI"

@onready var Inter: Label = $"Control/HUD/Interact label"

@onready var Death_Text: Label = $"Control/Death Screen/Death Text"
@onready var RespawnB: Button = $"Control/Death Screen/RespawnB"

@onready var cross_hand: Sprite2D = $"Control/HUD/Tool UI Right/cross hand"
@onready var cross_gun: Sprite2D = $"Control/HUD/Tool UI Right/cross gun"
@onready var cross_sword: Sprite2D = $"Control/HUD/Tool UI Right/cross sword"

var inter_prompt = "test"

func _process(_delta: float) -> void:
	if player_value.Alive == false or player_value.Undeath == true or player_value.Menu_mode == true:
		ToolL.visible = false
		ToolR.visible = false
		UItem.visible = false
		$"Control/Usable items/UItem".visible = false
	else:
		ToolL.visible = true
		ToolR.visible = true
		UItem.visible = true
		$"Control/Usable items/UItem".visible = true
	
	Debug_UI()
	Tool_HUD()
	Interact_HUD()
	UItem_HUD()
	if player_value.Alive == false:
		Death_Screen_State()

func Debug_UI():
	# Debug viewer
	if player.Key_C:
		global.debug.add_property("Keyboard", player.Key_C, 1)
	if player.Joy_C:
		global.debug.add_property("Joypad", player.Joy_C, 1)
	global.debug.add_property("E", player_value.Stamina, 2)
	global.debug.add_property("Health", player_value.Health, 3)
	global.debug.add_property("R hand", player_value.R_Hand_In_Use, 4) 
	global.debug.add_property("L hand", player_value.L_Hand_In_Use, 5)
	global.debug.add_property("Item", player_value.Usable_Item_Selected, 6)
	global.debug.add_property("Alive", player_value.Alive, 7)
	global.debug.add_property("Menu mode", player_value.Menu_mode, 8)
	global.debug.add_property("Menu depth", player_value.Menu_Depth, 9)
	global.debug.add_property("Menu to", player_value.Item_Menu_To, 10)
	global.debug.add_property("Menu slot", player_value.Item_Menu_Slot, 11)
	global.debug.add_property("One Time", player_value.One_Time, 12) 
	global.debug.add_property("Focus node", $"Control/Menus/Ready Menu".Focused_Button, 13)
	
	$"../PLayer State/PS Insight/PS_List/PS_Label".text = "Player states:\r"
	$"../PLayer State/PS Insight/PS_List/PS_Label".text += player_value.PLayer_State_Movement
	$"../PLayer State/PS Insight/PS_List/PS_Label".text += player_value.PLayer_State_Action
	$"../PLayer State/PS Insight/PS_List/PS_Label".text += player_value.PLayer_State_Special
	
	if global.Gdebug_active == true:
		player_H_bar.visible = true
		player_E_bar.visible = true
		$"../PLayer State".visible = true
	else:
		player_H_bar.visible = false
		player_E_bar.visible = false
		$"../PLayer State".visible = false
	
	player_H_bar.value = player_value.Health
	player_E_bar.value = player_value.Stamina

func Tool_HUD():
	cross_hand.visible = false
	cross_gun.visible = false
	cross_sword.visible = false
	
	var ToolR_ID_Got = player_value.ToolR_Get_ID()
	if ToolR_ID_Got.is_empty():
		visible = false
		return
		
	var ToolL_ID_Got = player_value.ToolLGet_ID()
	if ToolL_ID_Got.is_empty():
		visible = false
	visible = true
	
	ToolR.text = ToolR_ID_Got.name
	ToolL.text = ToolL_ID_Got.name
	
	if ToolR_ID_Got.id == "close":
		cross_hand.visible = true
		
	if ToolR_ID_Got.id == "range":
		cross_gun.visible = true
		ToolR.text += str("\r%d/%d\rM: %d") % [Tool_Script.Ammo_MagA, Tool_Script.Max_Ammo_MagA, Tool_Script.MagA_Num]
	if ToolL_ID_Got.id == "range":
		ToolL.text += str("\r%d/%d\rM: %d") % [Tool_Script.Ammo_MagA, Tool_Script.Max_Ammo_MagA, Tool_Script.MagA_Num]
	
	if ToolR_ID_Got.id == "melee":
		cross_sword.visible = true

func Interact_HUD():
	var ToolR_ID_Got = player_value.ToolR_Get_ID()
	if ToolR_ID_Got.is_empty():
		return
		
	Inter.visible = false
	if Tool_Script.Point_Ray.is_colliding():
		var point_coll = Tool_Script.Point_Ray.get_collider()
		#if Tool_Script.Point_Ray.get_collider().has_method("CLR_info") and ToolR_ID_Got.id == "close":
		if point_coll.has_method("CLR_info"):
			Inter.visible = true
			Inter.text = point_coll.HUD_Prompt
	
	#if Tool_Script.Reload_failed == true and ToolR_ID_Got.id == "range":
		#Inter.visible = true
		#Inter.text = "Cannot reload"

func UItem_HUD():
	var UItem_ID_Got = player_value.UItem_Get_ID()
	UItem.text = UItem_ID_Got.name
	
	if UItem_ID_Got.name == "Glass flask":
		UItem.text += str("\rX:%d") % UItem_ID_Got["quantity"]
		
	if UItem_ID_Got.name == "Wild gold":
		UItem.text += str("\rX:%d") % UItem_ID_Got["quantity"]

func Death_Screen_State():
	if ot == true:
		Death_Text.visible = true
		RespawnB.visible = true
		if ot1 == 1:
			Death_Text.grab_focus()
			ot1 - 1
		$"../../../../Player_sfx/General sfx/death jingle".play()
		ot = false
	else:
		pass

func _on_respawnb_button_down() -> void:
	await get_tree().create_timer(0).timeout
	get_tree().change_scene_to_file("res://addons/scenes/Maps/Death Void/DEATH_VOID.tscn")
