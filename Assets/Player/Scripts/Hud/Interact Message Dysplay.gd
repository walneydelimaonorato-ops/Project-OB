extends CanvasLayer

var Interact_Prompt: String = "General"

func _ready() -> void:
	print_rich("[color=#ffdf00]Interact Message Working[/color]")
	#Side_HUD_Update()
	#SignalBus.Menus_Visual_Update.connect(Side_Menu_Visual_Update)
	#SignalBus.HUD_Update.connect(Side_HUD_Update)
	SignalBus.Sig_Interaction_HUD_Return.connect(Interact_Message_Display)

func _process(_delta: float) -> void:
	%"Interact Prompt".text = "[img=30]" + Global.Player_Data.UnHUDIcon_Interact + "[/img]: " + Interact_Prompt
	if %Ray2.is_colliding():
		%"Interact Prompt".visible = true
		SignalBus.emit_signal("Sig_General_Interaction", %Ray2, "HUD_Element")
	if !%Ray2.is_colliding():
		%"Interact Prompt".visible = false

func Interact_Message_Display(Message):
	if Message.get_parent().has_method("HUD_Element"):
		Interact_Prompt = Message.get_parent().HUD_Prompt

#func Side_HUD_Update():
	#%Stamina.visible = Global.Player_Data.Player_Perms.Can_Show_UI_Stats
	#%Health.visible = Global.Player_Data.Player_Perms.Can_Show_UI_Stats
	#
	##Health.value = lerp(Health.value, Global.Player_Data.Health, 0.5)
	#Health.max_value = Global.Player_Data.Health_Max
	#Health.value = Global.Player_Data.Health
	#Stamina.max_value = Global.Player_Data.Stamina_Max
	#Stamina.value = Global.Player_Data.Stamina
	
	#HUD_Visibility(%"Tool R", %"Name ToolR", %"Desc ToolR", "Invisible")
	#HUD_Visibility(%"Tool L", %"Name ToolL", %"Desc ToolL", "Invisible")
	#HUD_Visibility(%Spell, %"Name Spell", %"Desc Spell" , "Invisible")
	#HUD_Visibility(%UItem, %"Name UItem", %"Desc UItem", "Invisible")
	#
	#match Global.Player_Data.Inv_ToolR_Equiped:
		#"null":
			#%"Name ToolR".text = "Unequipped"
			#%"Desc ToolR".text = "<nothing>"
		#"HandGun":
			#HUD_Visibility(%"Tool R", %"Name ToolR", %"Desc ToolR", "Visible")
			#%"Name ToolR".text = Global.Player_Data.Tool_ID["HandGun"]["dys name"]
			#%"Desc ToolR".text = str("Ammo: ", Global.Player_Data.Tool_ID["HandGun"]["Ammo A"], " // Mags: ", Global.Player_Data.Tool_ID["HandGun"]["Mag A"])
		#"AssaultRifle":
			#HUD_Visibility(%"Tool R", %"Name ToolR", %"Desc ToolR", "Visible")
			#%"Name ToolR".text = Global.Player_Data.Tool_ID["AssaultRifle"]["dys name"]
			#%"Desc ToolR".text = "tasty coconut :3"
#
	#match Global.Player_Data.Inv_ToolL_Equiped:
		#"null":
			#%"Name ToolL".text = "Unequipped"
			#%"Desc ToolL".text = "<nothing>"
		#"HandGun":
			#HUD_Visibility(%"Tool L", %"Name ToolL", %"Desc ToolL", "Visible")
			#%"Name ToolL".text = Global.Player_Data.Tool_ID["HandGun"]["dys name"]
			#%"Desc ToolL".text = str("Ammo: ", Global.Player_Data.Tool_ID["HandGun"]["Ammo A"], " // Mags: ", Global.Player_Data.Tool_ID["HandGun"]["Mag A"])
		#"AssaultRifle":
			#HUD_Visibility(%"Tool L", %"Name ToolL", %"Desc ToolL", "Visible")
			#%"Name ToolL".text = Global.Player_Data.Tool_ID["AssaultRifle"]["dys name"]
			#%"Desc ToolL".text = "tasty coconut :3"
#
	#match Global.Player_Data.Cycle_Uitem_Active:
		#"null":
			#%"Name UItem".text = "Unequipped"
			#%"Desc UItem".text = "<nothing>"
		#"Sigil":
			#HUD_Visibility(%UItem, %"Name UItem", %"Desc UItem", "Visible")
			#%"Name UItem".text = "Sigil of Violence"
			#%"Desc UItem".text = "Not enough..."
		#"Glass Flask":
			#HUD_Visibility(%UItem, %"Name UItem", %"Desc UItem", "Visible")
			#%"Name UItem".text = "Flask"
			#%"Desc UItem".text = "paraguard"
#
#func HUD_Visibility(Icon, Name, Description, State):
	#if State == "Visible":
		#Icon.self_modulate.a = 1
		#Name.self_modulate.a = 1
		#Description.self_modulate.a = 1
	#elif State == "Invisible":
		#Icon.self_modulate.a = 0.5
		#Name.self_modulate.a = 0.5
		#Description.self_modulate.a = 0.5
#
#func Side_Menu_Visual_Update(Menu_Slot, Item_Texture):
	#match Menu_Slot:
		#"Ready Tool Left":
			#%"TL Over".texture = load(Item_Texture)
		#"Ready Tool Right":
			#%"TR Over".texture = load(Item_Texture)
		#"Ready Spell":
			#%"S Over".texture = load(Item_Texture)
		#"Ready UItem 1":
			#%"U Over".texture = load(Item_Texture)
		#"Ready UItem 2":
			#%"Ready  UItem 2 Overlay".texture = load(Item_Texture)
		#"Ready UItem 3":
			#%"Ready UItem 3 Overlay".texture = load(Item_Texture)
		#_:
			#print("MANUAL ERROR: <Side_Menu_Visual_Update> Argument out of scope")
