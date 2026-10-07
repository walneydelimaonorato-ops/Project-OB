class_name CUS_NPC
extends CharacterBody3D

@export var NPC_Hostile: bool
@export var NPC_Model: PackedScene
@export var NPC_Library: String

@export var NPC_Health_Mod: int = 0
@export var NPC_AI_LVL: int = 1

enum NPC_State {IDLE, WANDER, CHASE}
var NPC_Wait_Count: bool
var NPC_Wait_Time: int

var NPC_Health: int = 20

func _ready() -> void:
	NPC_Health += NPC_Health_Mod + (NPC_AI_LVL * 2)
	
	NPC_Diagnostic()

func NPC_Diagnostic():
	var Report: String
	Report = str("==========NPC <", self, "> diagnostics")
	Report += str("\rModel: ", NPC_Model.name)
	
	if NPC_Hostile == true:
		Report += "\rHostile"
	elif NPC_Hostile == false:
		Report += "\rFriendly"
	
	Report += str("\rLibrary: ", NPC_Library)
	Report += str("\rAI Level: ", NPC_AI_LVL)
	
	
	
	
