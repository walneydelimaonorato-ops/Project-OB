extends CanvasLayer

var ot = true
var ot1 = 1

@onready var ps_label: Label = $"Control//Debug Insight/DB Insight/PS_List/PS_Label"

@onready var item_selection: Control = $"Control/Menus/Item Selection"
@onready var player : CharacterBody3D = $"../../../.."
#@onready var PlayerValue = $"../../../../PlayerValues"
@onready var Animation_Script: Node3D = $"../../../../Animation_Handler"
@onready var Tool_Script: Node3D = $"../../../../Tool_Node"

@onready var Inter: Label = $"Control/HUD/Interact label"

@onready var Death_Text: Label = $"Control/Death Screen/Death Text"
@onready var RespawnB: Button = $"Control/Death Screen/RespawnB"

@onready var cross: AnimatedSprite2D = $Control/HUD/Cross

@onready var hud_toolr: TextureRect = $"Control/HUD/Side HUD/HUD_ToolR"
@onready var hud_tooll: TextureRect = $"Control/HUD/Side HUD/HUD_ToolL"
@onready var hud_spell: TextureRect = $"Control/HUD/Side HUD/HUD_Spell"
@onready var hud_uitem: TextureRect = $"Control/HUD/Side HUD/HUD_UItem"

@onready var hud_toolr_nam: Label = $"Control/HUD/Side HUD Text/HUD_ToolR/HUD_ToolR"
@onready var desc_toolr: Label = $"Control/HUD/Side HUD Text/Desc_ToolR/Desc_ToolR"

@onready var hud_tooll_nam: Label = $"Control/HUD/Side HUD Text/HUD_ToolL/HUD_ToolL"
@onready var desc_tooll: Label = $"Control/HUD/Side HUD Text/Desc_ToolL/Desc_ToolL"

@onready var hud_spell_nam: Label = $"Control/HUD/Side HUD Text/HUD_Spell/HUD_Spell"
@onready var desc_spell: Label = $"Control/HUD/Side HUD Text/Desc_Spell/Desc_Spell"

@onready var hud_uitem_nam: Label = $"Control/HUD/Side HUD Text/HUD_UItem/HUD_UItem"
@onready var desc_uitem: Label = $"Control/HUD/Side HUD Text/Desc_UItem/Desc_UItem"

@onready var health_bar: TextureProgressBar = $Control/HUD/Health


var inter_prompt = "test"

func _process(_delta: float) -> void:
	#if PlayerValue.Alive == false or PlayerValue.Undeath == true or PlayerValue.Menu_mode == true:
		#ToolL.visible = false
		#ToolR.visible = false
	#else:
		#ToolL.visible = true
		#ToolR.visible = true
	
	Debug_UI()
	Side_HUD()
	Interact_HUD()
	UItem_HUD()
	if PlayerValue.Alive == false:
		Death_Screen_State()

func Debug_UI():
	if global.Gdebug_active == true:
		$"Control/Debug Insight/DB Insight/Panel".visible = true
		$"Control/Debug Insight/Debug page".visible = true
		$"Control/Debug Insight/Debug page".text = str("Debug page: ", global.Debug_Menu_Page)
	elif global.Gdebug_active == false:
		$"Control/Debug Insight/DB Insight/Panel".visible = false
		$"Control/Debug Insight/Debug page".visible = false
	if global.Debug_Menu_Page == 1:
		$"Control/Debug Insight/DB Insight/DB_List".visible = true
		ps_label.visible = false
	elif global.Debug_Menu_Page != 1:
		$"Control/Debug Insight/DB Insight/DB_List".visible = false
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
	#global.debug.add_property("Range alt", Tool_Script.Can_use_Range_Assalt_alt, 8)
	global.debug.add_property("bpress time", PlayerValue.inter_press_time, 8)
	global.debug.add_property("Current anim", Animation_Script.Current_Anim_Playing, 9)
	#global.debug.add_property("DH tap", PlayerValue.DH_button_tapped, 10)
	#global.debug.add_property("DH hold", PlayerValue.DH_button_held, 11)
	#global.debug.add_property("DH time", PlayerValue.DH_press_time, 12)
	#global.debug.add_property("Cry for me", PlayerValue.Tool_2_Hand, 13)
	global.debug.add_property("H bar v", health_bar.value, 10)
	global.debug.add_property("H bar mv", health_bar.max_value, 11)
	
	#global.debug.add_property("Tool rot", $"../../../CameraPlayer/Player_Model/Tool Gun".rotation, 11)
	#global.debug.add_property("Tool pos", $"../../../CameraPlayer/Player_Model/Tool Gun".position, 12)
	#global.debug.add_property("Menu mode", PlayerValue.Menu_mode, 11)
	#global.debug.add_property("Menu depth", PlayerValue.Menu_Depth, 12)
	#global.debug.add_property("Menu to", PlayerValue.Item_Menu_To, 16)
	#global.debug.add_property("Menu slot", PlayerValue.Item_Menu_Slot, 11)
	#global.debug.add_property("Rot", player.Roting, 10) 
	#global.debug.add_property("Selected ICON", $"Control/HUD/Side HUD Overlay/HUDO_ToolR".texture, 14)
	#global.debug.add_property("Close use", Animation_Script.Current_Anim_Playing, 15)
	
	if global.Debug_Menu_Page == 2:
		ps_label.text = "Player states:\r"
		ps_label.text += str(player.velocity.z) + "\r"
		ps_label.text += str(player.velocity.x) + "\r"
		ps_label.text += str(player.velocity.y) + "\r"
		ps_label.text += PlayerValue.INSIGHT_Player_State_Movement
		ps_label.text += PlayerValue.INSIGHT_Player_State_Action
		ps_label.text += PlayerValue.INSIGHT_Player_State_Special
		ps_label.text += PlayerValue.INSIGHT_Tool_R_State
		ps_label.text += PlayerValue.INSIGHT_Tool_L_State
		ps_label.text += PlayerValue.INSIGHT_Tool_Direction_Use
		ps_label.text += PlayerValue.INSIGHT_Tool_2_Hand
	
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
		$"Control/Debug Insight/Health".visible = true
		$"Control/Debug Insight/Energy".visible = true
	else:
		$"Control/Debug Insight/Health".visible = false
		$"Control/Debug Insight/Energy".visible = false
	
	$"Control/Debug Insight/Health".value = PlayerValue.Health
	$"Control/Debug Insight/Energy".value = PlayerValue.Stamina

func Side_HUD():
	health_bar.value = PlayerValue.Health_Max - PlayerValue.Health
	if health_bar.value > PlayerValue.Health_Max:
		health_bar.self_modulate.a = 1
	elif health_bar.value < PlayerValue.Health_Max:
		health_bar.self_modulate.a = 1
	#health_bar.max_value = PlayerValue.Health_Max - PlayerValue.Health
	HUD_Visibility(hud_toolr, hud_toolr_nam, desc_toolr, "Invisible")
	HUD_Visibility(hud_tooll, hud_tooll_nam, desc_tooll, "Invisible")
	HUD_Visibility(hud_spell, hud_spell_nam, desc_spell, "Invisible")
	HUD_Visibility(hud_uitem, hud_uitem_nam, desc_uitem, "Invisible")
	
	match PlayerValue.Inv_ToolR_Equiped:
		"null":
			hud_toolr_nam.text = "Hand"
			desc_toolr.text = "Empty"
			item_selection.hudo_toolr.texture = load("uid://qua4cq3ubssm")
			cross.frame = 0
		"HandGun":
			HUD_Visibility(hud_toolr, hud_toolr_nam, desc_toolr, "Visible")
			hud_toolr_nam.text = "Gun"
			cross.frame = 1
			desc_toolr.text = str("%d/%d M: %d") % [Tool_Script.Ammo_MagA, Tool_Script.Max_Ammo_MagA, Tool_Script.MagA_Num]
		"AssaultRifle":
			HUD_Visibility(hud_toolr, hud_toolr_nam, desc_toolr, "Visible")
			hud_toolr_nam.text = "Assalt"
			cross.frame = 1
			desc_toolr.text = str("%d/%d M: %d") % [Tool_Script.Ammo_MagB, Tool_Script.Max_Ammo_MagB, Tool_Script.MagB_Num]
		"Sword":
			HUD_Visibility(hud_toolr, hud_toolr_nam, desc_toolr, "Visible")
			hud_toolr_nam.text = "Sword"
			cross.frame = 2
			desc_toolr.text = "Nothing"
		"SpecialBow":
			HUD_Visibility(hud_toolr, hud_toolr_nam, desc_toolr, "Visible")
			hud_toolr_nam.text = "Special Bow"
			cross.frame = 1
			desc_toolr.text = str("%d/%d") % [0, 0]
	
	match PlayerValue.Inv_ToolL_Equiped:
		"null":
			hud_tooll_nam.text = "Hand"
			desc_tooll.text = "Empty"
			item_selection.hudo_tooll.texture = load("uid://qua4cq3ubssm")
			#cross_hand.visible = true
		"HandGun":
			HUD_Visibility(hud_tooll, hud_tooll_nam, desc_tooll, "Visible")
			hud_tooll_nam.text = "Gun"
			#cross_gun.visible = true
			desc_tooll.text = str("%d/%d M: %d") % [Tool_Script.Ammo_MagA, Tool_Script.Max_Ammo_MagA, Tool_Script.MagA_Num]
		"AssaultRifle":
			HUD_Visibility(hud_tooll, hud_tooll_nam, desc_tooll, "Visible")
			hud_tooll_nam.text = "Assalt"
			#cross_gun.visible = true
			desc_tooll.text = str("%d/%d M: %d") % [Tool_Script.Ammo_MagB, Tool_Script.Max_Ammo_MagB, Tool_Script.MagB_Num]
		"Sword":
			HUD_Visibility(hud_tooll, hud_tooll_nam, desc_tooll, "Visible")
			hud_tooll_nam.text = "Sword"
			#cross_sword.visible = true
			desc_tooll.text = "Nothing"
		"SpecialBow":
			HUD_Visibility(hud_tooll, hud_tooll_nam, desc_tooll, "Visible")
			hud_tooll_nam.text = "Special Bow"
			#cross_gun.visible = true
			desc_tooll.text = str("%d/%d") % [0, 0]
	
	match PlayerValue.Inv_Spell_Equiped:
		"null":
			hud_spell_nam.text = "Spell"
			desc_spell.text = "Empty"
			item_selection.hudo_spell.texture = load("uid://qua4cq3ubssm")
		"PotentiaSolis":
			HUD_Visibility(hud_spell, hud_spell_nam, desc_spell, "Visible")
			hud_spell_nam.text = "Lighting"
			desc_spell.text = str("%d/%d") % [PlayerValue.Spell_ID_Get()["quantity"], PlayerValue.Spell_ID_Get()["max quantity"]]
		"Misericordia":
			HUD_Visibility(hud_spell, hud_spell_nam, desc_spell, "Visible")
			hud_spell_nam.text = "Heal"
			desc_spell.text = str("%d/%d") % [PlayerValue.Spell_ID_Get()["quantity"], PlayerValue.Spell_ID_Get()["max quantity"]]
		"Tywyll":
			HUD_Visibility(hud_spell, hud_spell_nam, desc_spell, "Visible")
			hud_spell_nam.text = "Heresy"
			desc_spell.text = str("%d/%d") % [PlayerValue.Spell_ID_Get()["quantity"], PlayerValue.Spell_ID_Get()["max quantity"]]
		"Sunfire":
			HUD_Visibility(hud_spell, hud_spell_nam, desc_spell, "Visible")
			hud_spell_nam.text = "Sunfire"
			desc_spell.text = str("%d/%d") % [PlayerValue.Spell_ID_Get()["quantity"], PlayerValue.Spell_ID_Get()["max quantity"]]


func Interact_HUD():
	Inter.visible = false
	if Tool_Script.Interact_Ray.is_colliding():
		var point_coll = Tool_Script.Interact_Ray.get_collider()
		if point_coll.has_method("CLR_info"):
			Inter.visible = true
			Inter.text = point_coll.HUD_Prompt

func UItem_HUD():
	pass
	#var UItem_ID_Got = PlayerValue.UItem_Get_ID()
	#UItem.text = UItem_ID_Got.name
	#
	#if UItem_ID_Got.name == "Glass flask":
		#UItem.text += str("\rX:%d") % UItem_ID_Got["quantity"]
		#
	#if UItem_ID_Got.name == "Wild gold":
		#UItem.text += str("\rX:%d") % UItem_ID_Got["quantity"]

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

func HUD_Visibility(Icon, Name, Description, State):
	if State == "Visible":
		Icon.self_modulate.a = 1
		Name.self_modulate.a = 1
		Description.self_modulate.a = 1
	elif State == "Invisible":
		Icon.self_modulate.a = 0.5
		Name.self_modulate.a = 0.5
		Description.self_modulate.a = 0.5
func Bars_Visibility(Bar):
	pass
