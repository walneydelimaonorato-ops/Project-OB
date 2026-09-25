class_name InventoryData
extends Resource

var Wild_Gold_Quantity: int = 0
var Wild_Gold_Quantity_Max: int = 10

var Glass_Flask_Quantity: int = 2
var Glass_Flask_Quantity_Max: int = 3

var Tool_ID = {
	"null": {
		"dys name": " ", 
		"sys name": "Hand",
		"Icon": "uid://qua4cq3ubssm",
		"picked?": true,
		"equipped?": false, 
		"damage": 0, 
		},
	"HandGun": {
		"dys name": "PISS",
		"sys name": "HandGun",
		"Icon": "uid://dev6yasoqfrik",
		"picked?": true,
		"equipped?": false, 
		"damage": 6, 
		"Ammo": 3,
		"Max Ammo": 12,
		"Mag": 0,
		},
	"AssaultRifle": {
		"dys name": "AM-16", 
		"sys name": "AssaultRifle",
		"Icon": "uid://bpdhkde57ipm",
		"picked?": true,
		"equipped?": false, 
		"damage": 15, 
		"Ammo": 3 ,
		"Max Ammo": 20,
		"Mag": 0,
		},
	"Stone Sword": {
		"dys name": "Stone Sword", 
		"sys name": "Stone Sword",
		"Icon": "uid://dxpj1l5ppyrue",
		"picked?": true,
		"equipped?": false, 
		"damage": 20, 
		},
	"Dagger": {
		"dys name": "Le Receveuse", 
		"sys name": "Dagger",
		"Icon": "uid://cxpllkwkj3coo",
		"picked?": false,
		"equipped?": false, 
		"damage": 10,
		},
	"SpecialBow": {
		"dys name": "Sylvanna's Bow", 
		"sys name": "SpecialBow",
		"Icon": "uid://c244x88oddpii",
		"picked?": false,
		"equipped?": false, 
		"damage": 25,
		},
}

var Wear_ID = {
	"null": {
		"dys name": " ", 
		"sys name": "Plain",
		"Icon": "uid://qua4cq3ubssm",
		"picked?": true,
		"equipped?": false, 
		"weight": 0,
		"def. redu.": -5,
		},
	"Upper Mewclad Arm.": {
		"dys name": " ", 
		"sys name": " ",
		"Icon": "",
		"picked?": false,
		"equipped?": false, 
		"weight": 20,
		"def. redu.": 4,
		},
	"Lower Mewclad Arm.": {
		"dys name": " ", 
		"sys name": " ",
		"Icon": "",
		"picked?": false,
		"equipped?": false, 
		"weight": 12,
		"def. redu.": 2,
		}
}

var Spell_ID = {
	"null": {
		"dys name": " ", 
		"sys name": " ",
		"Icon": "",
		"picked?": true,
		"equipped?": false, 
		"quantity": 0,
		"max quantity": 0,
		"damage": 0,
		},
	"PotentiaSolis": {
		"dys name": " ", 
		"sys name": " ",
		"Icon": "uid://baatlbdf0r5c",
		"picked?": true,
		"equipped?": false, 
		"quantity": 6,
		"max quantity": 6,
		#"damage": 20 + Global.Player_Data.Divine_Damage_Bonus,
		},
	"Misericordia": {
		"dys name": " ", 
		"sys name": " ",
		"Icon": "",
		"picked?": true,
		"equipped?": false, 
		"quantity": 2,
		"max quantity": 2,
		"damage": 0,
		},
	"Tywyll": {
		"dys name": " ", 
		"sys name": " ",
		"Icon": "",
		"picked?": true,
		"equipped?": false, 
		"quantity": 10,
		"max quantity": 10,
		#"damage": 10 + Global.Player_Data.Heretic_Damage_Bonus,
		},
	"Sunfire": {
		"dys name": " ", 
		"sys name": " ",
		"Icon": "",
		"picked?": true,
		"equipped?": false, 
		"quantity": 99999,
		"max quantity": 99999,
		"damage": 99999,
		}
}

var Brace_ID = {
	"null": {
		"Icon": "uid://qua4cq3ubssm",
		},
	"Brace Golden": {
		"dys name": " ", 
		"sys name": "Brace Golden",
		"Icon": "uid://davke1oama52w",
		
		"picked?": true,
		"equipped?": false, 
		},
	"Brace Clorophyl": {
		"dys name": " ", 
		"sys name": "Brace Clorophyl",
		"Icon": "",
		
		"picked?": true,
		"equipped?": false, 
		},
	"Brace Power": {
		"dys name": " ", 
		"sys name": "Brace Power",
		"Icon": "",
		
		"picked?": true,
		"equipped?": false, 
		}
}

var UItem_ID = {
	"null": {
		"dys name": " ", 
		"sys name": "null",
		"Icon": "uid://qua4cq3ubssm",
	},
	"Sigil": {
		"dys name": "Sigil of Violence", 
		"sys name": "Sigil",
		"Icon": "uid://di03rqvlhqp7q",
		"picked?": true,
		"equipped?": false,
		
		"heal_values": 0,
		"quantity": 1,
		},
		
	"Glass Flask": {
		"dys name": "Glass Flask", 
		"sys name": "Glass Flask",
		"Model": "",
		"Icon": "uid://13ylgt0ylimp",
		"picked?": true,
		"equipped?": false, 
		
		"heal_values": 8,
		"quantity": Glass_Flask_Quantity,
		},
		
	"Wild Gold": {
		"dys name": " ", 
		"sys name": "Wild Gold",
		"Icon": "uid://v22tjgao7mso",
		"picked?": true,
		"equipped?": false, 
		
		"heal_values": 2,
		"quantity": Wild_Gold_Quantity,
		}
}

var Key_ID = {
	"Beta Key 0": {
		"dys name": "Heavy Stone Key", 
		"sys name": "Beta Key 0",
		"Model": "uid://by8pbcsgkyu2m",
		"Icon": "uid://cd1ktu764nlb4",
		"quantity": 0,
		"picked?": false
	},
}

var Bundle_ID = {
}
