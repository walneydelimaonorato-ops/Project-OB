extends Node

func _ready() -> void:
	print_rich("[color=red]========================= \rGlobal Working[/color]")

var Player_Data: PlayerData = preload("res://Assets/Player/Scripts/Player Data.tres").duplicate()

var Dialogue = preload("res://Assets/Dialogue/Dialogue.gd")

var Load_New = preload("uid://bjx42pmeq3smb")
var Next_Scene: String = "uid://1pdtqb482aod"
