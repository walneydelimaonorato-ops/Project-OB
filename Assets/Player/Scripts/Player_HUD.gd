extends CanvasLayer
@onready var PlayerVars: Node = %"Player Stats"
@onready var StatsMan: Node = %"Stats Management"

@onready var Interact: RichTextLabel = %"Interact Prompt"
@onready var Health: TextureProgressBar = %Health
@onready var Stamina: TextureProgressBar = %Stamina

var Interact_Prompt: String = "General"

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	Side_HUD_Update()
	Health.max_value = PlayerVars.data.Health_Max
	Health.value = PlayerVars.data.Health
	Stamina.max_value = PlayerVars.data.Stamina_Max
	Stamina.value = PlayerVars.data.Stamina
	
func _physics_process(_delta: float) -> void:
	%"Interact Prompt".text = "[img=30]" + PlayerVars.data.UnHUDIcon_Interact + "[/img]: " + Interact_Prompt
	if %Ray2.is_colliding():
		%"Interact Prompt".visible = true
		StatsMan.Geneneral_Interaction(%Ray2, "HUD_Element")
		Interact_Prompt = StatsMan.Colidder.get_parent().HUD_Prompt
	if !%Ray2.is_colliding():
		%"Interact Prompt".visible = false

func Side_HUD_Update():
	HUD_Visibility(%"Tool R", %"Name ToolR", %"Desc ToolR", "Invisible")
	HUD_Visibility(%"Tool L", %"Name ToolL", %"Desc ToolL", "Invisible")
	HUD_Visibility(%Spell, %"Name Spell", %"Desc Spell" , "Invisible")
	HUD_Visibility(%UItem, %"Name UItem", %"Desc UItem", "Invisible")
	match PlayerVars.data.Inv_ToolR_Equiped:
		"null":
			%"Name ToolR".text = "Hand"
			%"Desc ToolR".text = "<nothing>"
	match PlayerVars.data.Inv_ToolL_Equiped:
		"null":
			%"Name ToolL".text = "Hand"
			%"Desc ToolL".text = "<nothing>"
	match PlayerVars.data.Inv_Spell_Equiped:
		"null":
			%"Name ToolR".text = "Unequipped"
			%"Desc ToolR".text = "<nothing>"

func HUD_Visibility(Icon, Name, Description, State):
	if State == "Visible":
		Icon.self_modulate.a = 1
		Name.self_modulate.a = 1
		Description.self_modulate.a = 1
	elif State == "Invisible":
		Icon.self_modulate.a = 0.5
		Name.self_modulate.a = 0.5
		Description.self_modulate.a = 0.5
