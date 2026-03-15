extends Node3D

@onready var player: CharacterBody3D = $".."
@onready var tool_node: Node3D = $"../Tool_Node"
#@onready var PlayerValue: Node3D = $"../PlayerValues"

var Current_Anim_Playing = false # Current animation (Animation playing = 1. Animation mot playing = 0)

func _on_m_1911_anims_animation_finished(anim_name: StringName) -> void:
	if anim_name == "TST_M1911_Shoot" or "TST_M1911_Reload":
		Current_Anim_Playing = false
	if anim_name == "TST_M1911_Pop_up":
		PlayerValue.Anim_HM_Done1 = true

func _on_m_14_anims_animation_finished(anim_name: StringName) -> void:
	if anim_name == "TST_M14_Shoot" or "TST_M14_Reload_R" or "TST_M14_Reload_L":
		Current_Anim_Playing = false
	if anim_name == "TST_M14_Pop_up":
		PlayerValue.Anim_HM_Done2 = true


func _on_arm_anims_l_animation_finished(anim_name: StringName) -> void:
	if anim_name == "TST_Arms_Interact":
		Current_Anim_Playing = false
func _on_arm_anims_r_animation_finished(anim_name: StringName) -> void:
	if anim_name == "TST_Arms_Interact":
		Current_Anim_Playing = false


func _on_tool_gen_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Hand_Interact_R" or anim_name == "Hand_Interact_L" or anim_name == "TST_M1911_Shoot":
		Current_Anim_Playing = false
