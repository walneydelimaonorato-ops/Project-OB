extends Node

func _ready() -> void:
	pass # Replace with function body.



func exit_pressed() -> void:
	SignalBus.emit_signal("Menu_Setting", "Rest")
