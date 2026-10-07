extends Node

var Box: int = 1
var Max: int = 1
var Min: int = 1

func _ready() -> void:
	Box_Sort()

func _process(delta: float) -> void:
	%"Context Label".text = str("(", Box, "/", Max, ") Save File Insight")
	if %"LabelsA Box".visible == true:
		%LabelA1.text = str("Current Map: ", PlayerSaveManager.Save_Data.Save_List["Current Map"])
		%LabelA1.text += str("\rPosition: ", PlayerSaveManager.Save_Data.Save_List["GPosition"])
		%LabelA1.text += str("\rRotation: ", PlayerSaveManager.Save_Data.Save_List["GRotation"])
		%LabelA1.text += str("\rHealth: ", PlayerSaveManager.Save_Data.Save_List["Health"])
		%LabelA1.text += str("\rRHand: ", PlayerSaveManager.Save_Data.Save_List["RHand"])
		%LabelA1.text += str("\rLHand: ", PlayerSaveManager.Save_Data.Save_List["LHand"])
		%LabelA1.text += str("\rBrace: ", PlayerSaveManager.Save_Data.Save_List["Brace"])
		%LabelA1.text += str("\rWear: ", PlayerSaveManager.Save_Data.Save_List["Wear"])
		%LabelA1.text += str("\rSpell: ", PlayerSaveManager.Save_Data.Save_List["Spell"])
		%LabelA1.text += str("\rUitem 1: ", PlayerSaveManager.Save_Data.Save_List["Uitem 1"])
		%LabelA1.text += str("\rUitem 2: ", PlayerSaveManager.Save_Data.Save_List["Uitem 2"])
		%LabelA1.text += str("\rUitem 3: ", PlayerSaveManager.Save_Data.Save_List["Uitem 3"])
		#%LabelA1.text += str("\r: ", PlayerSaveManager.Save_Data.Save_List[""])


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
