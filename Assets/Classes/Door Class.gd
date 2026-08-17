class_name CUS_Door
extends Node

@export var CLSS_DOOR_ID: String = ""
@export var CLSS_DOOR_MATCH: String = ""

func Diagnose_DOOR():
	print_rich("[color=#ffdf00] Door Class Diagnosis: ")
	
	if CLSS_DOOR_ID == "":
		print_rich("[color=#ffdf00]>", self, " has no ID")
	else:
		print_rich("[color=#ffdf00]>", self, " ID: ", CLSS_DOOR_ID)
	
	if CLSS_DOOR_MATCH == "":
		print_rich("[color=#ffdf00]>", self, " has no MATCH")
	else:
		print_rich("[color=#ffdf00]>", self, " MATCH: ", CLSS_DOOR_MATCH)
