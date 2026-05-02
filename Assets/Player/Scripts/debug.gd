extends Node

@onready var player_stats: Node = $"../../../Script Nodes/Player Stats"
@onready var stats_management: Node = $"../../../Script Nodes/Stats Management"

@onready var health: TextureProgressBar = %Health
@onready var stamina: TextureProgressBar = %Stamina


@onready var debug_backdrop: PanelContainer = $"../Debug Backdrop"
@onready var page_1: Label = $"../Debug Backdrop/Page 1"
@onready var page_2: Label = $"../Debug Backdrop/Page 2"
@onready var page_3: Label = $"../Debug Backdrop/Page 3"
@onready var focus_node: Label = $"../Focus Node"

var Active: bool = false
var Page: int = 0

func _ready() -> void:
	print("Debug working \r=========================")

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
	
	
	Page = clamp(Page, 1, 3)
	
	if Active == true:
		debug_backdrop.visible = true
	elif Active == false:
		debug_backdrop.visible = false
	
	match Page:
		1:
			page_1.visible = true
			page_2.visible = false
			page_3.visible = false
		2:
			page_1.visible = false
			page_2.visible = true
			page_3.visible = false
		3:
			page_1.visible = false
			page_2.visible = false
			page_3.visible = true
	
	page_1.text = "TST Vars"
	page_1.text += str("\rStamina_Regeneration_Active: ", player_stats.data.Stamina_Regeneration_Active)
	#page_1.text += str("\rNULL" + )
	
	page_2.text = "HUD Vars"
	page_2.text += str("\rControl_Mode: " + player_stats.data.Control_Mode)
	page_2.text += str("\rHealth_Max: %d") % player_stats.data.Health_Max
	page_2.text += str(" // Stamina_Max: %d") % player_stats.data.Stamina_Max
	page_2.text += "\rHealth: %d" % player_stats.data.Health
	page_2.text += "\rStamina: %.2f" % player_stats.data.Stamina
	page_2.text += str("\rBar_Health: %d") % health.value
	page_2.text += str("\rBar_Stamina: %d") % stamina.value
	
	page_3.text = "Menu Vars"
	page_3.text += str("\rCurrent_Menu: " + player_stats.data.Current_Menu)
	page_3.text += str("\rCurrent_SubMenu: " + player_stats.data.Current_SubMenu)
	page_3.text += str("\rReady_Menu_Active: ", player_stats.data.Ready_Menu_Active)
	
	page_3.text += "\r........."
	page_3.text += str("\rInv_Brace: ", player_stats.data.Inv_Brace_Equiped)
	page_3.text += str("\rInv_Wear: ", player_stats.data.Inv_Wear_Equiped)
	page_3.text += str("\rInv_ToolL: ", player_stats.data.Inv_ToolL_Equiped)
	page_3.text += str("\rInv_ToolR: ", player_stats.data.Inv_ToolR_Equiped)
	page_3.text += str("\rInv_Spell: ", player_stats.data.Inv_Spell_Equiped)
	page_3.text += str("\rInv_Uitem1: ", player_stats.data.Inv_Uitem1_Equiped)
	page_3.text += str("\rInv_Uitem2: ", player_stats.data.Inv_Uitem2_Equiped)
	page_3.text += str("\rInv_Uitem3: ", player_stats.data.Inv_Uitem3_Equiped)
	
	focus_node.text = player_stats.data.Current_Focus
