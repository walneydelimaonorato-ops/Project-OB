extends Node


func _ready() -> void:
	BugBus.emit_signal("Report", "Player", "Side HUD Working")
	Side_HUD_Update()
	SignalBus.Side_HUD_Overlay_Update.connect(Side_Menu_Overlay_Update)
	SignalBus.Side_HUD_Update.connect(Side_HUD_Update)

func Side_HUD_Update():
	%"Side HUD".visible = PLY_Flags.Perms["Can Show UI Stats"]
	
	HUD_Visibility(%"Tool R", %"Name ToolR", %"Desc ToolR", "Invisible")
	HUD_Visibility(%"Tool L", %"Name ToolL", %"Desc ToolL", "Invisible")
	#HUD_Visibility(%Spell, %"Name Spell", %"Desc Spell" , "Invisible")
	HUD_Visibility(%UItem, %"Name UItem", %"Desc UItem", "Invisible")
	
	match PLY_Inventory.Inv_ToolR_Equiped:
		"null":
			%"Name ToolR".text = "Unequipped"
			%"Desc ToolR".text = "<nothing>"
			Side_Menu_Overlay_Update()
	
		"HandGun":
			HUD_Visibility(%"Tool R", %"Name ToolR", %"Desc ToolR", "Visible")
			%"Name ToolR".text = PLY_Inventory.Tool_ID["HandGun"]["dys name"]
			%"Desc ToolR".text = str("Ammo: ", PLY_Inventory.Tool_ID["HandGun"]["Ammo"], " // Mags: ", PLY_Inventory.Tool_ID["HandGun"]["Mag"])
		
		"AssaultRifle":
			HUD_Visibility(%"Tool R", %"Name ToolR", %"Desc ToolR", "Visible")
			%"Name ToolR".text = PLY_Inventory.Tool_ID["AssaultRifle"]["dys name"]
			%"Desc ToolR".text = "tasty coconut :3"
	
	match PLY_Inventory.Inv_ToolL_Equiped:
		"null":
			%"Name ToolL".text = "Unequipped"
			%"Desc ToolL".text = "<nothing>"
			Side_Menu_Overlay_Update()
	
		"HandGun":
			HUD_Visibility(%"Tool L", %"Name ToolL", %"Desc ToolL", "Visible")
			%"Name ToolL".text = PLY_Inventory.Tool_ID["HandGun"]["dys name"]
			%"Desc ToolL".text = str("Ammo: ", PLY_Inventory.Tool_ID["HandGun"]["Ammo"], " // Mags: ", PLY_Inventory.Tool_ID["HandGun"]["Mag"])
		"AssaultRifle":
			HUD_Visibility(%"Tool L", %"Name ToolL", %"Desc ToolL", "Visible")
			%"Name ToolL".text = PLY_Inventory.Tool_ID["AssaultRifle"]["dys name"]
			%"Desc ToolL".text = str("Ammo: ", PLY_Inventory.Tool_ID["AssaultRifle"]["Ammo"], " // Mags: ", PLY_Inventory.Tool_ID["AssaultRifle"]["Mag"])
	
	match PLY_Inventory.Cycle_Uitem_Active:
		"null":
			%"Name UItem".text = "Unequipped"
			%"Desc UItem".text = "<nothing>"
			Side_Menu_Overlay_Update()
	
		"Sigil":
			HUD_Visibility(%UItem, %"Name UItem", %"Desc UItem", "Visible")
			%"Name UItem".text = PLY_Inventory.UItem_ID["Sigil"]["dys name"]
			%"Desc UItem".text = "Not enough..."
		"Glass Flask":
			HUD_Visibility(%UItem, %"Name UItem", %"Desc UItem", "Visible")
			%"Name UItem".text = PLY_Inventory.UItem_ID["Glass Flask"]["dys name"]
			%"Desc UItem".text = str("Uses: ", PLY_Inventory.UItem_ID["Glass Flask"]["quantity"])

func HUD_Visibility(Icon, Name, Description, State):
	if State == "Visible":
		Icon.self_modulate.a = 1
		Name.self_modulate.a = 1
		Description.self_modulate.a = 1
	elif State == "Invisible":
		Icon.self_modulate.a = 0.5
		Name.self_modulate.a = 0.5
		Description.self_modulate.a = 0.5

func Side_Menu_Overlay_Update():
	%"TL Over".texture = load(PLY_Inventory.Tool_ID[PLY_Inventory.Inv_ToolL_Equiped]["Icon"])
	%"TR Over".texture = load(PLY_Inventory.Tool_ID[PLY_Inventory.Inv_ToolR_Equiped]["Icon"])
	#%"S Over".texture = load(PLY_Inventory.Spell_ID[PLY_Inventory.Inv_Spell_Equiped]["Icon"])
	%"U Over".texture = load(PLY_Inventory.UItem_ID[PLY_Inventory.Cycle_Uitem_Active]["Icon"])
