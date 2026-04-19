extends CanvasLayer
@onready var PlayerRes: Node = %"Player Stats"
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
	Health.max_value = PlayerRes.data.Health_Max
	Health.value = PlayerRes.data.Health
	Stamina.max_value = PlayerRes.data.Stamina_Max
	Stamina.value = PlayerRes.data.Stamina
	
func _physics_process(_delta: float) -> void:
	%"Interact Prompt".text = "[img=30]" + PlayerRes.data.UnHUDIcon_Interact + "[/img]: " + Interact_Prompt
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
	match PlayerRes.data.Inv_ToolR_Equiped:
		"nuhhhhhll":
			%"Name ToolR".text = "Unequipped"
			%"Desc ToolR".text = "<nothing>"
		"HandGun":
			HUD_Visibility(%"Tool R", %"Name ToolR", %"Desc ToolR", "Visible")
			%"Name ToolR".text = "i be on the hillsfucken fuken dudes" #PlayerRes.data.Tool_ID["HandGun"]["dys name"]
			%"Desc ToolR".text = "tasty souep"
	match PlayerRes.data.Inv_ToolL_Equiped:
		"null":
			%"Name ToolL".text = "Unequipped"
			%"Desc ToolL".text = "<nothing>"
	match PlayerRes.data.Inv_Spell_Equiped:
		"null":
			%"Name ToolL".text = "Unequipped"
			%"Desc ToolL".text = "<nothing>"

func HUD_Visibility(Icon, Name, Description, State):
	if State == "Visible":
		Icon.self_modulate.a = 1
		Name.self_modulate.a = 1
		Description.self_modulate.a = 1
	elif State == "Invisible":
		Icon.self_modulate.a = 0.5
		Name.self_modulate.a = 0.5
		Description.self_modulate.a = 0.5
