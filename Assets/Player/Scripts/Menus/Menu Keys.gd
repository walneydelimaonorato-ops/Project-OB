extends Node

var Key_Selected: String
var Local_Stamp: String

func _ready() -> void:
	BugBus.emit_signal("Report", "Player", "Menu Keys Working")
	SignalBus.MSelection_Item_Sorting.connect(Keys_Organizing)
	SignalBus.Keys_Stamping.connect(Keys_Stamping)
	%"Keys Menu".visible = false

func Keys_Stamping(Stamp: String):
	Local_Stamp = Stamp

func Keys_Used():
	SignalBus.emit_signal("Keys_Recognition", Local_Stamp, Key_Selected)
	SignalBus.emit_signal("Menu_Setting", "Keys")

func beta_key_0_pressed() -> void:
	if PLY_Inventory.Key_ID["Beta Key 0"]["quantity"] >= 1:
		Key_Selected = "Beta Key 0"
		Keys_Used()
		PLY_Inventory.Key_ID["Beta Key 0"]["quantity"] -= 1
	else:
		SignalBus.emit_signal("Menu_Setting", "Keys")
		SignalBus.emit_signal("Notification", "No keys in hand", 2)

func Keys_Organizing():
	for Keys: TextureButton in %Keys.get_children():
		if Keys.name in ["Start of Keys", "End of Keys", "Key Placeholder"]: 
			continue
		
		Keys.visible = PLY_Inventory.Key_ID[Keys.name]["picked?"]
		
		var Icon = %Icon
		var Name = %Name
		var Count = %Count
		
		if Keys.visible == true:
			Icon.text = str("[img=200]", PLY_Inventory.Key_ID[Keys.name]["Icon"], "[/img]:")
			Name.text = PLY_Inventory.Key_ID[Keys.name]["dys name"]
			Count.text = str("x ", PLY_Inventory.Key_ID[Keys.name]["quantity"])
		elif Keys.visible == false:
			pass
