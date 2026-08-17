class_name CUS_Lever
extends Node

@export var CLSS_LEVER_ID: String = ""
@export var CLSS_LEVER_CALL: String = ""

func Diagnose_LEVER():
	print_rich("[color=#ffdf00] Lever Class Diagnosis:") 
	if CLSS_LEVER_ID == "":
		print_rich("[color=#ffdf00]>", self, " has no ID")
	else:
		print_rich("[color=#ffdf00]>", self, " ID: ", CLSS_LEVER_ID)
	
	if CLSS_LEVER_CALL == "":
		print_rich("[color=#ffdf00]>", self, " has no Call")
	else:
		print_rich("[color=#ffdf00]>", self, " Call: ", CLSS_LEVER_CALL)
