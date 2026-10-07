extends Node

func _ready() -> void:
	BugBus.emit_signal("Report", "Player", "Items Use & Select Working")
	SignalBus.UItem_Cycle.connect(UItem_Cycle)
	SignalBus.UItem_Use.connect(UItem_Use)
	SignalBus.connect("reply_popup", UItem_Consume_Prompt)
	
	SignalBus.Tool_Rotation.connect(UItem_Activating)
	
	

func UItem_Cycle():
	PLY_Inventory.Cycle_Uitem_Index += 1
	PLY_Inventory.Cycle_Uitem_Index = wrapi(PLY_Inventory.Cycle_Uitem_Index, 1, 4)
	UItem_Activating()

func UItem_Activating():
	match PLY_Inventory.Cycle_Uitem_Index:
		1:
			PLY_Inventory.Cycle_Uitem_Active = PLY_Inventory.Inv_Uitem1_Equiped
		2:
			PLY_Inventory.Cycle_Uitem_Active = PLY_Inventory.Inv_Uitem2_Equiped
		3:
			PLY_Inventory.Cycle_Uitem_Active = PLY_Inventory.Inv_Uitem3_Equiped
	
	SignalBus.emit_signal("Side_HUD_Overlay_Update")
	SignalBus.emit_signal("Side_HUD_Update")

func UItem_Index_Centrilizing():
	#print("Index at: ", str(GLOBAL.Player_Data.Cycle_Uitem_Index))
	
	PLY_Inventory.Cycle_Uitem_Index = wrapi(PLY_Inventory.Cycle_Uitem_Index, 1, 4)

func UItem_Use():
	match PLY_Inventory.Cycle_Uitem_Active:
		"Sigil":
			var Choice_Names = {
					"stance_text": "Forefit?",
					"yes_text": "Give Up",
					"no_text": "Stand Strong"
				}
			SignalBus.emit_signal("request_popup", Choice_Names, "Sigil use")
		"Glass Flask":
			SignalBus.emit_signal("LOC_Value_Operator", true, "Health", GLOBAL.InventoryData.UItem_ID["Glass Flask"]["heal_value"])

func UItem_Consume_Prompt(Choice_Answer, Address_To):
	match Address_To:
		"Sigil use":
			if Choice_Answer == "Give Up":
				GLOBAL.Next_Scene = "uid://1pdtqb482aod"
				get_tree().change_scene_to_packed(GLOBAL.Load_New)
			elif Choice_Answer == "Stand Strong":
				pass
				#print("Stand Strong")
		_:
			pass
			#print("ERROR: UItem_Consume_Prompt no matching Address_To")
