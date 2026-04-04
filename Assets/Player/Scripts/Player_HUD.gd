extends CanvasLayer
@onready var PlayerRes: Node = %"Player Stats"

@onready var Interact: RichTextLabel = %"Interact Prompt"
@onready var Health: TextureProgressBar = %Health
@onready var Stamina: TextureProgressBar = %Stamina

func _ready() -> void:
	match PlayerRes.Control_Mode:
		"Key":
			PlayerRes.UnHUDIcon_Up = "uid://bceq01ccemc8o"
			PlayerRes.UnHUDIcon_Down = "uid://duiy16ed7ovil"
			PlayerRes.UnHUDIcon_Left = "uid://beqbo453gynf1"
			PlayerRes.UnHUDIcon_Right = "uid://cwgfmbtf38n10"
			PlayerRes.UnHUDIcon_Accept = "uid://0cjin76csgan"
			PlayerRes.UnHUDIcon_Return = "uid://d12fq4lnqjl7a"
			PlayerRes.UnHUDIcon_Unselect = "uid://06v660kr4rts"
			PlayerRes.UnHUDIcon_Interact = "uid://b1k76ih5cvb32"
		"Joy":
			PlayerRes.UnHUDIcon_Up = "uid://bumwv083liw5g"
			PlayerRes.UnHUDIcon_Down = "uid://dtmfxjgftvudj"
			PlayerRes.UnHUDIcon_Left = "uid://ovx7jbm3tdnl"
			PlayerRes.UnHUDIcon_Right = "uid://8p350oejc5ln"
			PlayerRes.UnHUDIcon_Accept = "uid://ctvxynwec6rsy"
			PlayerRes.UnHUDIcon_Return = "uid://pnd0l1xdxt3x"
			PlayerRes.UnHUDIcon_Unselect = "uid://sdcs6qj0qc6x"
			PlayerRes.UnHUDIcon_Interact = "uid://sdcs6qj0qc6x"
	
	Interact.text = "[img=30]" + PlayerRes.UnHUDIcon_Interact + "[/img]: Interact"
	#Interact.text = "[img=30]" + PlayerRes.UnHUDIcon_Accept + "[/img]: Select // [img=30]" + PlayerRes.UnHUDIcon_Return + "[/img]: Return"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	Health.max_value = PlayerRes.Health_Max
	Health.value = PlayerRes.Health
	Stamina.max_value = PlayerRes.Stamina_Max
	Stamina.value = PlayerRes.Stamina
	
