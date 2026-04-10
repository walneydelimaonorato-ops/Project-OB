extends Node

@export_enum("TST Box (physics)", "Rest") var Objects: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var Ent
	match Objects:
		"TST Box (physics)":
			%"Debug Text".text = "TST Box (physics)"
			Ent = load("uid://xld4o8k23t48").instantiate()
		"Rest":
			%"Debug Text".text = "Rest"
			Ent = load("uid://c4p7mlvgrwsjp").instantiate()
		_:
			%"Debug Text".text = "Object missing"
	
	if Ent:
		self.add_child(Ent)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
