class_name CUS_Item_Pickup
extends Node

@export var CLSS_ITEM_SYS_NAME: String
@export var CLSS_ITEM_QUANTITY: int = 1
@export_enum("Tool_ID", "Wear_ID", "Spell_ID", "Brace_ID", "UItem_ID", "Key_ID", "Bundle_ID") var CLSS_ITEM_TYPE: String

func Diagnose_ITEM_PICKUP():
	var Repo: String
	Repo = str("Item Pickup Class Diagnosis: ")
	Repo += str("\n>", self)
	
	if CLSS_ITEM_SYS_NAME == "":
		Repo += "\n>This Item has no assigned Item"
	else:
		Repo += str("\n>Item Name: ", CLSS_ITEM_SYS_NAME)
	
	Repo += str("\n>Item Quantity: ", CLSS_ITEM_QUANTITY)
	Repo += str("\n>Item Type: ", CLSS_ITEM_TYPE)
	Repo += str("\n>Model: ", PLY_Inventory[CLSS_ITEM_TYPE][CLSS_ITEM_SYS_NAME]["Model"])
	
	BugBus.emit_signal("Report", "Map", Repo)
