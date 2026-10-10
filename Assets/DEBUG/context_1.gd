extends Node

var Box: int = 1
var Max: int = 1
var Min: int = 1

func _ready() -> void:
	Box_Sort()

func _process(delta: float) -> void:
	%"Context Label".text = str("(", Box, "/", Max, ") Save File Insight")
	if %"LabelsA Box".visible == true:
		%LabelA1.text = str("Current Map: ", PLY_SaveSys.Save_Data.Save_List["Current Map"])
		%LabelA1.text += str("\rPosition: ", PLY_SaveSys.Save_Data.Save_List["GPosition"])
		%LabelA1.text += str("\rRotation: ", PLY_SaveSys.Save_Data.Save_List["GRotation"])
		%LabelA1.text += str("\rHealth: ", PLY_SaveSys.Save_Data.Save_List["Health"])
		%LabelA1.text += str("\rRHand: ", PLY_SaveSys.Save_Data.Save_List["RHand"])
		%LabelA1.text += str("\rLHand: ", PLY_SaveSys.Save_Data.Save_List["LHand"])
		%LabelA1.text += str("\rBrace: ", PLY_SaveSys.Save_Data.Save_List["Brace"])
		%LabelA1.text += str("\rWear: ", PLY_SaveSys.Save_Data.Save_List["Wear"])
		%LabelA1.text += str("\rSpell: ", PLY_SaveSys.Save_Data.Save_List["Spell"])
		%LabelA1.text += str("\rUitem 1: ", PLY_SaveSys.Save_Data.Save_List["Uitem 1"])
		%LabelA1.text += str("\rUitem 2: ", PLY_SaveSys.Save_Data.Save_List["Uitem 2"])
		%LabelA1.text += str("\rUitem 3: ", PLY_SaveSys.Save_Data.Save_List["Uitem 3"])
		#%LabelA1.text += str("\r: ", PLY_SaveSys.Save_Data.Save_List[""])


func NEXT() -> void:
	Box = 1
	Box_Sort()

func LAST() -> void:
	Box = 1
	Box_Sort()

func Box_Sort():
	Box = clamp(Box, Min, Max)
	
	var Boxs = {
		"1" = %"LabelsA Box",
		"2" = %"LabelsB Box"
	}
	
	%"LabelsA Box".visible = false
	%"LabelsB Box".visible = false
	
	Boxs.values()[Box - 1].visible = true
