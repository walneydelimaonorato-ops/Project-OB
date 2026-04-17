extends Node


func _ready() -> void:
	SignalBus.connect("request_dialogue", on_request_dialogue)


func on_request_dialogue():
	pass
