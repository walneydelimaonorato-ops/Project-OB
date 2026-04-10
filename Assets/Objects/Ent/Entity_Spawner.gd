extends Node

@export_enum("Enemy") var Entitties: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var Ent
	match Entitties:
		"Enemy":
			%"Debug Text".text = "Enemy set"
			Ent = load("filepath").instantiate()
		_:
			%"Debug Text".text = "Entity missing"
	
	if Ent:
		self.add_child(Ent)
