extends Control

@onready var _1a: VBoxContainer = $"1A"
@onready var _2a: VBoxContainer = $"2A"
@onready var _2b: VBoxContainer = $"2B"

var Main_Page: bool = true
var Menu_Type: String = ""

func _ready() -> void:
	_1a.visible = false
	_2a.visible = false
	_2b.visible = false

func _process(_delta: float) -> void:
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
