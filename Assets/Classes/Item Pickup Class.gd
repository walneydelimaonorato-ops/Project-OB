class_name CUS_Item_Pickup
extends Node

@export var CLSS_ITEM_SYS_NAME: String
@export var CLSS_ITEM_QUANTITY: int = 1
@export_enum("Tool_ID", "Wear_ID", "Spell_ID", "Brace_ID", "UItem_ID", "Key_ID", "Bundle_ID") var CLSS_ITEM_TYPE: String

func Diagnose_ITEM_PICKUP():
	print_rich("\r [color=#ffdf00] Item Pickup Class Diagnosis: ")
	print_rich("[color=#ffdf00]>", "Node: ", self)
	
	if CLSS_ITEM_SYS_NAME == "":
		print_rich("[color=red]>", "This Item has no assigned Item")
	else:
		print_rich("[color=GREEN]>", "Item Name: ", CLSS_ITEM_SYS_NAME)
	
	print_rich("[color=#ffdf00]>", "Item Quantity: ", CLSS_ITEM_QUANTITY)
	print_rich("[color=#ffdf00]>", "Item Type: ", CLSS_ITEM_TYPE)
	print_rich("[color=#ffdf00]>", "Model: ", Global.Inventory_Data[CLSS_ITEM_TYPE][CLSS_ITEM_SYS_NAME]["Model"])
