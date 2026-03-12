extends Control

@onready var player_value: Node3D = $"../../../../../../../Player_Values"

func _process(delta: float) -> void:
	if player_value.Alive == true and player_value.Undeath == false and player_value.Menu_Depth == 3:
		if player_value.One_Time == true:
			$"../Item Selection".focus_first_visible($"Tools Scroller/Tools Grid/Items_Icons/Tool_Sword_Ico")
			player_value.One_Time = false
		self.visible = true
	else:
		self.visible = false
	
	if Input.is_action_just_pressed("ui_cancel"):
		player_value.Menu_Backwards(3, 1)
