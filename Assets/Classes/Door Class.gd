class_name CUS_Door
extends Node

@export var HUD_Prompt: String = "Open"
@export var CLSS_DOOR_MODEL: PackedScene

var CLSS_DOOR_ANIMATION: AnimationPlayer
#@export var CLSS_DOOR_ID: String = ""
#@export var CLSS_DOOR_MATCH: String = ""


func Diagnose_DOOR():
	var Repo: String
	Repo = "Door Class Diagnosis: "
	Repo += str("\n>", self)
	
	if CLSS_DOOR_MODEL:
		Repo += str("\n>Has model")
	else:
		Repo += str("\n>Has no model")
	
	if CLSS_DOOR_ANIMATION == null:
		Repo += str("\n>Missing animation node")
	else:
		Repo += str("\n>Has Animation")
	
	BugBus.emit_signal("Report", "Map", Repo)
	#if CLSS_DOOR_ID == "":
		#Repo += "\n>Has no ID"
	#else:
		#Repo += str("\n>ID: ", CLSS_DOOR_ID)
	#
	#if CLSS_DOOR_MATCH == "":
		#Repo += str("\n>has no MATCH")
	#else:
		#Repo += str("\n>MATCH: ", CLSS_DOOR_MATCH)

func HUD_Element():
	return HUD_Prompt
