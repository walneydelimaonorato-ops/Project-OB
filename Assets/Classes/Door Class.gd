class_name CUS_Door
extends Node

@export var CLSS_DOOR_ID: String = ""
@export var CLSS_DOOR_MATCH: String = ""

func Diagnose_DOOR():
	var Repo: String
	Repo = "Door Class Diagnosis: "
	Repo += str("\n>", self)
	
	if CLSS_DOOR_ID == "":
		Repo += "\n>Has no ID"
	else:
		Repo += str("\n>ID: ", CLSS_DOOR_ID)
	
	if CLSS_DOOR_MATCH == "":
		Repo += str("\n>has no MATCH")
	else:
		Repo += str("\n>MATCH: ", CLSS_DOOR_MATCH)
	BugBus.emit_signal("Report", "Map", Repo)
