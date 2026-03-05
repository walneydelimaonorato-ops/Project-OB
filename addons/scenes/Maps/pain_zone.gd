extends MeshInstance3D

@onready var player_values: Node3D = $"../Player/Player_Values"

@export var Damage = 0

func _on_area_3d_body_entered(body: Node3D) -> void:
	player_values.Stats_decrease("Health", Damage)
