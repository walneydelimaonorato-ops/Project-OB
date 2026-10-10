extends CUS_Lever

func _ready() -> void:
	if CLSS_LEVER_MODEL:
		var Model = CLSS_LEVER_MODEL.instantiate()
		self.add_child(Model)
	
	if self.find_child("AnimationPlayer", true, false):
		CLSS_LEVER_ANIMATION = self.find_child("AnimationPlayer", true, false)
	
	Diagnose_LEVER()

func Interact():
	if CLSS_LEVER_CONNECT:
		$"Lever Model/AnimationPlayer".play("Object_Anims_Lever_Activate")
		IntSigBus.emit_signal("Interaction_Manager_Request", "Object", "", str(CLSS_LEVER_CONNECT), "Open")
