extends CUS_Lever

var HUD_Prompt: String = "Pull"

func _ready() -> void:
	Diagnose_LEVER()

func HUD_Element():
	return HUD_Prompt

func Interact():
	$"Lever Model/AnimationPlayer".play("Object_Anims_Lever_Activate")
	SignalBus.emit_signal("Interaction_Manager_Request", "Object", "", CLSS_LEVER_ID, CLSS_LEVER_CALL)
