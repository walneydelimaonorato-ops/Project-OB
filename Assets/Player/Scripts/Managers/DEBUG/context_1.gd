extends Node

var Box: int = 1
var Max: int = 2
var Min: int = 1

func _ready() -> void:
	%"LabelsA Box".visible = false

func _process(delta: float) -> void:
	%"Context Label".text = str("(", Box, "/", Max, ") Save File Insight")
	if %"LabelsA Box".visible == true:
		%LabelA1.text = str("Position: ", PlayerSaveManager.Save_Data.Save_List["GPosition"])
		%LabelA1.text += str("\rRotation: ", PlayerSaveManager.Save_Data.Save_List["GRotation"])
		%LabelA1.text += str("\rHealth: ", PlayerSaveManager.Save_Data.Save_List["Health"])


func NEXT() -> void:
	Box += 1
	Box_Sort()

func LAST() -> void:
	Box -= 1
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
