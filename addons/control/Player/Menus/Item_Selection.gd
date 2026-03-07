extends Control

@onready var player_value: Node3D = $"../../../../../../../Player_Values"
@onready var ready_menu: Control = $"../Ready Menu"

@onready var tool_Sword: TextureButton = $"Tools Scroller/Tools Grid/Tools Icons/Tool_Sword_Ico"
@onready var tool_HandGun: TextureButton = $"Tools Scroller/Tools Grid/Tools Icons/Tool_HandG_Ico"
@onready var tool_AssaltRifle: TextureButton = $"Tools Scroller/Tools Grid/Tools Icons/Tool_AssaltR_Ico"

@onready var wear_1_ico: TextureButton = $"Tools Scroller/Tools Grid/Wear Icons/Wear_1_Ico"
@onready var wear_2_ico: TextureButton = $"Tools Scroller/Tools Grid/Wear Icons/wear_2_Ico"
@onready var wear_3_ico: TextureButton = $"Tools Scroller/Tools Grid/Wear Icons/wear_3_Ico"

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
			focus_first_visible($"Tools Scroller/Tools Grid/Tools Icons")
			player_value.One_Time = false
		
		$"Tools Scroller/Tools Grid/Tools Icons".visible = true
		$"Tools Scroller/Tools Grid/Tool Icons Name".visible = true
	
	elif player_value.Item_Menu_To == "Wear":
		if player_value.One_Time == true:
			$"Tools Scroller/Tools Grid/Wear Icons/Wear_1_Ico".grab_focus()
			player_value.One_Time = false
		
		$"Tools Scroller/Tools Grid/Wear Icons".visible = true
		$"Tools Scroller/Tools Grid/Wear Icons Name".visible = true
	
	elif player_value.Item_Menu_To == "Brace":
		if player_value.One_Time == true:
			$"Tools Scroller/Tools Grid/Braces Icons/Brace_Gold_Ico".grab_focus()
			player_value.One_Time = false
		
		$"Tools Scroller/Tools Grid/Braces Icons".visible = true
		$"Tools Scroller/Tools Grid/Brace Icon Name".visible = true
	
	else:
		#$"Tools Scroller/Tools Grid/Tools Icons".visible = false
		#$"Tools Scroller/Tools Grid/Tool Icons Name".visible = false
		$"Tools Scroller/Tools Grid/Wear Icons".visible = false
		$"Tools Scroller/Tools Grid/Wear Icons Name".visible = false
		$"Tools Scroller/Tools Grid/Braces Icons".visible = false
		$"Tools Scroller/Tools Grid/Brace Icon Name".visible = false

func Item_Avaliability():
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
		$"Tools Scroller/Tools Grid/Tool Icons Name/Empty Space_1".visible = true
		$"Tools Scroller/Tools Grid/Tool Icons Name/Tool_Sword_Nam".visible = true
	else:
		tool_Sword.visible = false
		$"Tools Scroller/Tools Grid/Tool Icons Name/Empty Space_1".visible = false
		$"Tools Scroller/Tools Grid/Tool Icons Name/Tool_Sword_Nam".visible = false
	if tool_HandGun_availeble == true:
		tool_HandGun.visible = true
		$"Tools Scroller/Tools Grid/Tool Icons Name/Empty Space_2".visible = true
		$"Tools Scroller/Tools Grid/Tool Icons Name/Tool_HandGun_Nam".visible = true
	else:
		tool_HandGun.visible = false
		$"Tools Scroller/Tools Grid/Tool Icons Name/Empty Space_2".visible = false
		$"Tools Scroller/Tools Grid/Tool Icons Name/Tool_HandGun_Nam".visible = false

func focus_first_visible(container):
	for child in container.get_children():
		if child is Control:
			if child.visible and child.focus_mode != Control.FOCUS_NONE:
				child.grab_focus()
				return
			focus_first_visible(child)

func _on_wear_1_ico_pressed() -> void:
	if player_value.Item_Menu_Slot == "Wear1":
		Replace_Icon($"../Ready Menu/Ready Menu Icons/Wear_Tool Grid/Wear_Icon_1", $"Tools Scroller/Tools Grid/Wear Icons/Wear_1_Ico")
	elif player_value.Item_Menu_Slot == "Wear2":
		Replace_Icon($"../Ready Menu/Ready Menu Icons/Wear_Tool Grid/Wear_Icon_2", $"Tools Scroller/Tools Grid/Wear Icons/Wear_1_Ico")
func _on_wear_2_ico_pressed() -> void:
	if player_value.Item_Menu_Slot == "Wear1":
		Replace_Icon($"../Ready Menu/Ready Menu Icons/Wear_Tool Grid/Wear_Icon_1", $"Tools Scroller/Tools Grid/Wear Icons/wear_2_Ico")
	elif player_value.Item_Menu_Slot == "Wear2":
		Replace_Icon($"../Ready Menu/Ready Menu Icons/Wear_Tool Grid/Wear_Icon_2", $"Tools Scroller/Tools Grid/Wear Icons/wear_2_Ico")
func _on_wear_3_ico_pressed() -> void:
	if player_value.Item_Menu_Slot == "Wear1":
		Replace_Icon($"../Ready Menu/Ready Menu Icons/Wear_Tool Grid/Wear_Icon_1", $"Tools Scroller/Tools Grid/Wear Icons/wear_3_Ico")
	elif player_value.Item_Menu_Slot == "Wear2":
		Replace_Icon($"../Ready Menu/Ready Menu Icons/Wear_Tool Grid/Wear_Icon_2", $"Tools Scroller/Tools Grid/Wear Icons/wear_3_Ico")

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
