extends Node

@onready var player_stats: Node = $"../../../Script Nodes/Player Stats"
@onready var health: TextureProgressBar = %Health
@onready var stamina: TextureProgressBar = %Stamina


@onready var debug_backdrop: PanelContainer = $"../Debug Backdrop"
@onready var page_1: Label = $"../Debug Backdrop/Page 1"
@onready var page_2: Label = $"../Debug Backdrop/Page 2"

var Active: bool = false
var Page: int = 0

func _ready() -> void:
	print("Debug working")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Deb_Toggle"):
		Active = not Active
	if Input.is_action_just_pressed("Deb_Increase"):
		Page += 1
	if Input.is_action_just_pressed("Deb_Decrease"):
		Page -= 1
	if Input.is_action_just_pressed("Deb_Quit"):
		get_tree().quit()
	
	
	Page = clamp(Page, 1, 2)
	
	if Active == true:
		debug_backdrop.visible = true
	elif Active == false:
		debug_backdrop.visible = false
	
	match Page:
		1:
			page_1.visible = true
			page_2.visible = false
		2:
			page_1.visible = false
			page_2.visible = true
	
	page_1.text = "TST Vars"
	page_1.text += str("\rStamina_Regeneration_Active: ", player_stats.Stamina_Regeneration_Active)
	#page_1.text += str("\rNULL" + )
	
	page_2.text = "HUD Vars"
	page_2.text += str("\rControl_Mode: " + player_stats.Control_Mode)
	page_2.text += str("\rHealth_Max: %d") % player_stats.Health_Max
	page_2.text += str(" // Stamina_Max: %d") % player_stats.Stamina_Max
	page_2.text += "\rHealth: %d" % player_stats.Health
	page_2.text += "\rStamina: %.2f" % player_stats.Stamina
	page_2.text += str("\rBar_Health: %d") % health.value
	page_2.text += str("\rBar_Stamina: %d") % stamina.value
