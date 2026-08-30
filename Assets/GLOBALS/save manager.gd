extends Node

const Save_Path : String = "user://OB_Save.tres"
var Save_Data : Save_File

signal Load()

func _ready() -> void:
	print_rich("[color=red]Save Manager Working")
	Load.connect(Load_Save)
	Fetch_Save()

func Fetch_Save():
	if FileAccess.file_exists(Save_Path):
		Save_Data = ResourceLoader.load(Save_Path)
		print_rich("[color=purple]SAVE LOADED")
	else:
		Save_Data = Save_File.new()
		print_rich("[color=purple]SAVE CREATED")
func Write_Save():
	Save_Settup()
	ResourceSaver.save(Save_Data, Save_Path)
func Load_Save():
	Global.Player_Data.Player_Position = Save_Data.Save_List["GPosition"]
	Global.Player_Data.Player_Rotation = Save_Data.Save_List["GRotation"]
	Global.Player_Data.Health = Save_Data.Save_List["Health"]
	
	SignalBus.emit_signal("Load_save_Visual_Update")

func Save_Settup():
	Save_Data.Save_List["GPosition"] = Global.Player_Data.Player_Position
	Save_Data.Save_List["GRotation"] = Global.Player_Data.Player_Rotation
	Save_Data.Save_List["Health"] = Global.Player_Data.Health
