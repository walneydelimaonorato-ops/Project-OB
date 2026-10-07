extends CUS_Lock
var Stamp: String

func _ready() -> void:
	Stamp = str(self)
	SignalBus.Keys_Recognition.connect(Key_Authenticate)

func Interact():
	if CLSS_KEYHOLE_FILLED == false:
		SignalBus.emit_signal("Menu_Setting", "Keys")
		SignalBus.emit_signal("Keys_Stamping", Stamp)
		SignalBus.emit_signal("MSelection_Item_Sorting")
	elif CLSS_KEYHOLE_FILLED == true:
		SignalBus.emit_signal("Notification", "Already has a key", 5)

func Key_Authenticate(Local_Stamp: String, Key_Selected: String):
	if Local_Stamp == Stamp:
		if Key_Selected == CLSS_ACCEPT_KEY:
			CLSS_KEY_HOLDING = Key_Selected
			CLSS_KEYHOLE_FILLED = true
			SignalBus.emit_signal("Interaction_Manager_Request", "Object", "", CLSS_ACCEPT_KEY, "Open")
		elif Key_Selected in ["", CLSS_ACCEPT_KEY]:
			SignalBus.emit_signal("Notification", "Incorrect key", 1)
	else:
		pass
