extends Node3D
var HUD_Prompt: String = "Pickup"

@export_enum("Sword", "Dagger", "AssaultRifle", "HandGun", "=====+=====", "Ammo_A", "Mag_A", "Ammo_C") var Item: String
@export var Ordinary_Quantity: int 
var Item_Type: String

func _ready() -> void:
	$"Debug View".visible = false
	$Particles.visible = true
	match Item:
#region Special Items
		"Sword":
			Item_Type = "Special"
			%Sword.visible = true
		"Dagger":
			Item_Type = "Special"
			%Dagger.visible = true
		"AssaultRifle":
			Item_Type = "Special"
			%Assault.visible = true
		"HandGun":
			Item_Type = "Special"
			%"Hand Gun".visible = true
#endregion
#region Ordinary Items
		"Ammo_A":
			Item_Type = "Ordinary"
			
		"Mag_A":
			Item_Type = "Ordinary"
			
		"Ammo_C":
			Item_Type = "Ordinary"
			
#endregion

func HUD_Element():
	return HUD_Prompt

func Iteraction():
	SignalBus.emit_signal("item_transfer", Item, Item_Type, Ordinary_Quantity)
	#print(Item)
	#print(Item_Type)
	#print(Ordinary_Quantity)
	%"Pick Up".play()
	$Collision.set_collision_layer_value(3, false)
	$Particles.emitting = false
	$Models.visible = false
