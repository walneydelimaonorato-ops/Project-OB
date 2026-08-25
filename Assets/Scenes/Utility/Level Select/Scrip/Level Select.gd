extends Control

func _ready() -> void:
	%Test.visible = true
	%Beta.visible = false
	%Final.visible = false

func map1_pressed() -> void:
	pass

func map2_pressed() -> void:
	pass

func map_3_pressed() -> void:
	pass


func main_menu_pressed() -> void:
	Global.Next_Scene = "uid://1pdtqb482aod"
	get_tree().change_scene_to_packed(Global.Load_New)

func tab_clicked(tab: int) -> void:
	%Test.visible = false
	%Beta.visible = false
	%Final.visible = false
	
	match tab:
		0:
			%Test.visible = true
		1:
			%Beta.visible = true
		2:
			%Final.visible = true

func Hover_Noise() -> void:
	%"Debug Clink".play()


func test_1_pressed() -> void:
	Global.Next_Scene = "uid://b02bwoffepy66"
	get_tree().change_scene_to_packed(Global.Load_New)


func beta_1_pressed() -> void:
	Global.Next_Scene = "uid://cdd50mvv70oa7"
	get_tree().change_scene_to_packed(Global.Load_New)


func final_1_pressed() -> void:
	Global.Next_Scene = "uid://c47b70iv613lg"
	get_tree().change_scene_to_packed(Global.Load_New)


func test_2_pressed() -> void:
	Global.Next_Scene = "uid://bvnu5ll1csc13"
	get_tree().change_scene_to_packed(Global.Load_New)


func beta_2_pressed() -> void:
	Global.Next_Scene = "uid://bale17m85tpdj"
	get_tree().change_scene_to_packed(Global.Load_New)


func beta_3_pressed() -> void:
	Global.Next_Scene = "uid://l4fompyd1m4k"
	get_tree().change_scene_to_packed(Global.Load_New)


func beta_4_pressed() -> void:
	Global.Next_Scene = "uid://swg00c6sqsjc"
	get_tree().change_scene_to_packed(Global.Load_New)
