extends Node

signal request_popup(Choice_Names, source)
signal reply_popup(Choice_Answer)
signal request_dialogue()

signal request_damage(Damage_Number)
signal player_stat_change(Stats_Type, Damage_Number)

signal item_transfer(Item_Sys_Name, Item_Type, Item_Quantity)

func _ready() -> void:
	print("Signal Bus working")
