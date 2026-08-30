extends Node

func _ready() -> void:
	%"Context 1".visible = false


func context_2_pressed() -> void:
	%"Context Tree".visible = true
	%"Context 1".visible = !%"Context 1".visible

func context_3_pressed() -> void:
	PlayerSaveManager.Load_Save()

func context_4_pressed() -> void:
	PlayerSaveManager.Write_Save()
