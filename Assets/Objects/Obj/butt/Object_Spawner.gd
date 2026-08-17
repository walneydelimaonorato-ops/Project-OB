extends Node

@export_enum("TST Box", "Rest", "Item") var Objects: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%"Debug View".visible = false
	var Ent
	match Objects:
		"TST Box":
			%"Debug Text".text = "TST Box"
			Ent = load("uid://u0tbg3q3cv3q").instantiate()
		"Rest":
			%"Debug Text".text = "Rest"
			Ent = load("uid://c4p7mlvgrwsjp").instantiate()
		"Item":
			%"Debug Text".text = "Item"
			Ent = load("uid://dt014w4ctcem5").instantiate()
		_:
			%"Debug Text".text = "Object missing"
	
	if Ent:
		self.add_child(Ent)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
