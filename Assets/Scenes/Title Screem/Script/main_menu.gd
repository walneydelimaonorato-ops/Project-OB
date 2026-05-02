extends Control

@onready var Hints: RichTextLabel = $Hints

@onready var _1a: VBoxContainer = $"1A"
@onready var _2a: VBoxContainer = $"2A"
@onready var _2b: VBoxContainer = $"2B"

var Main_Page: bool = true
var Menu_Type: String = ""
var Icon1: String
var Icon2: String

func _ready() -> void:
	_1a.visible = false
	_2a.visible = false
	_2b.visible = false

func _process(_delta: float) -> void:
	#match PlayerRes.Control_Mode:
		#"Key":
	Icon1 = "uid://c4pcxjw2avyi8"
	Icon2 = "uid://0cjin76csgan"
		#"Joy":
			#Icon1 = "uid://dc1xk808sl8if"
			#Icon2 = "uid://b7k14ccnc0d7h"

	Hints.text = "[img=30]" + Icon1 + "[/img]: Select // [img=30]" + Icon2 + "[/img]: Return"
	
	match Main_Page:
		true:
			Menu_Type = "Main"
			_1a.visible = true
		false:
			_1a.visible = false
	
	match Menu_Type:
		"Start":
			_2a.visible = true
		"Options":
			_2b.visible = true
		_:
			_2a.visible = false
			_2b.visible = false

func start_pressed() -> void:
	Menu_Type = "Start"
	Main_Page = false

func options_pressed() -> void:
	Menu_Type = "Options"
	Main_Page = false

func exit_pressed() -> void:
	get_tree().quit()

func map1_pressed() -> void:
	Global.Next_Scene = "uid://b02bwoffepy66"
	get_tree().change_scene_to_packed(Global.Load_New)

func map2_pressed() -> void:
	Global.Next_Scene = "uid://c47b70iv613lg"
	get_tree().change_scene_to_packed(Global.Load_New)

func map_3_pressed() -> void:
	Global.Next_Scene = "uid://cdd50mvv70oa7"
	get_tree().change_scene_to_packed(Global.Load_New)
