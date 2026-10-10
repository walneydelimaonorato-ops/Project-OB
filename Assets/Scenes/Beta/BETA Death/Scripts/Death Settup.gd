extends Control

func _ready() -> void:
	#Input.start_joy_vibration(0, 1.0, 1.0, 1.0)
	ExtSigBus.emit_signal("Viggnette", true)

func _process(delta: float) -> void:
	Input.start_joy_vibration(0, 1.0, 1.0, 1.0)
