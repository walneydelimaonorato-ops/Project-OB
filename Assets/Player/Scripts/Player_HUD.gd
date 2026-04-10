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
	Health.max_value = PlayerVars.data.Health_Max
	Health.value = PlayerVars.data.Health
	Stamina.max_value = PlayerVars.data.Stamina_Max
	Stamina.value = PlayerVars.data.Stamina
	
func _physics_process(delta: float) -> void:
	%"Interact Prompt".text = "[img=30]" + PlayerVars.data.UnHUDIcon_Interact + "[/img]: " + Interact_Prompt
	if %Ray2.is_colliding():
		%"Interact Prompt".visible = true
		StatsMan.Geneneral_Interaction(%Ray2, "HUD_Element")
		Interact_Prompt = StatsMan.Colidder.get_parent().HUD_Prompt
	if !%Ray2.is_colliding():
		%"Interact Prompt".visible = false
