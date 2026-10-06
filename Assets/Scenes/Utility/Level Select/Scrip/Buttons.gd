extends Node

#region Utilities
func exit() -> void:
	get_tree().quit()

func main() -> void:
	GLOBAL.Next_Scene = "uid://1pdtqb482aod"
	get_tree().change_scene_to_packed(GLOBAL.Load_New)
#endregion

#region Tests
func test_0() -> void:
	GLOBAL.Next_Scene = "uid://b02bwoffepy66"
	get_tree().change_scene_to_packed(GLOBAL.Load_New)
func test_1() -> void:
	GLOBAL.Next_Scene = "uid://bvnu5ll1csc13"
	get_tree().change_scene_to_packed(GLOBAL.Load_New)
func test_2() -> void:
	GLOBAL.Next_Scene = "uid://cv60mvqri5fnm"
	get_tree().change_scene_to_packed(GLOBAL.Load_New)
func test_3() -> void:
	GLOBAL.Next_Scene = "uid://d2mh0lhxqfc52"
	get_tree().change_scene_to_packed(GLOBAL.Load_New)
#endregion
