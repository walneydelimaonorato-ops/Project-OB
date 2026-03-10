extends CharacterBody3D

@onready var Enemy_Anim : AnimatedSprite3D = $Visuals/Enemy
@onready var NPC_Anim: AnimatedSprite3D = $Visuals/NPC

@onready var entity_colision: CollisionShape3D = $entity_colision
@onready var player_value: Node3D = $"../../../../Player/Player_Values"

@export_group("Entity Type")
@export var En_Type = 0     #0: Friendly NPC. 1: Hostile Enemy
@export_group("Entity Configuration")
@export var Health_Multiplier = 1

var Entity_Type = ""
var Entity_Health = 10

func Entity_Handler():
	pass

func _ready() -> void:
	if En_Type == 0:
		NPC_Anim.visible = true
		Entity_Type = "NPC"
		NPC_Anim.play("NPC_idle")
	elif En_Type == 1:
		Enemy_Anim.visible = true
		Entity_Type = "Enemy"
		Enemy_Anim.play("enemy_idle")
	
	Entity_Health *= Health_Multiplier

func _process(_delta: float) -> void:
	
	# Debug section
	#if Entity_Type == "Enemy":
		#$"entity_colision/Debug vis".albedo_color = Color(1.0, 0.0, 0.0, 0.588)
	#elif Entity_Type == "NPC":
		#$"entity_colision/Debug vis".albedo_color = Color(0.0, 1.0, 0.0, 0.588)
	$"Debug Insight".text = str("HP: %d") % [Entity_Health]
	$"Debug Insight".text += "\rEntity type: " + Entity_Type
	if global.Gdebug_active == true:
		$"Debug Insight".visible = true
		$"entity_colision/Debug vis".visible = true
	else:
		$"Debug Insight".visible = false
		$"entity_colision/Debug vis".visible = false

func damage():
	if Entity_Type == "Enemy":
		#await get_tree().create_timer(2.0).timeout
		Entity_Health -= player_value.Tool_Get_ID()["damage"] + player_value.Damage_Bonus
	
		if Entity_Health <= 0:
			Enemy_Anim.play("enemy_dead")
			$"Entity SFX/Enemy defeat".play()
			entity_colision.disabled = true
	var emit_request_id = 0
	emit_request_id += 1
	var id = emit_request_id
	$Bleed.emitting = true
	await get_tree().create_timer(0.2).timeout
	if id == emit_request_id:
		$Bleed.emitting = false
