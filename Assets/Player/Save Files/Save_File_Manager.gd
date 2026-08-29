extends Node

var Active_Save_File
var Local_Save

func _ready() -> void:
	print("Save File Manager Working")
	Set_Active_Save_File(1)
	SignalBus.Save_File_Write.connect(Save_Write)
	SignalBus.Save_File_Read.connect(Save_Read)

func Set_Active_Save_File(Setter: int):
	if Setter == 1:
		Active_Save_File = Global.Save_File_A

func Save_Write():
	print(Active_Save_File.Character_File_A["Sin"])


func Save_Read():
	Active_Save_File.Character_File_A["Sin"] = Global.Player_Data.Sin
	var file = FileAccess.open("res://Assets/Player/Save Files/Save.txt", FileAccess.WRITE)
	file.store_var(Local_Save)
