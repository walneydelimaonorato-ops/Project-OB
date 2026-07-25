extends Node

var Library = {
	NPC_TEST_INTRODUCTION = {
		BOOK1 = {
			"LINE": "This is a test introduction",
			"VOICE": "res://Assets/Dialogue/TEST NPC/NPC_TEST_INTRODUCTION_001.mp3",
			"PROCEED": "NEXT",
			"NEXT": "BOOK2",
		},
		BOOK2 = {
			"LINE": "This is an example of the next line",
			"VOICE": "res://Assets/Dialogue/TEST NPC/NPC_TEST_INTRODUCTION_001.mp3",
			"PROCEED": "NEXT",
			"NEXT": "BOOK3",
		},
		BOOK3 = {
			"LINE": "Pretty neat, right?",
			"VOICE": "res://Assets/Dialogue/TEST NPC/NPC_TEST_INTRODUCTION_001.mp3",
			"PROCEED": "SPLIT",
			"ADDRESS": "NPC_TEST_INTRODUCTION",
			"CHOICE NAME": "...",
			"CONFIRM": "Absolutelly",
			"DENY": "Not really...",
			"PASS A": "BOOK4A",
			"PASS B": "BOOK4B",
		},
		BOOK4A = {
			"LINE": "Awesome, I know",
			"VOICE": "res://Assets/Dialogue/TEST NPC/NPC_TEST_INTRODUCTION_001.mp3",
			"PROCEED": "NEXT",
			"NEXT": "BOOK5A",
		},
		BOOK4B = {
			"LINE": "Really? It might not look like much",
			"VOICE": "res://Assets/Dialogue/TEST NPC/NPC_TEST_INTRODUCTION_001.mp3",
			"PROCEED": "NEXT",
			"NEXT": "BOOK5B",
		},
		BOOK5A = {
			"LINE": "It took SO MUCH to put together",
			"VOICE": "res://Assets/Dialogue/TEST NPC/NPC_TEST_INTRODUCTION_001.mp3",
			"PROCEED": "NEXT",
			"NEXT": "BOOK6",
		},
		BOOK5B = {
			"LINE": "But this spent 3 days in the oven!",
			"VOICE": "res://Assets/Dialogue/TEST NPC/NPC_TEST_INTRODUCTION_001.mp3",
			"PROCEED": "NEXT",
			"NEXT": "BOOK6",
		},
		BOOK6 = {
			"LINE": "Im probably taking too much of your time",
			"VOICE": "res://Assets/Dialogue/TEST NPC/NPC_TEST_INTRODUCTION_001.mp3",
			"PROCEED": "NEXT",
			"NEXT": "BOOK7",
		},
		BOOK7 = {
			"LINE": "...",
			"VOICE": "res://Assets/Dialogue/TEST NPC/NPC_TEST_INTRODUCTION_001.mp3",
			"PROCEED": "END",
			"NEXT": ""
		}
	}
}

		#BOOK2 = {
			#"LINE": "This is an example of the next line",
			#"VOICE": "res://Assets/Dialogue/TEST NPC/NPC_TEST_INTRODUCTION_001.mp3",
			#"PROCEED": "NEXT",
			#"NEXT": "BOOK3",
		#},
