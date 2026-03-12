extends Control

#@onready var PlayerValue : Node3D = $"../../../../../../../PlayerValues"
@onready var Tool_Script: Node3D = $"../../../../../../../Tool_Node"
@onready var Ready_Menu: Control = $"."

# Buttons
@onready var tecnical_slot_1: TextureButton = $"Ready Menu Grid/Tecnical Grid/Tecnical Slot 1"
@onready var tecnical_slot_2: TextureButton = $"Ready Menu Grid/Tecnical Grid/Tecnical Slot 2"

@onready var wear_slot_1: TextureButton = $"Ready Menu Grid/Wear_Tool Grid/Wear Slot 1"
@onready var wear_slot_2: TextureButton = $"Ready Menu Grid/Wear_Tool Grid/Wear Slot 2"
@onready var tool_slot_1: TextureButton = $"Ready Menu Grid/Wear_Tool Grid/Tool Slot 1"
@onready var tool_slot_2: TextureButton = $"Ready Menu Grid/Wear_Tool Grid/Tool Slot 2"

@onready var spell_slot: TextureButton = $"Ready Menu Grid/UItems_Spell Grid/Spell Slot"
@onready var u_item_slot_1: TextureButton = $"Ready Menu Grid/UItems_Spell Grid/UItem Slot 1"
@onready var u_item_slot_2: TextureButton = $"Ready Menu Grid/UItems_Spell Grid/UItem Slot 2"
@onready var u_item_slot_3: TextureButton = $"Ready Menu Grid/UItems_Spell Grid/UItem Slot 3"

# Icons
@onready var wear_icon_1: TextureRect = $"Ready Menu Icons/Wear_Tool Grid/Wear_Icon_1"
@onready var wear_icon_2: TextureRect = $"Ready Menu Icons/Wear_Tool Grid/Wear_Icon_2"
@onready var tool_icon_1: TextureRect = $"Ready Menu Icons/Wear_Tool Grid/Tool_Icon_1"
@onready var tool_icon_2: TextureRect = $"Ready Menu Icons/Wear_Tool Grid/Tool_Icon_2"

@onready var spell_icon: TextureRect = $"Ready Menu Icons/UItems_Spell Grid/Spell_Icon"
@onready var u_item_icon_1: TextureRect = $"Ready Menu Icons/UItems_Spell Grid/UItem_Icon_1"
@onready var u_item_icon_2: TextureRect = $"Ready Menu Icons/UItems_Spell Grid/UItem_Icon_2"
@onready var u_item_icon_3: TextureRect = $"Ready Menu Icons/UItems_Spell Grid/UItem_Icon_3"

var Item_Menu_To = ""
var Focused_Button = ""
var Focused_Icon = ""
var Selected_Icon = ""
var Valid_Icon_Selected = true

func _ready() -> void:
	get_viewport().gui_focus_changed.connect(on_focus_change)

func on_focus_change(control: Control) -> void:
	if control != null:
		Focused_Button = control.name
		#print("Focus changed to: ", control.name)

func _process(delta: float) -> void:
	if PlayerValue.One_Time == true and PlayerValue.Menu_Depth == 1:
		await get_tree().create_timer(0.01).timeout
		$"Ready Menu Grid/Tecnical Grid/Tecnical Slot 1".grab_focus()
		PlayerValue.One_Time = false
	if PlayerValue.Alive == true and PlayerValue.Undeath == false and PlayerValue.Menu_Depth >= 1:
		self.visible = true
		if PlayerValue.Menu_Depth == 3:
			PlayerValue.Menu_mode = true
			self.visible = false
	else:
		self.visible = false
		PlayerValue.Menu_mode = false
	
	if Input.is_action_just_pressed("ui_cancel") and PlayerValue.Menu_mode == true:
		PlayerValue.Menu_Backwards(1, 1)
		Tool_Script.Tool_Rotate() # Callsed when switching Tools

	elif Input.is_action_just_pressed("ui_select") and PlayerValue.Menu_Depth == 1:
		Remove_Item()

func Remove_Item():
	match Focused_Button:
		"Tecnical Slot 1":
			Selected_Icon = "null"
			Valid_Icon_Selected = false
		"Tecnical Slot 2":
			Selected_Icon = "null"
			Valid_Icon_Selected = false
		"Wear Slot 1":
			Selected_Icon = wear_icon_1
			PlayerValue.Ready_Menu_To_Item_Selection_Update("Brace", "null")
			Valid_Icon_Selected = true
		"Wear Slot 2":
			Selected_Icon = wear_icon_2
			PlayerValue.Ready_Menu_To_Item_Selection_Update("Wear", "null")
			Valid_Icon_Selected = true
		"Tool Slot 1":
			Selected_Icon = tool_icon_1
			PlayerValue.Ready_Menu_To_Item_Selection_Update("Tool L", "null")
			Valid_Icon_Selected = true
		"Tool Slot 2":
			Selected_Icon = tool_icon_2
			PlayerValue.Ready_Menu_To_Item_Selection_Update("Tool R", "null")
			Valid_Icon_Selected = true
		"Spell Slot":
			Selected_Icon = spell_icon
			PlayerValue.Ready_Menu_To_Item_Selection_Update("Spell", "null")
			Valid_Icon_Selected = true
		"UItem Slot 1":
			Selected_Icon = u_item_icon_1
			PlayerValue.Ready_Menu_To_Item_Selection_Update("UItem 1", "null")
			Valid_Icon_Selected = true
		"UItem Slot 2":
			Selected_Icon = u_item_icon_2
			PlayerValue.Ready_Menu_To_Item_Selection_Update("UItem 2", "null")
			Valid_Icon_Selected = true
		"UItem Slot 3":
			Selected_Icon = u_item_icon_3
			PlayerValue.Ready_Menu_To_Item_Selection_Update("UItem 3", "null")
			Valid_Icon_Selected = true
	
	if Valid_Icon_Selected == true:
		Selected_Icon.texture = load("uid://qua4cq3ubssm")
	else:
		# Item_SLot_State = "Empty"
		pass

func Pause():
	PlayerValue.Menu_Forward(0, 1, "", "")

func _on_wear_slot_1_pressed() -> void:
	PlayerValue.Menu_Forward(1, 1, "Brace", "Brace")
func _on_wear_slot_2_pressed() -> void:
	PlayerValue.Menu_Forward(1, 1, "Wear", "Wear2")
func _on_tool_slot_1_pressed() -> void:
	PlayerValue.Menu_Forward(1, 1, "Tool", "Tool1")
func _on_tool_slot_2_pressed() -> void:
	PlayerValue.Menu_Forward(1, 1, "Tool", "Tool2")
func _on_tecnical_slot_1_pressed() -> void:
	PlayerValue.Menu_Forward(1, 2, "Technical", "Technical1")
