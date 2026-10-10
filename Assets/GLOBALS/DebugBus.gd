extends Node

func _ready() -> void:
	print_rich("[color=red]Debug Bus")

signal Report(Target: String, Report: String)

var test1: bool = false
var Developer_Mode: bool = true
var Context_Debug: int = 0
var Free_Cam_Mode: bool = false
