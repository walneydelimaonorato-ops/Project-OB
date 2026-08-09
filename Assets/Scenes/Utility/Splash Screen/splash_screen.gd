extends Node2D
var i: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	i += 1
	$Label.text = str(i)
	if i > 120:
		Load_Game()
	

func Load_Game():
	get_tree().change_scene_to_file("uid://1pdtqb482aod")
