class_name Object_Interaction_Relationship
extends Node

@export_category(">Object Interaction Fundementals")
@export var CLSS_OIR_ID: String = ""

@export var CLSS_OIR_Outcome_A: String = ""
@export var CLSS_OIR_Outcome_B: String = ""
@export var CLSS_OIR_Outcome_C: String = ""


func Diagnostic():
	if CLSS_OIR_ID == "":
		print(self, " has no ID")
	else:
		print(self, " ID is: ", CLSS_OIR_ID)

func Class_Call(To_Call):
	if self.has_method(To_Call):
		call(To_Call)
	else:
		print(self, " has no ", To_Call)
