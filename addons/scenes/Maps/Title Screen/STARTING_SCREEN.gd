extends Control

var display_depth = 0
var menu_type = ""

func _ready() -> void:
	pass
	#$"Main Container/Start btn".grab_focus()
	#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	#Input.mouse_mode = Input.MOUSE_MODE_CONFINED

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		display_depth -= 1
		menu_type = ""

func _process(delta: float) -> void:
	match display_depth:
		0:
			$"Main Container".visible = true
			$"Exit btn".visible = true
		1:
			$"Main Container".visible = false
			$"Exit btn".visible = false
	
	match menu_type:
		"":
			$"Menu type start".visible = false
			$"Menu type options node".visible = false
		"start":
			$"Menu type start".visible = true
		"options":
			$"Menu type options node".visible = true

func _on_start_btn_pressed() -> void:
	display_depth += 1
	menu_type = "start"

func _on_option_btn_pressed() -> void:
	display_depth += 1
	menu_type = "options"

func _on_map_select_1_pressed() -> void:
	get_tree().change_scene_to_file("res://addons/scenes/Maps/TST/TST_MAIN_MAP.tscn")
func _on_map_select_2_pressed() -> void:
	get_tree().change_scene_to_file("res://addons/scenes/Maps/TST/TST_CASTLE_V3.1.tscn")
func _on_map_select_3_pressed() -> void:
	get_tree().change_scene_to_file("res://addons/scenes/Maps/TST/TST_FOUTAIN.tscn")
func _on_map_select_4_pressed() -> void:
	get_tree().change_scene_to_file("res://addons/scenes/Maps/TST/TST_Forest_V2.tscn")
func _on_exit_btn_pressed() -> void:
	get_tree().quit()

func _on_control_type_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		global.Control_Type = true
		$"Menu type options node/Control type track".text = ": Joypad"
	elif toggled_on == false:
		global.Control_Type = false
		$"Menu type options node/Control type track".text = ": Keyboard"
