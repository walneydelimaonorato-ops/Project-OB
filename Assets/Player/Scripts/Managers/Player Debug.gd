extends Node

func _ready() -> void:
	if Global.Player_Data.Developer_Mode == false:
		%"Debug Tree".queue_free()
		print_rich("[color=purple]CURRENTLY RUNNING IN: RETAIL MODE")
	else:
		print_rich("[color=purple]CURRENTLY RUNNING IN: DEVELOPER MODE")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("ass")
