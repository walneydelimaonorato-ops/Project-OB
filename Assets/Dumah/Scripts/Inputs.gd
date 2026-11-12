extends Node

func _process(delta: float) -> void:
	Inputs()

func Inputs():
	if Input.is_action_just_pressed("Deb_Quit"):
		get_tree().quit()
	if Input.is_action_pressed(PLY_Input.Un_Sprint):
		pass
		# PLY_Data.Sprinting = true
	else:
		pass
		# PLY_Data.Sprinting = fasle
	
	#match PLY_Data.Cur_Tool_Use:
		#PLY_Data.Tool_Use_List.PRIMARY:
			#if Input.is_action_just_pressed(PLY_Input.Un_RPrimary_Tool_Use):
				#IntSigBus.emit_signal("Tool_Action", true, "PRIMARY")
			#elif Input.is_action_just_pressed(PLY_Input.Un_LPrimary_Tool_Use):
				#IntSigBus.emit_signal("Tool_Action", false, "PRIMARY")
		#PLY_Data.Tool_Use_List.SECONDARY:
			#if Input.is_action_just_pressed(PLY_Input.Un_RSecondary_Tool_Use):
				#IntSigBus.emit_signal("Tool_Action", true, "SECONDARY")
			#elif Input.is_action_just_pressed(PLY_Input.Un_LSecondary_Tool_Use):
				#IntSigBus.emit_signal("Tool_Action", false, "SECONDARY")
	
	if Input.is_action_just_pressed(PLY_Input.Un_Tool_Alternive):
		IntSigBus.emit_signal("Interaction_Wait", true, 0.0)
	if Input.is_action_just_released(PLY_Input.Un_Tool_Alternive):
		IntSigBus.emit_signal("Interaction_Wait", false, 0.0)
	if Input.is_action_just_pressed(PLY_Input.Un_Use_UItem):
		return
	if Input.is_action_just_pressed(PLY_Input.Un_Cycle_UItem):
		return
	#if Input.is_action_just_pressed(PLY_Input.Un_2Hand_Toggle):
		#return
	#if Input.is_action_just_pressed(PLY_Input.Un):
		#return
