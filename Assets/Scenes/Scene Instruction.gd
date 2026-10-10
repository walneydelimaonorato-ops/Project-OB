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
	var Graves: Node3D
	if get_tree().get_root().find_child("Graves", true, false):
		Graves = get_tree().get_root().find_child("Graves", true, false)
	
	for child: Node in self.get_children():
		Node_Family.append(str(child.name))
		
		if child.name.begins_with("Item"):
			if get_tree().get_root().find_child("All Items", true, false):
				child.reparent(get_tree().get_root().find_child("All Items", true, false))
				Node_Settup()
		
		if child.name.begins_with("Door"):
			if get_tree().get_root().find_child("All Doors", true, false):
				child.reparent(get_tree().get_root().find_child("All Doors", true, false))
		
		if child.name.begins_with("Lever") or child.name.begins_with("Lock"):
			if get_tree().get_root().find_child("All Levers & Locks", true, false):
				child.reparent(get_tree().get_root().find_child("All Levers & Locks", true, false))
	
	if Graves:
		print_rich("[color=pink]GRAVE NODE [color=Cyan]PRESENT")
		if !Graves.find_child("All Items", false, false):
			var Items_Node = Node3D.new()
			Items_Node.name = "All Items"
			self.add_child(Items_Node)
			Items_Node.owner = self
			print_rich("[color=pink]ALL ITEMS NODE [color=white]CREATED")
			Items_Node.reparent(Graves)
			Node_Settup()
		else:
			print_rich("[color=pink]ALL ITEMS NODE [color=Orange]PRESENT")
		
		if !Graves.find_child("All Doors", false, false):
			var Doors_Node = Node3D.new()
			Doors_Node.name = "All Doors"
			self.add_child(Doors_Node)
			Doors_Node.owner = self
			print_rich("[color=pink]ALL DOORS NODE [color=white]CREATED")
			Doors_Node.reparent(Graves)
		else:
			print_rich("[color=pink]ALL DOORS NODE [color=Orange]PRESENT")
		
		if !Graves.find_child("All Levers & Locks", false, false):
			var LaL_Node = Node3D.new()
			LaL_Node.name = "All Levers & Locks"
			self.add_child(LaL_Node)
			LaL_Node.owner = self
			print_rich("[color=pink]ALL LEVERS & LOCKS NODE [color=white]CREATED")
			LaL_Node.reparent(Graves)
		else:
			print_rich("[color=pink]ALL LEVERS & LOCKS NODE [color=Orange]PRESENT")
		
		#if !Graves.find_child("", false, false):
			#var _Node = Node3D.new()
			#_Node.name = ""
			#self.add_child(_Node)
			#_Node.owner = self
			#print_rich("[color=pink]ALL  NODE [color=white]CREATED")
			#_Node.reparent(Graves)
		#else:
			#print_rich("[color=pink]ALL  NODE [color=Orange]PRESENT")
		
		if Node_Family.has("Player"):
			var Player = get_tree().get_root().find_child("Player", true, false)
			Player.reparent(Graves)
			print_rich("[color=pink]PLAYER [color=green]REPARENTED")
	else:
		var Graves_Node = Node3D.new()
		Graves_Node.name = "Graves"
		self.add_child(Graves_Node)
		Graves_Node.owner = self
		print_rich("[color=pink]GRAVE NODE [color=CYAN]CREATED")
		Node_Settup()

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
	var Repo: String
	Repo = str("Map: ", GLOBAL.Next_Scene["Name"])
	BugBus.emit_signal("Report", "Map", Repo)
