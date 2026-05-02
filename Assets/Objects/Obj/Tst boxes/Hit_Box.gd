extends Area3D

var base_damage: int = 5

func hurtbox_area_entered(area: Area3D) -> void:
	SignalBus.emit_signal("player_stat_change", "Health", base_damage)
