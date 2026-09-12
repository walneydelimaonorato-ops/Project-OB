extends CUS_Lever

func _ready() -> void:
	pass # Replace with function body.

func Keys_Used():
	SignalBus.emit_signal("Interaction_Manager_Request", "Object", "", CLSS_LEVER_ID, CLSS_LEVER_CALL)
	SignalBus.emit_signal("Menu_Setting", "Keys")


func beta_key_0_pressed() -> void:
	CLSS_LEVER_ID = "Beta Key 0"
	CLSS_LEVER_CALL = "Open"
	Keys_Used()
