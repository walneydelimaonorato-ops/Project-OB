extends Node
#========================= 
func _ready() -> void:
	print_rich("[color=red]GLOBAL")

#var Player_Data: PlayerData = preload("res://Assets/Data/Player Data Main.tres").duplicate()
#var Inventory_Data: InventoryData = preload("res://Assets/Data/Inventory Data.tres").duplicate()

var Dialogue = preload("res://Assets/Dialogue/Dialogue.gd")

var Load_New = preload("uid://bjx42pmeq3smb")
var Next_Scene = Map.List["Main Menu"]

func Focus(container):
	for child in container.get_children():
		if child is Control:
			if child.visible and child.focus_mode != Control.FOCUS_NONE:
				child.grab_focus()
				return
			Focus(child)
