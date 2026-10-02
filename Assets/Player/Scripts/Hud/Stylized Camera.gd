extends Node

func _ready() -> void:
	if %SubViewport.visible == true:
		BugBus.emit_signal("Report", "Player", "Stylized Camera: Enabled")
	else:
		BugBus.emit_signal("Report", "Player", "Stylized Camera: Disabled")
	%Style.visible = %SubViewport.visible


func _process(delta: float) -> void:
	if %SubViewport.visible == true:
		
		%Style.global_transform = %Eyes.global_transform
