extends Node

@onready var Equipment_Sorter: Control = %"Equipment Sorter"
@onready var Equipment_Selector: Control = %"Equipment Selector"

@onready var Tab_Name: Label = %"Tab Name"
@onready var Equipment_Tab: TabContainer = %"Equipment Tab"

@onready var To_Fix_Buttons: Array = [%Buttons, %"Equipment List", %Tools, %Braces, %Wear, %Spell, %UItems]

#@onready var Menus_Minor: Array[Control] = [Equipment_Sorter, Equipment_Selector]#, Equipment_Tab]
#@onready var Major_Menus: Array[Control] = [%Rest]
#@onready var All_Menus: Array[Array] = [Menus_Minor, Major_Menus]

func _ready() -> void:
	IntSigBus.Menu_Update.connect(Menu_Movement)
	Button_Path_Fix(To_Fix_Buttons)
	
	PLY_Data.MRest = %Rest
	
	PLY_Data.Menus_Minor = [Equipment_Sorter, Equipment_Selector]#, Equipment_Tab]
	PLY_Data.Menus_Major = [%Rest]
	PLY_Data.Menus_All = [PLY_Data.Menus_Minor, PLY_Data.Menus_Major]

#func _input(event: InputEvent) -> void:
	#if Input.is_action_just_pressed(PLY_Input.Un_Ready_Menu):
		#Menu_Movement($"../../Menus/Rest/Buttons")

func Button_Path_Fix(Path: Array, Index_Mod: int = 0):
	var Index = Index_Mod
	var Localized = Path.get(Index)
	var Index_Lim = Path.size()
	
	for node: Control in Localized.get_children():
		if node is Button or node is TextureButton:
			node.focus_neighbor_left = get_path_to(node)
			node.focus_neighbor_right = get_path_to(node)
	if Index < Index_Lim - 1:
		Index += 1
		Button_Path_Fix(Path, Index)

func Menu_Movement(Menu_Node: Control = null, Minor: bool = true, Major: bool = true, All: bool = true):
	if Minor == true:
		for CNTRL: Control in PLY_Data.Menus_Minor:
			CNTRL.visible = false
	if Major == true:
		for CNTRL: Control in PLY_Data.Menus_Major:
			CNTRL.visible = false
	if All == true:
		for Child: Array in PLY_Data.Menus_All:
			for CNTRL in Child:
				CNTRL.visible = false
	
	if Menu_Node:
		Menu_Node.visible = true
		GLOBAL.Focus(Menu_Node)

#region Rest
func Transport() -> void:
	pass
func Equipment() -> void:
	pass
	IntSigBus.emit_signal("Menu_Update", Equipment_Sorter, false, false, false)
	#Menu_Movement(Equipment_Sorter)
func Inventory() -> void:
	pass # Replace with function body.
func Settings() -> void:
	pass # Replace with function body.
func Leave() -> void:
	IntSigBus.emit_signal("Menu_Update")
#endregion

#region Equipment Sorter
func RHand() -> void:
	Equipment_Tab.current_tab = 0
	PLY_Data.Equipment_Selector_Index = -2
	Menu_Movement(Equipment_Selector, false, false, false)
	GLOBAL.Focus(%Tools)
	Tab_Name.text = "RIGHT HAND"
func LHand() -> void:
	Equipment_Tab.current_tab = 0
	PLY_Data.Equipment_Selector_Index = -1
	Menu_Movement(Equipment_Selector, false, false, false)
	GLOBAL.Focus(%Tools)
	Tab_Name.text = "LEFT HAND"
func Braces() -> void:
	Equipment_Tab.current_tab = 1
	PLY_Data.Equipment_Selector_Index = 0
	Menu_Movement(Equipment_Selector, false, false, false)
	GLOBAL.Focus(%Braces)
	Tab_Name.text = "BRACES"
func Armor() -> void:
	Equipment_Tab.current_tab = 2
	PLY_Data.Equipment_Selector_Index = 0
	Menu_Movement(Equipment_Selector, false, false, false)
	GLOBAL.Focus(%Wear)
	Tab_Name.text = "WEAR"
func Spell() -> void:
	Equipment_Tab.current_tab = 3
	PLY_Data.Equipment_Selector_Index = 0
	Menu_Movement(Equipment_Selector, false, false, false)
	GLOBAL.Focus(%Spell)
	Tab_Name.text = "SPELLS"
func UItem1() -> void:
	Equipment_Tab.current_tab = 4
	PLY_Data.Equipment_Selector_Index = 1
	Menu_Movement(Equipment_Selector, false, false, false)
	GLOBAL.Focus(%UItems)
	Tab_Name.text = "CONSUMABLES A"
func UItem2() -> void:
	Equipment_Tab.current_tab = 4
	PLY_Data.Equipment_Selector_Index = 2
	Menu_Movement(Equipment_Selector, false, false, false)
	GLOBAL.Focus(%UItems)
	Tab_Name.text = "CONSUMABLES B"
func UItem3() -> void:
	Equipment_Tab.current_tab = 4
	PLY_Data.Equipment_Selector_Index = 3
	Menu_Movement(Equipment_Selector, false, false, false)
	GLOBAL.Focus(%UItems)
	Tab_Name.text = "CONSUMABLES C"
#endregion
