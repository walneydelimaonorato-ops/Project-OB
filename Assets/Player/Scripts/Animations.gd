extends Node

@onready var general_animations: AnimationPlayer = $"../General Animations"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Player Animations Working")
	SignalBus.Player_Animations.connect(Play_Animation)


func Play_Animation(Animation_Name):
	general_animations.play(Animation_Name)
