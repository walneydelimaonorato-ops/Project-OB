extends Control

@onready var player_value: Node3D = $"../../../../../../../Player_Values"
@onready var ready_menu: Control = $"../Ready Menu"

@onready var tool_Sword: TextureButton = $"Tools Scroller/Tools Grid/Tools Icons/Tool_Sword_Ico"
@onready var tool_HandGun: TextureButton = $"Tools Scroller/Tools Grid/Tools Icons/Tool_HandG_Ico"
@onready var tool_AssaltRifle: TextureButton = $"Tools Scroller/Tools Grid/Tools Icons/Tool_AssaltR_Ico"

@onready var wear_1_ico: TextureButton = $"Tools Scroller/Tools Grid/Wear Icons/Wear_1_Ico"
@onready var wear_2_ico: TextureButton = $"Tools Scroller/Tools Grid/Wear Icons/wear_2_Ico"
@onready var wear_3_ico: TextureButton = $"Tools Scroller/Tools Grid/Wear Icons/wear_3_Ico"

func Replace_Icon(Replaced_Texture, Icon_Path):
	Replaced_Texture.texture = Icon_Path.texture_normal

func _process(delta: float) -> void:
	Item_Selection_Mode()
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
			$"Tools Scroller/Tools Grid/Tools Icons/Tool_Sword_Ico".grab_focus()
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
		$"Tools Scroller/Tools Grid/Tools Icons".visible = false
		$"Tools Scroller/Tools Grid/Tool Icons Name".visible = false
		$"Tools Scroller/Tools Grid/Wear Icons".visible = false
		$"Tools Scroller/Tools Grid/Wear Icons Name".visible = false
		$"Tools Scroller/Tools Grid/Braces Icons".visible = false
		$"Tools Scroller/Tools Grid/Brace Icon Name".visible = false

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
	elif player_value.Item_Menu_Slot == "Tool2":
		Replace_Icon(ready_menu.tool_icon_2, tool_Sword)
func _on_tool_hand_g_ico_pressed() -> void:
	if player_value.Item_Menu_Slot == "Tool1":
		Replace_Icon(ready_menu.tool_icon_1, tool_HandGun)
	elif player_value.Item_Menu_Slot == "Tool2":
		Replace_Icon(ready_menu.tool_icon_2, tool_HandGun)
func _on_tool_assalt_r_ico_pressed() -> void:
	if player_value.Item_Menu_Slot == "Tool1":
		Replace_Icon(ready_menu.tool_icon_1, tool_AssaltRifle)
	elif player_value.Item_Menu_Slot == "Tool1":
		Replace_Icon(ready_menu.tool_icon_2, tool_AssaltRifle)
