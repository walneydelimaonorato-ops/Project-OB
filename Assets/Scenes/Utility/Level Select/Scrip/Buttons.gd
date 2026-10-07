extends Node

#region Utilities
func exit() -> void:
	get_tree().quit()

func main() -> void:
	GLOBAL.Next_Scene = Map.List["Main Menu"]
	get_tree().change_scene_to_packed(GLOBAL.Load_New)
#endregion

#region Tests
func test_0() -> void:
	GLOBAL.Next_Scene = Map.List["TEST 0"]
	get_tree().change_scene_to_packed(GLOBAL.Load_New)
func test_1() -> void:
	GLOBAL.Next_Scene = Map.List["TEST 1"]
	get_tree().change_scene_to_packed(GLOBAL.Load_New)
func test_2() -> void:
	GLOBAL.Next_Scene = Map.List["TEST 2"]
	get_tree().change_scene_to_packed(GLOBAL.Load_New)
func test_3() -> void:
	GLOBAL.Next_Scene = Map.List["TEST 3"]
	get_tree().change_scene_to_packed(GLOBAL.Load_New)
#endregion
