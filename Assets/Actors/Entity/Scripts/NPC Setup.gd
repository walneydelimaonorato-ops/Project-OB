extends CUS_NPC

func _ready() -> void:
	if NPC_Model:
		var Model: Node3D = NPC_Model.instantiate()
		%Model.add_child(Model)
	if NPC_Hostile == false:
		NPC_AI_LVL = 0
