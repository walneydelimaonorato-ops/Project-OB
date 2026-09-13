class_name CUS_Lock
extends Node

@export var CLSS_ACCEPT_KEY: String
@export var CLSS_KEY_HOLDING: String
var CLSS_KEYHOLE_FILLED: bool

func Diagnose_LOCK():
	print_rich("\r [color=#ffdf00] Lock Class Diagnosis: ")
	print_rich("[color=#ffdf00]>", "Node: ", self)
	
	if CLSS_ACCEPT_KEY == "":
		print_rich("[color=red]>", "This Lock has no assigned Key")
	else:
		print_rich("[color=green]>", "Acceptable Key: ", CLSS_ACCEPT_KEY)
	
	if CLSS_KEY_HOLDING == "":
		print_rich("[color=red]>", "Currently not holding a key")
	else:
		print_rich("[color=#ffdf00]>", "Currently holding the ", CLSS_KEY_HOLDING, " Key")
