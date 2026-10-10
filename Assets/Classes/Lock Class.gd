class_name CUS_Lock
extends Node

@export var HUD_Prompt: String = "Interact"

@export var CLSS_ACCEPT_KEY: String
@export var CLSS_HOLDING_KEY: bool

@export var CLSS_LOCK_CONNECT: Node3D

var CLSS_LOCK_STAMP: String = str(self)
var CLSS_KEYHOLE_FILLED: bool

func Diagnose_LOCK():
	
	var Repo: String
	Repo = "Lock Class Diagnosis:"
	Repo += str("\n>", self)
	
	if CLSS_ACCEPT_KEY:
		Repo += "\n>This Lock has no assigned Key"
	else:
		Repo += str("\n>Acceptable Key: ", CLSS_ACCEPT_KEY)
	
	if CLSS_HOLDING_KEY == false:
		Repo += str("\n>Currently not holding a key")
	else:
		Repo += str("\n>Currently holding the ", CLSS_ACCEPT_KEY, " Key")
	
	Repo += "\n "
	BugBus.emit_signal("Report", "Map", Repo)

func HUD_Element():
	return HUD_Prompt
