@tool
extends Node

@export var Settup: bool = false:
	set(value):
		if value:
			Node_Settup()
			Settup = false

@export var Sweep: bool = false:
	set(value):
		if value:
			Map_Node_Sweep()
			Sweep = false

func Node_Settup():
	print_rich("\r [color=green]======<NODE SETTUP")
	var Node_Family: Array
	for child: Node in self.get_children():
		Node_Family.append(str(child.name))
		if child.name in ["Player Position", "Player Pos", "Starting Position", "_Player"]:
			child.name = "_Default Spawn"
			var Player = get_tree().get_root().find_child("Player", true, false)
			if Player.GLOBAL_position != child.GLOBAL_position or Player.GLOBAL_rotation.y != child.GLOBAL_rotation.y:
				Player.GLOBAL_position = child.GLOBAL_position
				Player.GLOBAL_rotation.y = child.GLOBAL_rotation.y
				print_rich("[color=pink]PLAYER [color=orange]DEFAULT POSITION SET")
	
	if Node_Family.has("Graves"):
		print_rich("[color=pink]GRAVE NODE [color=Orange]PRESENT")
		if Node_Family.has("Player"):
			var Player = get_tree().get_root().find_child("Player", true, false)
			Player.reparent(get_tree().get_root().find_child("Graves", true, false))
			print_rich("[color=pink]PLAYER [color=green]REPARENTED")
	else:
		var Graves_Node = Node3D.new()
		Graves_Node.name = "Graves"
		self.add_child(Graves_Node)
		Graves_Node.owner = self
		print_rich("[color=pink]GRAVE NODE [color=white]CREATED")

func Map_Node_Sweep():
	print_rich("\r [color=green]======<Map Node Sweep")
	for child: Node in self.get_children():
		if child.name == "Graves":
			continue
		if child.get_child_count() > 0:
			
			for Map_Node: Node in child.get_children():
				
				if Map_Node is NavigationRegion3D:
					Map_Node.position.y = -0.5
					
					for Entity: Node in Map_Node.get_children():
						if Entity is CharacterBody3D:
							Entity.Player_Path = get_tree().get_root().find_child("Player", true, false)
							print(Entity.Player_Path)
					
					if Map_Node.navigation_mesh.get_polygon_count() <= 0:
						print_rich("[color=pink]BAKING NAVIGATION MESH")
						Map_Node.bake_navigation_mesh()
						if not Map_Node.bake_finished.is_connected(Nav_Bake_Done):
							Map_Node.bake_finished.connect(Nav_Bake_Done)
						else:
							pass
					else:
						print_rich("[color=pink]NAVIGATION MESH [color=orange]ALREADY BAKED")
		
		if child is CharacterBody3D:
			if get_tree().get_root().find_child("_NPC Navegation", true, false):
				child.reparent(get_tree().get_root().find_child("_NPC Navegation", true, false))
				print_rich("[color=pink]", child.name, "[color=green] REPARENTED")
			else:
				print_rich("[color=pink]NPC_NAVIGATION [color=red]NOT FOUND")

func Nav_Bake_Done():
	print_rich("[color=pink]NAVEGATION MESH [color=green]BAKED")

func _ready() -> void:
	BugBus.emit_signal("Report", "Map", "Entering Map:")
