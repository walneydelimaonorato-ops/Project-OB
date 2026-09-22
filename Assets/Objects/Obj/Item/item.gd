extends CUS_Item_Pickup
var HUD_Prompt: String = "Pickup"

func _ready() -> void:
	Diagnose_ITEM_PICKUP()
	$"Debug View".visible = false
	$Particles.visible = true
	
	if Global.Inventory_Data[CLSS_ITEM_TYPE][CLSS_ITEM_SYS_NAME]["Model"]:
		var Model = load(Global.Inventory_Data[CLSS_ITEM_TYPE][CLSS_ITEM_SYS_NAME]["Model"])
		var Loaded_Model = Model.instantiate()
		%Models.add_child(Loaded_Model)
	else:
		$"Debug View".visible = false
	

func HUD_Element():
	return HUD_Prompt

func Interact():
	$Collision.set_collision_layer_value(3, false)
	$Particles.emitting = false
	$Models.visible = false
	
	if CLSS_ITEM_SYS_NAME != "":
		if CLSS_ITEM_TYPE in ["Key_ID", "Bundle_ID", "UItem_ID"]:
			Global.Inventory_Data[CLSS_ITEM_TYPE][CLSS_ITEM_SYS_NAME]["quantity"] += CLSS_ITEM_QUANTITY
		
		if Global.Inventory_Data[CLSS_ITEM_TYPE][CLSS_ITEM_SYS_NAME]["picked?"] == false:
			Global.Inventory_Data[CLSS_ITEM_TYPE][CLSS_ITEM_SYS_NAME]["picked?"] = true
		
		%"Pick Up".play()
	

func pick_up_finished() -> void:
	self.queue_free()
