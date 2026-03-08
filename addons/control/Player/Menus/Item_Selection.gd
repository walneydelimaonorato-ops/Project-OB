extends Control

@onready var player_value: Node3D = $"../../../../../../../Player_Values"
@onready var ready_menu: Control = $"../Ready Menu"

@onready var tool_list_ico: VBoxContainer = $"Tools Scroller/Tools Grid/Tools Icons"
@onready var tool_list_nam: VBoxContainer = $"Tools Scroller/Tools Grid/Tool Icons Name"
@onready var wear_list_ico: VBoxContainer = $"Tools Scroller/Tools Grid/Wear Icons"
@onready var wear_list_nam: VBoxContainer = $"Tools Scroller/Tools Grid/Wear Icons Name"
@onready var brace_list_ico: VBoxContainer = $"Tools Scroller/Tools Grid/Braces Icons"
@onready var brace_list_nam: VBoxContainer = $"Tools Scroller/Tools Grid/Brace Icon Name"

@onready var tool_Sword: TextureButton = $"Tools Scroller/Tools Grid/Tools Icons/Tool_Sword_Ico"
@onready var tool_Sword_name: MarginContainer = $"Tools Scroller/Tools Grid/Tool Icons Name/Tool Sword"

@onready var tool_HandGun: TextureButton = $"Tools Scroller/Tools Grid/Tools Icons/Tool_HandG_Ico"
@onready var tool_HandGun_name: MarginContainer = $"Tools Scroller/Tools Grid/Tool Icons Name/Tool HandGun"

@onready var tool_AssaltRifle: TextureButton = $"Tools Scroller/Tools Grid/Tools Icons/Tool_AssaltR_Ico"
@onready var tool_AssaltRifle_name: MarginContainer = $"Tools Scroller/Tools Grid/Tool Icons Name/Tool AssaltRifle"

@onready var wear_1_ico: TextureButton = $"Tools Scroller/Tools Grid/Wear Icons/Wear_1_Ico"
@onready var wear_2_ico: TextureButton = $"Tools Scroller/Tools Grid/Wear Icons/wear_2_Ico"

@onready var brace_gold_ico: TextureButton = $"Tools Scroller/Tools Grid/Braces Icons/Brace_Gold_Ico"
@onready var brace_cling_ico: TextureButton = $"Tools Scroller/Tools Grid/Braces Icons/Brace_Cling_Ico"
@onready var brace_clorophyl_ico: TextureButton = $"Tools Scroller/Tools Grid/Braces Icons/Brace_Clorophyl_Ico"
@onready var brace_fortune_ico: TextureButton = $"Tools Scroller/Tools Grid/Braces Icons/Brace_Fortune_Ico"
@onready var brace_power_ico: TextureButton = $"Tools Scroller/Tools Grid/Braces Icons/Brace_Power_Ico"
@onready var brace_rotten_ico: TextureButton = $"Tools Scroller/Tools Grid/Braces Icons/Brace_Rotten_Ico"


var tool_Sword_availeble = true
var tool_HandGun_availeble = true
var tool_AssaltRifle_availeble = true

var wear_1_availeble = true
var wear_2_availeble = true
var wear_3_availeble = true

func Replace_Icon(Replaced_Texture, Icon_Path):
	Replaced_Texture.texture = Icon_Path.texture_normal

func _process(delta: float) -> void:
	Item_Selection_Mode()
	Item_Avaliability()
	
	$Label.text = player_value.Item_Menu_Slot
	if player_value.Alive == true and player_value.Undeath == false and player_value.Menu_Depth == 2:
		self.visible = true
	else:
		self.visible = false
	
	if Input.is_action_just_pressed("ui_cancel"):
		player_value.Menu_Backwards(2)

func Item_Selection_Mode():
	if player_value.Item_Menu_To == "Tool":
		if player_value.One_Time == true:
			focus_first_visible(tool_list_ico)
			player_value.One_Time = false
		tool_list_ico.visible = true
		tool_list_nam.visible = true
	
	elif player_value.Item_Menu_To != "Tool":
		tool_list_ico.visible = false
		tool_list_nam.visible = false
	
	
	if player_value.Item_Menu_To == "Wear":
		if player_value.One_Time == true:
			focus_first_visible(wear_list_ico)
			player_value.One_Time = false
		wear_list_ico.visible = true
		wear_list_nam.visible = true
	
	elif player_value.Item_Menu_To != "Wear":
		wear_list_ico.visible = false
		wear_list_nam.visible = false
	
	if player_value.Item_Menu_To == "Brace":
		if player_value.One_Time == true:
			focus_first_visible(brace_list_ico)
			player_value.One_Time = false
		brace_list_ico.visible = true
		brace_list_nam.visible = true
	
	elif player_value.Item_Menu_To != "Brace":
		brace_list_ico.visible = false
		brace_list_nam.visible = false

func Item_Avaliability():
	if player_value.Inv_Wear_Equiped == "null":
		pass
	
	if player_value.Inv_ToolR_Equiped == "null" or player_value.Inv_ToolL_Equiped == "null":
		pass
	
	if player_value.Inv_ToolR_Equiped == "Hand gun" or player_value.Inv_ToolL_Equiped == "Hand gun":
		tool_HandGun_availeble = false
	else:
		tool_HandGun_availeble = true
	if player_value.Inv_ToolR_Equiped == "Assalt rifle" or  player_value.Inv_ToolL_Equiped == "Assalt rifle":
		tool_AssaltRifle_availeble = false
	else:
		tool_AssaltRifle_availeble = true
	if player_value.Inv_ToolR_Equiped == "Sword" or  player_value.Inv_ToolL_Equiped == "Sword":
		tool_Sword_availeble = false
	else:
		tool_Sword_availeble = true
	
	if tool_Sword_availeble == true:
		tool_Sword.visible = true
		tool_Sword_name.visible = true
	else:
		tool_Sword.visible = false
		tool_Sword_name.visible = false
	if tool_HandGun_availeble == true:
		tool_HandGun.visible = true
		tool_HandGun_name.visible = true
	else:
		tool_HandGun.visible = false
		tool_HandGun_name.visible = false
	if tool_AssaltRifle_availeble == true:
		tool_AssaltRifle.visible = true
		tool_AssaltRifle_name.visible = true
	else:
		tool_AssaltRifle.visible = false
		tool_AssaltRifle_name.visible = false

func focus_first_visible(container):
	for child in container.get_children():
		if child is Control:
			if child.visible and child.focus_mode != Control.FOCUS_NONE:
				child.grab_focus()
				return
			focus_first_visible(child)


func _on_wear_1_ico_pressed() -> void:
	if player_value.Item_Menu_Slot == "Wear2":
		Replace_Icon(ready_menu.wear_icon_2, wear_1_ico)
		player_value.Ready_Menu_To_Item_Selection_Update("Wear", "Upper Mewclad Arm.")
func _on_wear_2_ico_pressed() -> void:
	if player_value.Item_Menu_Slot == "Wear2":
		Replace_Icon(ready_menu.wear_icon_2, wear_2_ico)
		player_value.Ready_Menu_To_Item_Selection_Update("Wear", "Lower Mewclad Arm.")


func _on_tool_sword_ico_pressed() -> void:
	if player_value.Item_Menu_Slot == "Tool1":
		Replace_Icon(ready_menu.tool_icon_1, tool_Sword)
		player_value.Ready_Menu_To_Item_Selection_Update("Tool L", "Sword")
	elif player_value.Item_Menu_Slot == "Tool2":
		Replace_Icon(ready_menu.tool_icon_2, tool_Sword)
		player_value.Ready_Menu_To_Item_Selection_Update("Tool R", "Sword")
	player_value.Menu_Backwards(2)
func _on_tool_hand_g_ico_pressed() -> void:
	if player_value.Item_Menu_Slot == "Tool1":
		Replace_Icon(ready_menu.tool_icon_1, tool_HandGun)
		player_value.Ready_Menu_To_Item_Selection_Update("Tool L", "Hand gun")
	elif player_value.Item_Menu_Slot == "Tool2":
		Replace_Icon(ready_menu.tool_icon_2, tool_HandGun)
		player_value.Ready_Menu_To_Item_Selection_Update("Tool R", "Hand gun")
	player_value.Menu_Backwards(2)
func _on_tool_assalt_r_ico_pressed() -> void:
	if player_value.Item_Menu_Slot == "Tool1":
		Replace_Icon(ready_menu.tool_icon_1, tool_AssaltRifle)
		player_value.Ready_Menu_To_Item_Selection_Update("Tool L", "Assalt rifle")
	elif player_value.Item_Menu_Slot == "Tool2":
		Replace_Icon(ready_menu.tool_icon_2, tool_AssaltRifle)
		player_value.Ready_Menu_To_Item_Selection_Update("Tool R", "Assalt rifle")
	player_value.Menu_Backwards(2)


func _on_brace_gold_ico_pressed() -> void:
	if player_value.Item_Menu_Slot == "Brace":
		Replace_Icon(ready_menu.wear_icon_1, brace_gold_ico)
		player_value.Ready_Menu_To_Item_Selection_Update("Brace", "Golden Bra.")
func _on_brace_cling_ico_pressed() -> void:
	if player_value.Item_Menu_Slot == "Brace":
		Replace_Icon(ready_menu.wear_icon_1, brace_cling_ico)
		player_value.Ready_Menu_To_Item_Selection_Update("Brace", "Cling Bra.")
func _on_brace_clorophyl_ico_pressed() -> void:
	if player_value.Item_Menu_Slot == "Brace":
		Replace_Icon(ready_menu.wear_icon_1, brace_clorophyl_ico)
		player_value.Ready_Menu_To_Item_Selection_Update("Brace", "Clorophyl Bra.")
func _on_brace_fortune_ico_pressed() -> void:
	if player_value.Item_Menu_Slot == "Brace":
		Replace_Icon(ready_menu.wear_icon_1, brace_fortune_ico)
		player_value.Ready_Menu_To_Item_Selection_Update("Brace", "Fortune Bra.")
func _on_brace_power_ico_pressed() -> void:
	if player_value.Item_Menu_Slot == "Brace":
		Replace_Icon(ready_menu.wear_icon_1, brace_power_ico)
		player_value.Ready_Menu_To_Item_Selection_Update("Brace", "Power Bra.")
func _on_brace_rotten_ico_pressed() -> void:
	if player_value.Item_Menu_Slot == "Brace":
		Replace_Icon(ready_menu.wear_icon_1, brace_rotten_ico)
		player_value.Ready_Menu_To_Item_Selection_Update("Brace", "Rotten Bra.")
