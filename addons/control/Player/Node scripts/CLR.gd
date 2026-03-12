extends CanvasLayer

var ot = true
var ot1 = 1

@onready var gang: Area3D = $"../../../../../Rest"


@onready var ps_label: Label = $"../Debug Insight/DB Insight/PS_List/PS_Label"

@onready var player : CharacterBody3D = $"../../../.."
#@onready var PlayerValue = $"../../../../PlayerValues"
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
	if PlayerValue.Alive == false or PlayerValue.Undeath == true or PlayerValue.Menu_mode == true:
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
	if PlayerValue.Alive == false:
		Death_Screen_State()

func Debug_UI():
	if global.Gdebug_active == true:
		$"../Debug Insight/DB Insight/Panel".visible = true
		$"../Debug Insight/Debug page".visible = true
		$"../Debug Insight/Debug page".text = str("Debug page: ", global.Debug_Menu_Page)
		pass
	elif global.Gdebug_active == false:
		$"../Debug Insight/DB Insight/Panel".visible = false
		$"../Debug Insight/Debug page".visible = false
	if global.Debug_Menu_Page == 1:
		$"../Debug Insight/DB Insight/DB_List".visible = true
		ps_label.visible = false
	elif global.Debug_Menu_Page != 1:
		$"../Debug Insight/DB Insight/DB_List".visible = false
		ps_label.visible = true
	
	# Debug viewer
	#global.debug.add_property("Debug page", global.Debug_Menu_Page, 1)
	if player.Key_C:
		global.debug.add_property("Keyboard", player.Key_C, 1)
	if player.Joy_C:
		global.debug.add_property("Joypad", player.Joy_C, 1)
	global.debug.add_property("E", PlayerValue.Stamina, 2)
	global.debug.add_property("Health", PlayerValue.Health, 3)
	global.debug.add_property("R hand", PlayerValue.R_Hand_In_Use, 4) 
	global.debug.add_property("L hand", PlayerValue.L_Hand_In_Use, 5)
	global.debug.add_property("Item", PlayerValue.Usable_Item_Selected, 6)
	global.debug.add_property("Alive", PlayerValue.Alive, 7)
	global.debug.add_property("Range alt", Tool_Script.Can_use_Range_Assalt_alt, 8)
	global.debug.add_property("Current anim", Animation_Script.Current_Anim_Playing, 9)
	global.debug.add_property("bpress time", PlayerValue.inter_press_time, 10)
	global.debug.add_property("Player coords", player.position, 11)
	global.debug.add_property("Respawn coords", global.G_Respwan_Coords, 12)
	#global.debug.add_property("Menu mode", PlayerValue.Menu_mode, 8)
	global.debug.add_property("Menu depth", PlayerValue.Menu_Depth, 13)
	#global.debug.add_property("Menu to", PlayerValue.Item_Menu_To, 10)
	#global.debug.add_property("Menu slot", PlayerValue.Item_Menu_Slot, 11)
	#global.debug.add_property("One Time", PlayerValue.One_Time, 12) 
	#global.debug.add_property("Focus node", $"Control/Menus/Ready Menu".Focused_Button, 13)
	#global.debug.add_property("Selected ICON", $"Control/Menus/Ready Menu".Selected_Icon, 14)
	
	if global.Debug_Menu_Page == 2:
		ps_label.text = "Player states:\r"
		ps_label.text += PlayerValue.INSIGHT_Player_State_Movement
		ps_label.text += PlayerValue.INSIGHT_Player_State_Action
		ps_label.text += PlayerValue.INSIGHT_Player_State_Special
		ps_label.text += PlayerValue.INSIGHT_Tool_R_State
		ps_label.text += PlayerValue.INSIGHT_Tool_L_State
		ps_label.text += PlayerValue.INSIGHT_Tool_Direction_Use
	
	if global.Debug_Menu_Page == 3:
		ps_label.text = "Player inventory: \r"
		ps_label.text += "Brace: " + PlayerValue.Inv_Brace_Equiped
		ps_label.text += "\rWear: " + PlayerValue.Inv_Wear_Equiped
		ps_label.text += "\rTool L: " + PlayerValue.Inv_ToolL_Equiped
		ps_label.text += "\rToll R: " + PlayerValue.Inv_ToolR_Equiped
		ps_label.text += "\rSpell: " + PlayerValue.Inv_Spell_Equiped
		ps_label.text += "\rUItem 1: " + PlayerValue.Inv_Uitem1_Equiped
		ps_label.text += "\rUItem 2: " + PlayerValue.Inv_Uitem2_Equiped
		ps_label.text += "\rUItem 3: " + PlayerValue.Inv_Uitem3_Equiped
	
	if global.Gdebug_active == true:
		player_H_bar.visible = true
		player_E_bar.visible = true
	else:
		player_H_bar.visible = false
		player_E_bar.visible = false
	
	player_H_bar.value = PlayerValue.Health
	player_E_bar.value = PlayerValue.Stamina

func Tool_HUD():
	cross_hand.visible = false
	cross_gun.visible = false
	cross_sword.visible = false
	
	match PlayerValue.Inv_ToolR_Equiped:
		"null":
			ToolR.text = "Hand"
			cross_hand.visible = true
		"HandGun":
			ToolR.text = "Gun"
			cross_gun.visible = true
			ToolR.text += str("\r%d/%d\rM: %d") % [Tool_Script.Ammo_MagA, Tool_Script.Max_Ammo_MagA, Tool_Script.MagA_Num]
		"AssaultRifle":
			ToolR.text = "Assalt"
			cross_gun.visible = true
			ToolR.text += str("\r%d/%d\rM: %d") % [Tool_Script.Ammo_MagB, Tool_Script.Max_Ammo_MagB, Tool_Script.MagB_Num]
		"Sword":
			ToolR.text = "Sword"
			cross_sword.visible = true
		"SpecialBow":
			ToolR.text = "Special Bow"
			cross_gun.visible = true
	
	match PlayerValue.Inv_ToolL_Equiped:
		"null":
			ToolL.text = "Hand"
			cross_hand.visible = true
		"HandGun":
			ToolL.text = "Gun"
			cross_gun.visible = true
			ToolL.text += str("\r%d/%d\rM: %d") % [Tool_Script.Ammo_MagA, Tool_Script.Max_Ammo_MagA, Tool_Script.MagA_Num]
		"AssaultRifle":
			ToolL.text = "Assalt"
			cross_gun.visible = true
			ToolL.text += str("\r%d/%d\rM: %d") % [Tool_Script.Ammo_MagB, Tool_Script.Max_Ammo_MagB, Tool_Script.MagB_Num]
		"Sword":
			ToolL.text = "Sword"
			cross_sword.visible = true
		"SpecialBow":
			ToolL.text = "Special Bow"
			cross_gun.visible = true

func Interact_HUD():
	Inter.visible = false
	if Tool_Script.Interact_Ray.is_colliding():
		var point_coll = Tool_Script.Interact_Ray.get_collider()
		if point_coll.has_method("CLR_info"):
			Inter.visible = true
			Inter.text = point_coll.HUD_Prompt

func UItem_HUD():
	var UItem_ID_Got = PlayerValue.UItem_Get_ID()
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
