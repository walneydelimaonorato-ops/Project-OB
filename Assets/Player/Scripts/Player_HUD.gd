extends CanvasLayer
@onready var PlayerRes: Node = %"Player Stats"


@onready var Health: TextureProgressBar = %Health
@onready var Stamina: TextureProgressBar = %Stamina

func _ready() -> void:
	match PlayerRes.Control_Mode:
		"Key":
			PlayerRes.UnHI_Up = "uid://bceq01ccemc8o"
			PlayerRes.UnHI_Down = "uid://duiy16ed7ovil"
			PlayerRes.UnHI_Left = "uid://beqbo453gynf1"
			PlayerRes.UnHI_Right = "uid://cwgfmbtf38n10"
			PlayerRes.UnHI_Accept = "uid://0cjin76csgan"
			PlayerRes.UnHI_Return = "uid://d12fq4lnqjl7a"
			PlayerRes.UnHI_Unselect = "uid://06v660kr4rts"
		"Joy":
			PlayerRes.UnHI_Up = "uid://bumwv083liw5g"
			PlayerRes.UnHI_Down = "uid://dtmfxjgftvudj"
			PlayerRes.UnHI_Left = "uid://ovx7jbm3tdnl"
			PlayerRes.UnHI_Right = "uid://8p350oejc5ln"
			PlayerRes.UnHI_Accept = "uid://ctvxynwec6rsy"
			PlayerRes.UnHI_Return = "uid://pnd0l1xdxt3x"
			PlayerRes.UnHI_Unselect = "uid://sdcs6qj0qc6x"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	Health.max_value = PlayerRes.Health_Max
	Health.value = PlayerRes.Health
	Stamina.max_value = PlayerRes.Stamina_Max
	Stamina.value = PlayerRes.Stamina
