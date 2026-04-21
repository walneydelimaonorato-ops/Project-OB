extends Node3D

var Damage: int = 0

func _ready() -> void:
	SignalBus.connect("request_damage", Damage_Identifier)

func Damage_Identifier(Damage_Number):
	Damage = Damage_Number

func Take_Damage():
	print(Damage)
	
