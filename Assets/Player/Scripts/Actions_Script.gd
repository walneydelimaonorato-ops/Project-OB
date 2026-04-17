extends Node
@onready var PlayerRes: Node = %"Player Stats"
@onready var StatsMan: Node = %"Stats Management"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Player Action working")

func Action_Alternative():
	StatsMan.Geneneral_Interaction (%Ray2, "Iteraction")

func Action_Primary(Direction):
	match Direction:
		"Right":
			match PlayerRes.data.Inv_ToolR_Equiped:
				pass
		"Left":
			match PlayerRes.data.Inv_ToolL_Equiped:
				pass
