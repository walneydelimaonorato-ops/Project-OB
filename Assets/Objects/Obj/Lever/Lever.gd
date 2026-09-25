extends CUS_Lever

func _ready() -> void:
	Diagnose_LEVER()

func Interact():
	print(CLSS_LEVER_CONNECT)
	$"Lever Model/AnimationPlayer".play("Object_Anims_Lever_Activate")
	SignalBus.emit_signal("Interaction_Manager_Request", "Object", "", CLSS_LEVER_ID, CLSS_LEVER_CALL)
