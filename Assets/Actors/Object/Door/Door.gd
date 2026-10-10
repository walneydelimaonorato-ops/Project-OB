extends CUS_Door

@export var Door_State: bool = false
@export var Locked: bool = false

func _ready() -> void:
	Diagnose_DOOR()
	IntSigBus.Object_Interaction.connect(Object_Interact)

func Interact():
	if Locked == false:
		IntSigBus.emit_signal("Interaction_Manager_Request", "Object", "", str(self), "Open")
	elif Locked == true:
		pass

func Object_Interact(STAMP: String, Call: String):
	if STAMP == str(self):
		call(Call)
	#elif STAMP != str(self):
		#print_rich("[color=#ff00ff]MANUAL ERROR: At ", self, ". LEVER_ID: ", LEVER_ID, ". LEVER_Call: ", LEVER_Call)

func Open():
	if Door_State == false:
		Door_State = true
		$"Door Model2/AnimationPlayer".play("Object_Anims_Door_Open")

	else:
		Door_State = false
		$"Door Model2/AnimationPlayer".play_backwards("Object_Anims_Door_Open")
