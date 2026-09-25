@tool
extends Node3D

@export var Cam_X_Rot: float = 0
@export var Cam_Y_Rot: float = 0
@export var Cam_Y_Pos : float = 0
@export var Cam_Distance: float = 2

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		self.rotation.x = Cam_X_Rot
		self.rotation.y = Cam_Y_Rot 
		self.position.y = Cam_Y_Pos
		%"Rest Camera".position.z = Cam_Distance
