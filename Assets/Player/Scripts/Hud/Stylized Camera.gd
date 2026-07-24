extends Node

func _ready() -> void:
	if %SubViewport.visible == true:
		print_rich("[color=#ffdf00]Stylized Camera: [/color][color=green]Enabled[/color]")
	else:
		print_rich("[color=#ffdf00]Stylized Camera: [/color][color=red]Disabled[/color]")
	%Style.visible = %SubViewport.visible


func _process(delta: float) -> void:
	if %SubViewport.visible == true:
		%Style.global_transform = %Eyes.global_transform
