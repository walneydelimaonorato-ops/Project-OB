extends Node3D


func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("In_Jump"):
		var image = get_viewport().get_texture().get_image()
		image.save_png("user://Undeath_Shot_D.png")
