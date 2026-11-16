extends Node

func _ready() -> void:
	IntSigBus.INT_Inventory_Update.connect(INT_Inventory_Update)

func INT_Inventory_Update(Item: String, Inventory_Slot: String = "", Hand: Variant = null):
	if Hand != null:
		match Hand:
			true: # RIGHT
				Inventory_Slot = "Inv_ToolL_Equiped"
			false: # LEFT
				Inventory_Slot = "Inv_ToolR_Equiped"
	
	PLY_Inventory[Inventory_Slot] = Item
	
	print(Inventory_Slot, " ", PLY_Inventory[Inventory_Slot])
