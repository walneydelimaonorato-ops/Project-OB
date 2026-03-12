extends Control

#@onready var PlayerValue: Node3D = $"../../../../../../../PlayerValues"

func _process(delta: float) -> void:
	if PlayerValue.Alive == true and PlayerValue.Undeath == false and PlayerValue.Menu_Depth == 3:
		if PlayerValue.One_Time == true:
			$"../Item Selection".focus_first_visible($"Tools Scroller/Tools Grid/Items_Icons/Tool_Sword_Ico")
			PlayerValue.One_Time = false
		self.visible = true
	else:
		self.visible = false
	
	if Input.is_action_just_pressed("ui_cancel"):
		PlayerValue.Menu_Backwards(3, 1)
