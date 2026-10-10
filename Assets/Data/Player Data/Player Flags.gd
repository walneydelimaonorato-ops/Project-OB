extends Node

func  ready() -> void:
	print_rich("[color=red]Player Flags Working")

var Player_Status_Master: String
var Player_Status_1: String
var Player_Status_2: String
var Player_Status_3: String

var Menus = {
	"Current Menu": "null",
	"Current SubMenu": "null",
	"Ready": false,
	"Selection": false,
	"Keys": false,
	"Rest": false,
}

var Flags = {
	"Moths": 0,
	"Alive": false,
	"Undead": false,
	"Can Save": false,
}

var Perms = {
	"Is Resting": false,
	"Can Rest": true,
	"Can Open Menus": false,
	
	"Can Use Sword": false,
	"Can Use Dagger": false,
	
	"Can Use HandGun": false,
	"Can Use AssaultRifle": false,
	
	"Can Use UItems": false,
	
	"Can Show UI Side": false,
	"Can Show UI Stats": false,
	"Can Show Prompts": false,
	
	"Can Move": false,
	"Can Sprint": false,
	"Can Look": false,
}
