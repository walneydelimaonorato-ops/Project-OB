extends Node3D

@onready var player: CharacterBody3D = $".."
@onready var tool_node: Node3D = $"../Tool_Node"
@onready var player_value: Node3D = $"../Player_Values"

var Current_Anim_Playing = false # Current animation (Animation playing = 1. Animation mot playing = 0)



func _on_point_r_animation_finished() -> void:
	if tool_node.Holding_HandR.animation == "hand_pointing" or tool_node.Holding_HandR.animation == "hand_alt":
		Current_Anim_Playing = false
func _on_point_l_animation_finished() -> void:
	if tool_node.Holding_HandL.animation == "hand_pointing" or tool_node.Holding_HandL.animation == "hand_alt":
		Current_Anim_Playing = false

func _on_hand_misc_r_animation_finished() -> void:
	if tool_node.Hand_MiscellaneousR.animation == "hand_misc_change_gun":
		player_value.Anim_HM_Done1 = true
	elif tool_node.Hand_MiscellaneousR.animation == "hand_misc_change_sword":
		player_value.Anim_HM_Done2 = true
func _on_hand_misc_l_animation_finished() -> void:
	if tool_node.Hand_MiscellaneousL.animation == "hand_misc_change_gun":
		player_value.Anim_HM_Done1 = true
	elif tool_node.Hand_MiscellaneousL.animation == "hand_misc_change_sword":
		player_value.Anim_HM_Done2 = true

func _on_sword_r_animation_finished() -> void:
	pass # Replace with function body.
func _on_sword_l_animation_finished() -> void:
	pass # Replace with function body.


func _on_m_1911_anims_animation_finished(anim_name: StringName) -> void:
	if anim_name == "TST_M1911_Shoot" or "TST_M1911_Reload":
		Current_Anim_Playing = false
	if anim_name == "TST_M1911_Pop_up":
		player_value.Anim_HM_Done1 = true

func _on_m_14_anims_animation_finished(anim_name: StringName) -> void:
	if anim_name == "TST_M14_Shoot" or "TST_M14_Reload_R" or "TST_M14_Reload_L":
		Current_Anim_Playing = false


func _on_arm_anims_l_animation_finished(anim_name: StringName) -> void:
	if anim_name == "TST_Arms_Interact":
		Current_Anim_Playing = false
func _on_arm_anims_r_animation_finished(anim_name: StringName) -> void:
	if anim_name == "TST_Arms_Interact":
		Current_Anim_Playing = false
