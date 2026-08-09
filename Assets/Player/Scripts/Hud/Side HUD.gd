extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Side_HUD_Update()
	SignalBus.Side_HUD_Overlay_Update.connect(Side_Menu_Overlay_Update)
	SignalBus.Side_HUD_Update.connect(Side_HUD_Update)

func Side_HUD_Update():
	%"Side HUD".visible = Global.Player_Data.Player_Perms["Can_Show_UI_Side"]
	
	HUD_Visibility(%"Tool R", %"Name ToolR", %"Desc ToolR", "Invisible")
	HUD_Visibility(%"Tool L", %"Name ToolL", %"Desc ToolL", "Invisible")
	#HUD_Visibility(%Spell, %"Name Spell", %"Desc Spell" , "Invisible")
	HUD_Visibility(%UItem, %"Name UItem", %"Desc UItem", "Invisible")
	
	match Global.Player_Data.Inv_ToolR_Equiped:
		"null":
			%"Name ToolR".text = "Unequipped"
			%"Desc ToolR".text = "<nothing>"
			Side_Menu_Overlay_Update("Ready Tool Right", "uid://qua4cq3ubssm")
	
		"HandGun":
			HUD_Visibility(%"Tool R", %"Name ToolR", %"Desc ToolR", "Visible")
			%"Name ToolR".text = Global.Player_Data.Tool_ID["HandGun"]["dys name"]
			%"Desc ToolR".text = str("Ammo: ", Global.Player_Data.Tool_ID["HandGun"]["Ammo"], " // Mags: ", Global.Player_Data.Tool_ID["HandGun"]["Mag"])
		"AssaultRifle":
			HUD_Visibility(%"Tool R", %"Name ToolR", %"Desc ToolR", "Visible")
			%"Name ToolR".text = Global.Player_Data.Tool_ID["AssaultRifle"]["dys name"]
			%"Desc ToolR".text = "tasty coconut :3"
	
	match Global.Player_Data.Inv_ToolL_Equiped:
		"null":
			%"Name ToolL".text = "Unequipped"
			%"Desc ToolL".text = "<nothing>"
			Side_Menu_Overlay_Update("Ready Tool Left", "uid://qua4cq3ubssm")
	
		"HandGun":
			HUD_Visibility(%"Tool L", %"Name ToolL", %"Desc ToolL", "Visible")
			%"Name ToolL".text = Global.Player_Data.Tool_ID["HandGun"]["dys name"]
			%"Desc ToolL".text = str("Ammo: ", Global.Player_Data.Tool_ID["HandGun"]["Ammo"], " // Mags: ", Global.Player_Data.Tool_ID["HandGun"]["Mag"])
		"AssaultRifle":
			HUD_Visibility(%"Tool L", %"Name ToolL", %"Desc ToolL", "Visible")
			%"Name ToolL".text = Global.Player_Data.Tool_ID["AssaultRifle"]["dys name"]
			%"Desc ToolL".text = str("Ammo: ", Global.Player_Data.Tool_ID["AssaultRifle"]["Ammo"], " // Mags: ", Global.Player_Data.Tool_ID["AssaultRifle"]["Mag"])
	
	match Global.Player_Data.Cycle_Uitem_Active:
		"null":
			%"Name UItem".text = "Unequipped"
			%"Desc UItem".text = "<nothing>"
			Side_Menu_Overlay_Update("Ready UItem 1", "uid://qua4cq3ubssm")
	
		"Sigil":
			HUD_Visibility(%UItem, %"Name UItem", %"Desc UItem", "Visible")
			%"Name UItem".text = Global.Player_Data.UItem_ID["Sigil"]["dys name"]
			%"Desc UItem".text = "Not enough..."
		"Glass Flask":
			HUD_Visibility(%UItem, %"Name UItem", %"Desc UItem", "Visible")
			%"Name UItem".text = Global.Player_Data.UItem_ID["Glass Flask"]["dys name"]
			%"Desc UItem".text = str("Uses: ", Global.Player_Data.UItem_ID["Glass Flask"]["quantity"])

func HUD_Visibility(Icon, Name, Description, State):
	if State == "Visible":
		Icon.self_modulate.a = 1
		Name.self_modulate.a = 1
		Description.self_modulate.a = 1
	elif State == "Invisible":
		Icon.self_modulate.a = 0.5
		Name.self_modulate.a = 0.5
		Description.self_modulate.a = 0.5

func Side_Menu_Overlay_Update(Menu_Slot, Item_Texture):
	match Menu_Slot:
		"Ready Tool Left":
			%"TL Over".texture = load(Item_Texture)
		"Ready Tool Right":
			%"TR Over".texture = load(Item_Texture)
		"Ready Spell":
			%"S Over".texture = load(Item_Texture)
		"Ready UItem 1":
			%"U Over".texture = load(Item_Texture)
		#"Ready UItem 2":
			#%"Ready  UItem 2 Overlay".texture = load(Item_Texture)
		#"Ready UItem 3":
			#%"Ready UItem 3 Overlay".texture = load(Item_Texture)
		_:
			print_rich("[color=#ff00ff]MANUAL ERROR: <Side_Menu_Visual_Update> Argument out of scope[/color]")
