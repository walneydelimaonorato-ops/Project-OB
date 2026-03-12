extends MeshInstance3D

#@onready var PlayerValues: Node3D = $"../Player/PlayerValues"

@export var Damage = 0

func _on_area_3d_body_entered(body: Node3D) -> void:
	PlayerValue.Stats_decrease("Health", Damage)
