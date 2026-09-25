extends CUS_Door

@export var HUD_Prompt: String = ""
@export var Door_State: bool = false
@export var Locked: bool = false

func _ready() -> void:
	Diagnose_DOOR()
	SignalBus.Object_Interaction.connect(Object_Interact)

func Interact():
	if Locked == false:
		SignalBus.emit_signal("Interaction_Manager_Request", "Object", "", CLSS_DOOR_MATCH, "Open")
	elif Locked == true:
		pass

func HUD_Element():
	return HUD_Prompt

func Object_Interact(LEVER_ID: String, LEVER_Call: String):
	if LEVER_ID == str(self):
		call(LEVER_Call)
	elif LEVER_ID != str(self):
		print_rich("[color=#ff00ff]MANUAL ERROR: At ", self, ". LEVER_ID: ", LEVER_ID, ". LEVER_Call: ", LEVER_Call)

func Open():
	if Door_State == false:
		Door_State = true
		$"Door Model2/AnimationPlayer".play("Object_Anims_Door_Open")

	elif Door_State == true:
		Door_State = false
		$"Door Model2/AnimationPlayer".play_backwards("Object_Anims_Door_Open")
