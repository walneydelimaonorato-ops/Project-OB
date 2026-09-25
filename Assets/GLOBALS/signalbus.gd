extends Node

#region Player related signals
# Input signal
signal UItem_Cycle()
# Input signal
signal UItem_Use()
# Input signal
signal Action_Alternative()
# Input Signal
signal Action_Primary(Direction: String)
# Input signal
signal Tap_Hold_Interval(Release_Input)


# Animations signal
signal Player_Animations(Animation_Name: String)


# Signal that calls for an universal interaction
signal Sig_General_Interaction(Ray: RayCast3D, Method: String)
# Signal that returns the HUD prompt message
signal Sig_Interaction_HUD_Return(Message)


# Performs operations on determined variables LOCALY
signal LOC_Value_Operator(Operation: bool, Value: String, Quantity: float)


#signal Variable_Operation(Operation: String, Type: String, Value: int)


# Signal for setting the menus (not to be confused with the submenus)
signal Menu_Setting(Menu: String)
# Signal for setting the submenus (not to be confused with the menus)
signal SubMenu_Setting(SubMenu: String)


#region Side HUD Information
# Update signal for the visual icons in Side HUD
signal Side_HUD_Overlay_Update()
# Update signal for the Health and Stamina and etc
signal Side_Status_Update()
signal Side_HUD_Update()
#endregion


signal Ready_Menu_Overlay_Update(Menu_Slot: String, Item_Texture: String)


#region New Code Region
# Signal used to actually set the pluer status
signal Player_Permissions_Conditionals()
signal Player_Permissions_Changer(Permission: String, Setting: String)
#endregion

# Signal used to update the Side HUD and rotate Equipped items in the hand
signal Tool_Rotation()

# Makes a request for a choice prompt popup
signal request_popup(Choice_Names: String, Address_From: String)
# Returns the choice for a choice prompt opup
signal reply_popup(Choice_Answer: String, Address_To: String)
# Requests dialogue
signal request_dialogue()
# Carries-over items to the player
signal item_transfer(Item_Sys_Name: String, Item_Type: String, Item_Quantity: int)

#Signal to call SubRoutines
signal SubRoutine_Call(Tool: String, Routine: String)

# Menu related signals
signal focus_first_visible(container)
signal MSelection_Item_Sorting()
signal FMenu_Return(Return_Path: String)
signal Notification(Notification_Text: String, Notification_Time: int)

# Interaction related signals
signal Interaction_Manager_Request(Interaction: String, Address: String, Param1: String, Param2: String)

signal Interaction_Prompt_Manager(Address: String, Ch_Name: String, Ch_Confirm: String, Ch_Deny: String)
signal Interaction_Prompt_Manager_Response(Address: String, Response: bool)

signal NPC_Dialogue(Shelf: String, Book: String)
signal Object_Interaction(ID: String, To_Call: String)

signal Keys_Recognition(Stamp: String, Keys: String)
signal Keys_Stamping(Stamp: String)

signal Load_save_Visual_Update()
#endregion


#region New Code Region
# Requests the damage value
signal Take_Damage(Damage_Number: int)

# Performs operations on determined variables GLOBALY
signal GLO_Value_Operator(Operation: bool, Value: String, Quantity: float)
#endregion

func _ready() -> void:
	print_rich("[color=red]Signal Bus Working[/color]")
