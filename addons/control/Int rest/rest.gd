extends Node3D

#@onready var PlayerValue: Node3D = $"../Player/PlayerValues"
@onready var rest_coll: CollisionShape3D = $"Interact rest coll"

@onready var HUD = $"../Player/Head/CanvasLayer/face/GUI"

var Respaw_Position : Vector3
var HUD_Prompt = "Rest"

func _ready() -> void:
	$"Rest particles".emitting = true

func _process(delta: float) -> void:
	if global.Gdebug_active == true:
		$"Rest Model".visible = true
		$"Rest particles".emitting = false
		$"Rest light".visible = false
	else:
		$"Rest Model".visible = false
		$"Rest particles".emitting = true
		$"Rest light".visible = true

func interact(hit_pos: Vector3, dir: Vector3):
	$Interact.play()
	global.G_Respwan_Coords = $"../Player".position
	HUD.inter_prompt = HUD_Prompt
	PlayerValue.Stamina = PlayerValue.Stamina_Max
	PlayerValue.Heal("Full", 0)
	PlayerValue.UItem_ID[1]["quantity"] = PlayerValue.Glass_flask_quantity_max

func CLR_info():
	return HUD_Prompt
