extends Node

func _ready() -> void:
	IntSigBus.Menu_Update.connect(Menu_Update)


func Menu_Update():
	pass
