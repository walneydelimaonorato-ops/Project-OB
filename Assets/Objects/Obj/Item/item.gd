extends CUS_Item_Pickup
var HUD_Prompt: String = "Pickup"

func _ready() -> void:
	Diagnose_ITEM_PICKUP()
	$"Debug View".visible = false
	$Particles.visible = true
	
	%Models.add_child(load(Global.Inventory_Data[CLSS_ITEM_TYPE][CLSS_ITEM_SYS_NAME]["Model"]).instantiate())

func HUD_Element():
	return HUD_Prompt

func Interact():
	Global.Inventory_Data[CLSS_ITEM_TYPE][CLSS_ITEM_SYS_NAME]["picked?"] = true
	
	if CLSS_ITEM_TYPE in ["Key_ID", "Bundle_ID", "UItem_ID"]:
		Global.Inventory_Data[CLSS_ITEM_TYPE][CLSS_ITEM_SYS_NAME]["quantity"] += CLSS_ITEM_QUANTITY
	
	%"Pick Up".play()
	$Collision.set_collision_layer_value(3, false)
	$Particles.emitting = false
	$Models.visible = false

func pick_up_finished() -> void:
	self.queue_free()
