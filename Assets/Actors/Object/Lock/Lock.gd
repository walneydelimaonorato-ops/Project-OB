extends CUS_Lock

func _ready() -> void:
	IntSigBus.Keys_Recognition.connect(Key_Authenticate)

func Interact():
	if CLSS_KEYHOLE_FILLED == false:
		IntSigBus.emit_signal("Menu_Setting", "Keys")
		IntSigBus.emit_signal("Keys_Stamping", CLSS_LOCK_STAMP)
		IntSigBus.emit_signal("MSelection_Item_Sorting")
	elif CLSS_KEYHOLE_FILLED == true:
		IntSigBus.emit_signal("Notification", "Already has a key", 5)

func Key_Authenticate(Local_Stamp: String, Key_Selected: String):
	if Local_Stamp == CLSS_LOCK_STAMP:
		if Key_Selected == CLSS_ACCEPT_KEY:
			#CLSS_HOLDING_KEY = Key_Selected
			CLSS_KEYHOLE_FILLED = true
			IntSigBus.emit_signal("Interaction_Manager_Request", "Object", "", str(CLSS_LOCK_CONNECT), "Open")
		else:
			IntSigBus.emit_signal("Notification", "Incorrect key", 1)
	else:
		pass
