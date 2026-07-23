extends Label

func _ready() -> void:
	print_rich("[color=red]FPS Counter Working \r=========================[/color]")

func _process(delta: float) -> void:
	self.text = "FPS: %s" % Engine.get_frames_per_second()
	self.text += "\rDFPS: %s" % Engine.get_frames_drawn()
