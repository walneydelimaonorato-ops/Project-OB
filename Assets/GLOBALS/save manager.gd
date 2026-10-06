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
	PLY_Var.Player_Position = Save_Data.Save_List["GPosition"]
	PLY_Var.Player_Rotation = Save_Data.Save_List["GRotation"]
	
	PLY_Var.Health = Save_Data.Save_List["Health"]
	
	PLY_Inventory.Inv_ToolR_Equiped = Save_Data.Save_List["RHand"]
	PLY_Inventory.Inv_ToolL_Equiped = Save_Data.Save_List["LHand"]
	PLY_Inventory.Inv_Brace_Equiped = Save_Data.Save_List["Brace"]
	PLY_Inventory.Inv_Wear_Equiped = Save_Data.Save_List["Wear"]
	PLY_Inventory.Inv_Spell_Equiped = Save_Data.Save_List["Spell"]
	PLY_Inventory.Inv_Uitem1_Equiped = Save_Data.Save_List["Uitem 1"]
	PLY_Inventory.Inv_Uitem2_Equiped = Save_Data.Save_List["Uitem 2"]
	PLY_Inventory.Inv_Uitem3_Equiped = Save_Data.Save_List["Uitem 3"]
	
	
	SignalBus.emit_signal("Load_save_Visual_Update")

func Save_Settup():
	Save_Data.Save_List["Current Map"] = PLY_Var.Current_Map
	Save_Data.Save_List["GPosition"] = PLY_Var.Player_Position
	Save_Data.Save_List["GRotation"] = PLY_Var.Player_Rotation
	
	Save_Data.Save_List["Health"] = PLY_Flags.Health
	
	Save_Data.Save_List["RHand"] = PLY_Inventory.Inv_ToolR_Equiped
	Save_Data.Save_List["LHand"] = PLY_Inventory.Inv_ToolL_Equiped
	Save_Data.Save_List["Brace"] = PLY_Inventory.Inv_Brace_Equiped
	Save_Data.Save_List["Wear"] = PLY_Inventory.Inv_Wear_Equiped
	Save_Data.Save_List["Spell"] = PLY_Inventory.Inv_Spell_Equiped
	Save_Data.Save_List["Uitem 1"] = PLY_Inventory.Inv_Uitem1_Equiped
	Save_Data.Save_List["Uitem 2"] = PLY_Inventory.Inv_Uitem2_Equiped
	Save_Data.Save_List["Uitem 3"] = PLY_Inventory.Inv_Uitem3_Equiped
	#Save_Data.Save_List[""] = GLOBAL.Player_Data.
