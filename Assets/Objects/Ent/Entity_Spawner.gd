extends Node

@export_enum("Test") var Entitties: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var Ent
	match Entitties:
		"Test":
			%"Debug Text".text = "Enemy set"
			Ent = load("uid://cjjbqhue88d3g").instantiate()
		_:
			%"Debug Text".text = "Entity missing"
	
	if Ent:
		self.add_child(Ent)
