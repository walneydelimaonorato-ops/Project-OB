extends RigidBody3D

var HUD_Prompt = "Push"

func interact(hit_pos: Vector3, dir: Vector3):
	var push_strength = 10.0
	var impulse = dir * push_strength
	apply_impulse(hit_pos - global_transform.origin, impulse)

func CLR_info():
	return HUD_Prompt
