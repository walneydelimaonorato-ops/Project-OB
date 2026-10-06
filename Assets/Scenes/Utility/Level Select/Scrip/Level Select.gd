extends Control

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	BugBus.emit_signal("Report", "Map", "\n <LEVEL SELECT> \n")
	Creep()

func Creep():
	var creep_txt: String
	var creep_chance = randi_range(1, 1)
	var creep_val: int = randi_range(1, 5)
	%Creep.visible = true
	match creep_val:
		1:
			creep_txt = "DARK PATHS I ROAM IN"
		2:
			creep_txt = "PUTRID AIR I BREATHE IN"
		3:
			creep_txt = "TRIAD I BELIEVE IN"
		4:
			creep_txt = "MAY RED RAIN"
		5:
			creep_txt = "MAY RED REIGN"
		
	if creep_chance <= 0:
		%Creep.visible = false
	else:
		%Creep.position.x = randi_range(500, 900)
		%Creep.position.y = randi_range(100, 600)
		
		%Creep.text = str("[color=red]", creep_txt)
