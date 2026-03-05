extends Node3D

@onready var item_coll: CollisionShape3D = $"item coll"

@onready var Tool_Script: Node3D = $"../Player/Tool_Node"
@onready var item_text: Label3D = $"item float text"
#@onready var HUD = $"../Player/Head/CanvasLayer/face/GUI"

@export_group("Item Type")
#@export var Special_Item_Type : bool = false
@export var IT_MagA : bool = false
@export var MagA_Refill : int = 0
@export var IT_AmmoA : bool = false
@export var AmmoA_Refill : int = 0

var ItemName = "load fail"
var HUD_Prompt = "Pickup"

func _process(_delta: float) -> void:
	if global.Gdebug_active == true:
		$"item float text".visible = true
		$"item mesh".visible = true
	if global.Gdebug_active == false:
		$"item float text".visible = false
		$"item mesh".visible = false
	item_info()
	item_text.text = ItemName

func item_info():
	if IT_AmmoA == true:
		ItemName = str("Ammo: %d") % [AmmoA_Refill]
		$Pebbles.visible = true
	elif IT_MagA == true:
		ItemName = str("Mag: %d") % [MagA_Refill]
		$Magazine.visible = true
	else:
		ItemName = ":3"

func interact(hit_pos: Vector3, dir: Vector3):
	visible = false
	item_coll.disabled = true
	$Interact.play()
	#interact_sfx.play()
	if IT_MagA == true:
		Tool_Script.MagA_Num += MagA_Refill
	elif IT_AmmoA == true:
		Tool_Script.Ammo_MagA += AmmoA_Refill

func CLR_info():
	return HUD_Prompt
