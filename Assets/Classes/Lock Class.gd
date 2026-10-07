class_name CUS_Lock
extends Node

@export var HUD_Prompt: String = "Interact"

@export var CLSS_ACCEPT_KEY: String
@export var CLSS_KEY_HOLDING: String

@export var CLSS_UNLOCKS: Node3D

var CLSS_KEYHOLE_FILLED: bool

func _ready() -> void:
	Diagnose_LOCK()

func Diagnose_LOCK():
	var Repo: String
	Repo = "Lock Class Diagnosis:"
	Repo += str("\n>", self)
	
	if CLSS_ACCEPT_KEY == "":
		Repo += "\n>This Lock has no assigned Key"
	else:
		Repo += str("\n>Acceptable Key: ", CLSS_ACCEPT_KEY)
	
	if CLSS_KEY_HOLDING == "":
		Repo += str("\n>Currently not holding a key")
	else:
		Repo += str("\n>Currently holding the ", CLSS_KEY_HOLDING, " Key")
	
	BugBus.emit_signal("Report", "Map", Repo)

func HUD_Element():
	return HUD_Prompt
