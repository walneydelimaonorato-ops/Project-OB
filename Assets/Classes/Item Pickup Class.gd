class_name CUS_Item_Pickup
extends Node

@export var CLSS_ITEM_SYS_NAME: String
@export var CLSS_ITEM_QUANTITY: int = 1
@export_enum("Tool_ID", "Wear_ID", "Spell_ID", "Brace_ID", "UItem_ID", "Key_ID", "Bundle_ID") var CLSS_ITEM_TYPE: String

func Diagnose_ITEM_PICKUP():
	print_rich("[color=#ffdf00] Door Class Diagnosis: ")
	
	if CLSS_ITEM_SYS_NAME == "":
		print_rich("[color=#ffdf00]>", self, " has no assigned Item")
	else:
		print_rich("[color=#ffdf00]>", self, " Item Name: ", CLSS_ITEM_SYS_NAME)
	
	print_rich("[color=#ffdf00]>", "Item Quantity: ", CLSS_ITEM_QUANTITY)
	print_rich("[color=#ffdf00]>", "Item Type: ", CLSS_ITEM_TYPE)
