extends Control

#@onready var PlayerValue: Node3D = $"../../../../../../../PlayerValues"
@onready var ready_menu: Control = $"../Ready Menu"
@onready var Tool_Script: Node3D = $"../../../../../../../Tool_Node"

@onready var hudo_toolr: TextureRect = $"../../HUD/Side HUD Overlay/HUDO_ToolR"
@onready var hudo_tooll: TextureRect = $"../../HUD/Side HUD Overlay/HUDO_ToolL"
@onready var hudo_spell: TextureRect = $"../../HUD/Side HUD Overlay/HUDO_Spell"





@onready var tool_list_ico: VBoxContainer = $"Tools Scroller/Tools Grid/Tools Icons"
@onready var tool_list_nam: VBoxContainer = $"Tools Scroller/Tools Grid/Tool Icons Name"
@onready var wear_list_ico: VBoxContainer = $"Tools Scroller/Tools Grid/Wear Icons"
@onready var wear_list_nam: VBoxContainer = $"Tools Scroller/Tools Grid/Wear Icons Name"
@onready var brace_list_ico: VBoxContainer = $"Tools Scroller/Tools Grid/Braces Icons"
@onready var brace_list_nam: VBoxContainer = $"Tools Scroller/Tools Grid/Brace Icon Name"
@onready var spell_list_ico: VBoxContainer = $"Tools Scroller/Tools Grid/Spell Icons"
@onready var spell_list_nam: VBoxContainer = $"Tools Scroller/Tools Grid/Spell Icon Name"

@onready var tool_Sword: TextureButton = $"Tools Scroller/Tools Grid/Tools Icons/Tool_Sword_Ico"
@onready var tool_Sword_name: MarginContainer = $"Tools Scroller/Tools Grid/Tool Icons Name/Tool Sword"

@onready var tool_HandGun: TextureButton = $"Tools Scroller/Tools Grid/Tools Icons/Tool_HandG_Ico"
@onready var tool_HandGun_name: MarginContainer = $"Tools Scroller/Tools Grid/Tool Icons Name/Tool HandGun"

@onready var tool_AssaltRifle: TextureButton = $"Tools Scroller/Tools Grid/Tools Icons/Tool_AssaltR_Ico"
@onready var tool_AssaltRifle_name: MarginContainer = $"Tools Scroller/Tools Grid/Tool Icons Name/Tool AssaltRifle"

@onready var tool_Bow: TextureButton = $"Tools Scroller/Tools Grid/Tools Icons/Tool_Bow_Ico"
@onready var tool_Bow_name: MarginContainer = $"Tools Scroller/Tools Grid/Tool Icons Name/Tool Bow"

@onready var wear_1_ico: TextureButton = $"Tools Scroller/Tools Grid/Wear Icons/Wear_1_Ico"
@onready var wear_1_name: MarginContainer = $"Tools Scroller/Tools Grid/Wear Icons Name/Wear 1"

@onready var wear_2_ico: TextureButton = $"Tools Scroller/Tools Grid/Wear Icons/wear_2_Ico"
@onready var wear_2_name: MarginContainer = $"Tools Scroller/Tools Grid/Wear Icons Name/Wear 2"

@onready var brace_golden_ico: TextureButton = $"Tools Scroller/Tools Grid/Braces Icons/Brace_Gold_Ico"
@onready var brace_golden_name: MarginContainer = $"Tools Scroller/Tools Grid/Brace Icon Name/Golden"

@onready var brace_cling_ico: TextureButton = $"Tools Scroller/Tools Grid/Braces Icons/Brace_Cling_Ico"
@onready var brace_cling_name: MarginContainer = $"Tools Scroller/Tools Grid/Brace Icon Name/Cling"

@onready var brace_clorophyl_ico: TextureButton = $"Tools Scroller/Tools Grid/Braces Icons/Brace_Clorophyl_Ico"
@onready var brace_clorophyl_name: MarginContainer = $"Tools Scroller/Tools Grid/Brace Icon Name/Clorophyl"

@onready var brace_fortune_ico: TextureButton = $"Tools Scroller/Tools Grid/Braces Icons/Brace_Fortune_Ico"
@onready var brace_fortune_name: MarginContainer = $"Tools Scroller/Tools Grid/Brace Icon Name/Fortune"

@onready var brace_power_ico: TextureButton = $"Tools Scroller/Tools Grid/Braces Icons/Brace_Power_Ico"
@onready var brace_power_name: MarginContainer = $"Tools Scroller/Tools Grid/Brace Icon Name/Power"

@onready var brace_rotten_ico: TextureButton = $"Tools Scroller/Tools Grid/Braces Icons/Brace_Rotten_Ico"
@onready var brace_rotten_name: MarginContainer = $"Tools Scroller/Tools Grid/Brace Icon Name/Rotten"

@onready var spell_pts_ico: TextureButton = $"Tools Scroller/Tools Grid/Spell Icons/Spell_PTS"
@onready var spell_pts_name: MarginContainer = $"Tools Scroller/Tools Grid/Spell Icon Name/Spell PTS"

@onready var spell_mrc_ico: TextureButton = $"Tools Scroller/Tools Grid/Spell Icons/Spell_MRC"
@onready var spell_mrc_name: MarginContainer = $"Tools Scroller/Tools Grid/Spell Icon Name/Spell MRC"

@onready var spell_twl_ico: TextureButton = $"Tools Scroller/Tools Grid/Spell Icons/Spell_TWL"
@onready var spell_twl_name: MarginContainer = $"Tools Scroller/Tools Grid/Spell Icon Name/Spell TWL"

@onready var spell_sfr_ico: TextureButton = $"Tools Scroller/Tools Grid/Spell Icons/Spell_SFR"
@onready var spell_sfr_name: MarginContainer = $"Tools Scroller/Tools Grid/Spell Icon Name/Spell SFR"


var tool_Sword_availeble = true
var tool_HandGun_availeble = true
var tool_AssaltRifle_availeble = true

var wear_1_availeble = true
var wear_2_availeble = true
var wear_3_availeble = true


func Replace_Icon(Replaced_Texture, Icon_Path):
	Replaced_Texture.texture = Icon_Path.texture_normal

func Update_Side_Hud(Replaced_Texture, Hud_Path):
	Hud_Path.texture = Replaced_Texture.texture_normal

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	Item_Selection_Mode()
	Item_Avaliability()
	
	$Label.text = PlayerValue.Item_Menu_Slot
	if PlayerValue.Alive == true and PlayerValue.Undeath == false and PlayerValue.Menu_Depth == 2:
		self.visible = true
	else:
		self.visible = false
	
	if Input.is_action_just_pressed("ui_cancel"):
		PlayerValue.Menu_Backwards(2, 1)

func Item_Selection_Mode():
	if PlayerValue.Item_Menu_To == "Tool":
		if PlayerValue.One_Time == true:
			focus_first_visible(tool_list_ico)
			PlayerValue.One_Time = false
		tool_list_ico.visible = true
		tool_list_nam.visible = true
	
	elif PlayerValue.Item_Menu_To != "Tool":
		tool_list_ico.visible = false
		tool_list_nam.visible = false
	
	if PlayerValue.Item_Menu_To == "Wear":
		if PlayerValue.One_Time == true:
			focus_first_visible(wear_list_ico)
			PlayerValue.One_Time = false
		wear_list_ico.visible = true
		wear_list_nam.visible = true
	
	elif PlayerValue.Item_Menu_To != "Wear":
		wear_list_ico.visible = false
		wear_list_nam.visible = false
	
	if PlayerValue.Item_Menu_To == "Brace":
		if PlayerValue.One_Time == true:
			focus_first_visible(brace_list_ico)
			PlayerValue.One_Time = false
		brace_list_ico.visible = true
		brace_list_nam.visible = true
	
	elif PlayerValue.Item_Menu_To != "Brace":
		brace_list_ico.visible = false
		brace_list_nam.visible = false
	
	if PlayerValue.Item_Menu_To == "Spell":
		if PlayerValue.One_Time == true:
			focus_first_visible(spell_list_ico)
			PlayerValue.One_Time = false
		spell_list_ico.visible = true
		spell_list_nam.visible = true
	
	elif PlayerValue.Item_Menu_To != "Spell":
		spell_list_ico.visible = false
		spell_list_nam.visible = false

func Item_Avaliability():
	var Tool_UI = {
		"Sword": [tool_Sword, tool_Sword_name],
		"HandGun": [tool_HandGun, tool_HandGun_name],
		"AssaultRifle": [tool_AssaltRifle, tool_AssaltRifle_name],
		"SpecialBow": [tool_Bow, tool_Bow_name],
		
		"Upper Mewclad Arm.": [wear_1_ico, wear_1_name],
		"Lower Mewclad Arm.": [wear_2_ico, wear_2_name],
		
		"Golden Bra.": [brace_golden_ico, brace_golden_name],
		"Brace Bra.": [brace_cling_ico, brace_cling_name],
		"Clorophyl Bra.": [brace_clorophyl_ico, brace_clorophyl_name],
		"Fortune Bra.": [brace_fortune_ico, brace_fortune_name],
		"Power Bra.": [brace_power_ico, brace_power_name],
		"Rotten Bra.": [brace_rotten_ico, brace_rotten_name]
		
		
	}
	var equipped = [
		PlayerValue.Inv_ToolR_Equiped,
		PlayerValue.Inv_ToolL_Equiped,
		PlayerValue.Inv_Wear_Equiped,
		PlayerValue.Inv_Brace_Equiped
	]
	
	for item_name in Tool_UI:
		var available = not item_name in equipped
		
		var nodes = Tool_UI[item_name]
		
		nodes[0].visible = available
		nodes[1].visible = available

func focus_first_visible(container):
	for child in container.get_children():
		if child is Control:
			if child.visible and child.focus_mode != Control.FOCUS_NONE:
				child.grab_focus()
				return
			focus_first_visible(child)


func _on_wear_1_ico_pressed() -> void:
	if PlayerValue.Item_Menu_Slot == "Wear2":
		Replace_Icon(ready_menu.wear_icon_2, wear_1_ico)
		PlayerValue.Ready_Menu_To_Item_Selection_Update("Wear", "Upper Mewclad Arm.")
		PlayerValue.Menu_Backwards(2, 1)
func _on_wear_2_ico_pressed() -> void:
	if PlayerValue.Item_Menu_Slot == "Wear2":
		Replace_Icon(ready_menu.wear_icon_2, wear_2_ico)
		PlayerValue.Ready_Menu_To_Item_Selection_Update("Wear", "Lower Mewclad Arm.")
		PlayerValue.Menu_Backwards(2, 1)

func _on_tool_sword_ico_pressed() -> void:
	if PlayerValue.Item_Menu_Slot == "Tool1":
		Replace_Icon(ready_menu.tool_icon_1, tool_Sword)
		Update_Side_Hud(tool_Sword, hudo_tooll)
		PlayerValue.Ready_Menu_To_Item_Selection_Update("Tool L", "Sword")
	elif PlayerValue.Item_Menu_Slot == "Tool2":
		Replace_Icon(ready_menu.tool_icon_2, tool_Sword)
		Update_Side_Hud(tool_Sword, hudo_toolr)
		PlayerValue.Ready_Menu_To_Item_Selection_Update("Tool R", "Sword")
	PlayerValue.Menu_Backwards(2, 1)
	Tool_Script.Tool_Rotate() # Callsed when switching Tools
func _on_tool_hand_g_ico_pressed() -> void:
	if PlayerValue.Item_Menu_Slot == "Tool1":
		Replace_Icon(ready_menu.tool_icon_1, tool_HandGun)
		Update_Side_Hud(tool_HandGun, hudo_tooll)
		PlayerValue.Ready_Menu_To_Item_Selection_Update("Tool L", "HandGun")
	elif PlayerValue.Item_Menu_Slot == "Tool2":
		Replace_Icon(ready_menu.tool_icon_2, tool_HandGun)
		Update_Side_Hud(tool_HandGun, hudo_toolr)
		PlayerValue.Ready_Menu_To_Item_Selection_Update("Tool R", "HandGun")
	PlayerValue.Menu_Backwards(2, 1)
	Tool_Script.Tool_Rotate() # Callsed when switching Tools
func _on_tool_assalt_r_ico_pressed() -> void:
	if PlayerValue.Item_Menu_Slot == "Tool1":
		Replace_Icon(ready_menu.tool_icon_1, tool_AssaltRifle)
		Update_Side_Hud(tool_AssaltRifle, hudo_tooll)
		PlayerValue.Ready_Menu_To_Item_Selection_Update("Tool L", "AssaultRifle")
	elif PlayerValue.Item_Menu_Slot == "Tool2":
		Replace_Icon(ready_menu.tool_icon_2, tool_AssaltRifle)
		Update_Side_Hud(tool_AssaltRifle, hudo_toolr)
		PlayerValue.Ready_Menu_To_Item_Selection_Update("Tool R", "AssaultRifle")
	PlayerValue.Menu_Backwards(2, 1)
	Tool_Script.Tool_Rotate()
func _on_tool_bow_ico_pressed() -> void:
	if PlayerValue.Item_Menu_Slot == "Tool1":
		Replace_Icon(ready_menu.tool_icon_1, tool_Bow)
		Update_Side_Hud(tool_Bow, hudo_tooll)
		PlayerValue.Ready_Menu_To_Item_Selection_Update("Tool L", "SpecialBow")
	elif PlayerValue.Item_Menu_Slot == "Tool2":
		Replace_Icon(ready_menu.tool_icon_2, tool_Bow)
		Update_Side_Hud(tool_Bow, hudo_toolr)
		PlayerValue.Ready_Menu_To_Item_Selection_Update("Tool R", "SpecialBow")
	PlayerValue.Menu_Backwards(2, 1)
	Tool_Script.Tool_Rotate()

func _on_brace_gold_ico_pressed() -> void:
	if PlayerValue.Item_Menu_Slot == "Brace":
		Replace_Icon(ready_menu.wear_icon_1, brace_golden_ico)
		PlayerValue.Ready_Menu_To_Item_Selection_Update("Brace", "Golden Bra.")
		PlayerValue.Menu_Backwards(2, 1)
func _on_brace_cling_ico_pressed() -> void:
	if PlayerValue.Item_Menu_Slot == "Brace":
		Replace_Icon(ready_menu.wear_icon_1, brace_cling_ico)
		PlayerValue.Ready_Menu_To_Item_Selection_Update("Brace", "Cling Bra.")
		PlayerValue.Menu_Backwards(2, 1)
func _on_brace_clorophyl_ico_pressed() -> void:
	if PlayerValue.Item_Menu_Slot == "Brace":
		Replace_Icon(ready_menu.wear_icon_1, brace_clorophyl_ico)
		PlayerValue.Ready_Menu_To_Item_Selection_Update("Brace", "Clorophyl Bra.")
		PlayerValue.Menu_Backwards(2, 1)
func _on_brace_fortune_ico_pressed() -> void:
	if PlayerValue.Item_Menu_Slot == "Brace":
		Replace_Icon(ready_menu.wear_icon_1, brace_fortune_ico)
		PlayerValue.Ready_Menu_To_Item_Selection_Update("Brace", "Fortune Bra.")
		PlayerValue.Menu_Backwards(2, 1)
func _on_brace_power_ico_pressed() -> void:
	if PlayerValue.Item_Menu_Slot == "Brace":
		Replace_Icon(ready_menu.wear_icon_1, brace_power_ico)
		PlayerValue.Ready_Menu_To_Item_Selection_Update("Brace", "Power Bra.")
		PlayerValue.Menu_Backwards(2, 1)
func _on_brace_rotten_ico_pressed() -> void:
	if PlayerValue.Item_Menu_Slot == "Brace":
		Replace_Icon(ready_menu.wear_icon_1, brace_rotten_ico)
		PlayerValue.Ready_Menu_To_Item_Selection_Update("Brace", "Rotten Bra.")
		PlayerValue.Menu_Backwards(2, 1)

func _on_spell_pts_pressed() -> void:
	if PlayerValue.Item_Menu_Slot == "Spell":
		Replace_Icon(ready_menu.spell_icon, spell_pts_ico)
		Update_Side_Hud(spell_pts_ico, hudo_spell)
		PlayerValue.Ready_Menu_To_Item_Selection_Update("Spell", "PotentiaSolis")
		PlayerValue.Menu_Backwards(2, 1)
func _on_spell_mrc_pressed() -> void:
	if PlayerValue.Item_Menu_Slot == "Spell":
		Replace_Icon(ready_menu.spell_icon, spell_mrc_ico)
		Update_Side_Hud(spell_mrc_ico, hudo_spell)
		PlayerValue.Ready_Menu_To_Item_Selection_Update("Spell", "Misericordia")
		PlayerValue.Menu_Backwards(2, 1)
func _on_spell_twl_pressed() -> void:
	if PlayerValue.Item_Menu_Slot == "Spell":
		Replace_Icon(ready_menu.spell_icon, spell_twl_ico)
		Update_Side_Hud(spell_twl_ico, hudo_spell)
		PlayerValue.Ready_Menu_To_Item_Selection_Update("Spell", "Tywyll")
		PlayerValue.Menu_Backwards(2, 1)
