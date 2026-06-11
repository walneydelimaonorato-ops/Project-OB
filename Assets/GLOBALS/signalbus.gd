extends Node

#region Player related signals
signal Debug_Sig1()

# Input signal
signal UItem_Cycle()
# Input signal
signal UItem_Use()
# 
signal Sig_General_Interaction(Ray: RayCast3D, Method: String)
signal Sig_Interaction_HUD_Return(Message)
signal Sig_Set_Menu(Switch: bool, Next_Menu: String)

# Performs operations on determined variables
signal Variable_Operation(Operation: String, Type: String, Value: int)

# Toggles the Ready Menu
signal Ready_Menu_Toggled(active: bool)
# Toggles the Selection Menu
signal Seletion_Menu_Toggled(active: bool)
# Toggles the Choice Menu
signal Choice_Menu_Toggled(active: bool)

# Update signal for the visuals of menus
signal Menus_Visual_Update(Menu_Slot: String, Item_Texture: String)
# Update signal for Status Management
signal Player_Stats_Management_Update_In()
signal Player_Stats_Management_Update_Out()
# Signal used to actually set the plauer status
signal Set_Sats(Target: String, Setting: String)

# Signal used to update the Side HUD and rotate Equipped items in the hand
signal Tool_Rotation()
signal HUD_Update()

# Makes a request for a choice prompt popup
signal request_popup(Choice_Names: String, Address_From: String)
# Returns the choice for a choice prompt opup
signal reply_popup(Choice_Answer: String, Address_To: String)
# Requests dialogue
signal request_dialogue()
# Modifies certain player stats
signal player_stat_change(Operation: String, Stats_Type: String, Damage_Number: String)
# Carries-over items to the player
signal item_transfer(Item_Sys_Name: String, Item_Type: String, Item_Quantity: int)
#endregion


# Requests the damage value
signal request_damage(Damage_Number: int)

func _ready() -> void:
	print("Signal Bus working")
