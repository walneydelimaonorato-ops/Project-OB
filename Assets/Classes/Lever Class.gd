class_name CUS_Lever
extends Node

@export var HUD_Prompt: String = "Pull"
@export var CLSS_CAN_PULL: bool = true

@export var CLSS_LEVER_CONNECT: Node3D
@export var CLSS_LEVER_MODEL: PackedScene

var CLSS_LEVER_ANIMATION: AnimationPlayer

#@export var CLSS_LEVER_ID: String = ""
#@export var CLSS_LEVER_CALL: String = ""
#@export var CLSS_LEVER_CONNECT: Node3D

func Diagnose_LEVER():
	var Repo: String
	Repo = "Lever Class Diagnosis:"
	Repo += str("\n>", self)
	
	if CLSS_LEVER_CONNECT:
		Repo += str("\n>Connected to ", CLSS_LEVER_CONNECT.name)
	else:
		Repo += str("\n>Has no connection")
	
	if CLSS_LEVER_MODEL:
		Repo += str("\n>Has model")
	else:
		Repo += str("\n>Has no model")
	
	if CLSS_LEVER_ANIMATION == null:
		Repo += str("\n>Missing animation node")
	else:
		Repo += str("\n>Has Animation")
	
	#if CLSS_LEVER_ID == "":				Repo += str("\n>")
		#Repo += "\n>Has no ID"
	#else:
		#Repo += str("\n>ID: ", CLSS_LEVER_ID)
	#
	#if CLSS_LEVER_CALL == "":
		#Repo += str("\n>has no Call")
	#else:
		#Repo += str("\n>Call: ", CLSS_LEVER_CALL)
	
	BugBus.emit_signal("Report", "Map", Repo)
	
func HUD_Element():
	return HUD_Prompt
