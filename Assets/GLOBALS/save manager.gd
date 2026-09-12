extends Node
const Save_Path : String = "user://OB_Save.tres"
var Save_Data : Save_File

func _ready() -> void:
	print_rich("[color=red]Save Manager Working")
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
func Load_Save(Depth: bool):
	Global.Player_Data.Player_Position = Save_Data.Save_List["GPosition"]
	Global.Player_Data.Player_Rotation = Save_Data.Save_List["GRotation"]
	
	Global.Player_Data.Health = Save_Data.Save_List["Health"]
	
	Global.Player_Data.Inv_ToolR_Equiped = Save_Data.Save_List["RHand"]
	Global.Player_Data.Inv_ToolL_Equiped = Save_Data.Save_List["LHand"]
	Global.Player_Data.Inv_Brace_Equiped = Save_Data.Save_List["Brace"]
	Global.Player_Data.Inv_Wear_Equiped = Save_Data.Save_List["Wear"]
	Global.Player_Data.Inv_Spell_Equiped = Save_Data.Save_List["Spell"]
	Global.Player_Data.Inv_Uitem1_Equiped = Save_Data.Save_List["Uitem 1"]
	Global.Player_Data.Inv_Uitem2_Equiped = Save_Data.Save_List["Uitem 2"]
	Global.Player_Data.Inv_Uitem3_Equiped = Save_Data.Save_List["Uitem 3"]
	
	
	SignalBus.emit_signal("Load_save_Visual_Update")

func Save_Settup():
	Save_Data.Save_List["Current Map"] = Global.Next_Scene
	Save_Data.Save_List["GPosition"] = Global.Player_Data.Player_Position
	Save_Data.Save_List["GRotation"] = Global.Player_Data.Player_Rotation
	
	Save_Data.Save_List["Health"] = Global.Player_Data.Health
	
	Save_Data.Save_List["RHand"] = Global.Player_Data.Inv_ToolR_Equiped
	Save_Data.Save_List["LHand"] = Global.Player_Data.Inv_ToolL_Equiped
	Save_Data.Save_List["Brace"] = Global.Player_Data.Inv_Brace_Equiped
	Save_Data.Save_List["Wear"] = Global.Player_Data.Inv_Wear_Equiped
	Save_Data.Save_List["Spell"] = Global.Player_Data.Inv_Spell_Equiped
	Save_Data.Save_List["Uitem 1"] = Global.Player_Data.Inv_Uitem1_Equiped
	Save_Data.Save_List["Uitem 2"] = Global.Player_Data.Inv_Uitem2_Equiped
	Save_Data.Save_List["Uitem 3"] = Global.Player_Data.Inv_Uitem3_Equiped
	#Save_Data.Save_List[""] = Global.Player_Data.
