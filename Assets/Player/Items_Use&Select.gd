extends Node

func _ready() -> void:
	print("Items Use & Select working")
	Global.Player_Data.UItem_Cycle.connect(UItem_Cycle)
	Global.Player_Data.UItem_Use.connect(UItem_Use)
	SignalBus.connect("reply_popup", UItem_Consume_Prompt)
	
	Global.Player_Data.Tool_and_HUD_Rotation.connect(UItem_Activating)

func UItem_Cycle():
	Global.Player_Data.Cycle_Uitem_Index += 1
	Global.Player_Data.Cycle_Uitem_Index = wrapi(Global.Player_Data.Cycle_Uitem_Index, 1, 4)

func UItem_Activating():
	match Global.Player_Data.Cycle_Uitem_Index:
		1:
			Global.Player_Data.Cycle_Uitem_Active = Global.Player_Data.Inv_Uitem1_Equiped
		2:
			Global.Player_Data.Cycle_Uitem_Active = Global.Player_Data.Inv_Uitem2_Equiped
		3:
			Global.Player_Data.Cycle_Uitem_Active = Global.Player_Data.Inv_Uitem3_Equiped
	
	Global.Player_Data.emit_signal("Menus_Visual_Update", "Ready UItem 1", Global.Player_Data.UItem_ID[Global.Player_Data.Cycle_Uitem_Active]["Icon"])

func UItem_Index_Centrilizing():
	#print("Index at: ", str(Global.Player_Data.Cycle_Uitem_Index))
	
	Global.Player_Data.Cycle_Uitem_Index = wrapi(Global.Player_Data.Cycle_Uitem_Index, 1, 4)

func UItem_Use():
	match Global.Player_Data.Cycle_Uitem_Active:
		"Sigil":
			var Choice_Names = {
					"stance_text": "Forefit?",
					"yes_text": "Give Up",
					"no_text": "Stand Strong"
				}
			SignalBus.emit_signal("request_popup", Choice_Names, "Sigil use")
		"Glass Flask":
			Global.Player_Data.emit_signal("Stats_Change", "Increase", "Health", 5) #Global.Player_Data.UItem_ID["Glass Flask"]["heal_values"]

func UItem_Consume_Prompt(Choice_Answer, Address_To):
	match Address_To:
		"Sigil use":
			if Choice_Answer == "Give Up":
				Global.Next_Scene = "uid://1pdtqb482aod"
				get_tree().change_scene_to_packed(Global.Load_New)
			elif Choice_Answer == "Stand Strong":
				pass
				#print("Stand Strong")
		_:
			pass
			#print("ERROR: UItem_Consume_Prompt no matching Address_To")
