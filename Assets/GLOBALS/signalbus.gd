extends Node

#region Player related signals
signal Debug_Sig1()

# Input signal
signal UItem_Cycle()
# Input signal
signal UItem_Use()
# Input signal
signal Action_Alternative()
# Input Signal
signal Action_Primary(Direction: String)


# Animations signal
signal Player_Animations(Animation_Name: String)
#signal Player_Sound(Sound_Name: String)
signal Tap_Hold_Interval(Release_Input)
# 
signal Sig_General_Interaction(Ray: RayCast3D, Method: String)
signal Sig_Interaction_HUD_Return(Message)
signal Sig_Set_Menu(Switch: bool, Next_Menu: String)

# Performs operations on determined variables
signal Variable_Operation(Operation: String, Type: String, Value: int)

# Signal for setting the menus (not to be confused with the submenus)
signal Menu_Setting(Menu: String)
# Signal for setting the submenus (not to be confused with the menus)
signal SubMenu_Setting(SubMenu: String)

# Toggles the Ready Menu
signal faltyReady_Menu_Toggled(active: bool)
# Toggles the Selection Menu
signal faltySeletion_Menu_Toggled(active: bool)
# Toggles the Choice Menu
signal faltyChoice_Menu_Toggled(active: bool)

# Update signal for the visuals of menus
signal faultyMenus_Visual_Update(Menu_Slot: String, Item_Texture: String)

#region Side HUD Information
# Update signal for the visual icons in Side HUD
signal Side_HUD_Overlay_Update(Menu_Slot: String, Item_Texture: String)
# Update signal for the Health and Stamina and etc
signal Side_Status_Update()
signal Side_HUD_Update()
#endregion

signal Ready_Menu_Overlay_Update(Menu_Slot: String, Item_Texture: String)

# Update signal for Status Management
signal Player_Stats_Management_Update_In()
signal Player_Stats_Management_Update_Out()

#region New Code Region
# Signal used to actually set the pluer status
signal Set_Sats(Target: String, Setting: String)
signal Player_Permissions_Conditionals()
#endregion

# Signal used to update the Side HUD and rotate Equipped items in the hand
signal Tool_Rotation()
signal faultyHUD_Update()

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

#Signal to call SubRoutines
signal SubRoutine_Call(Tool: String, Routine: String)

# Menu related signals
signal focus_first_visible(container)
signal MSelection_Item_Sorting()
signal FMenu_Return(Return_Path: String)

# Interaction related signals
signal Interaction_Manager_Request(Interaction: String, Address: String, Param1: String, Param2: String)
signal Interaction_Prompt_Manager(Address: String, Ch_Name: String, Ch_Confirm: String, Ch_Deny: String)
signal Interaction_Prompt_Manager_Response(Address: String, Response: bool)
signal NPC_Dialogue(Shelf: String, Book: String)

#endregion


# Requests the damage value
signal request_damage(Damage_Number: int)

func _ready() -> void:
	print_rich("[color=red]Signal Bus Working[/color]")
