extends Node3D

@onready var player_value: Node3D = $Player/Player_Values

var RNG = RandomNumberGenerator.new()
var MState = 0

var Audio_end = 0

var Return_To_Life
var Return_Delay = 60

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_value.Undeath = true
	var MState = RNG.randi_range(1, 2)
	match MState:
		1:
			$Sounds/Anticipation.play()
			$Statues/TstStatue1.visible = true
			Audio_end = 38
		#2:
			#$Sounds/Ourtime.play()
			#Audio_end = 48
		2:
			$Sounds/Talkingheads.play()
			$Statues/TstStatue2.visible = true
			Audio_end = 26
	await get_tree().create_timer(Audio_end + 2).timeout
	get_tree().change_scene_to_file("res://addons/scenes/Maps/TST/TST_MAIN_MAP.tscn")
