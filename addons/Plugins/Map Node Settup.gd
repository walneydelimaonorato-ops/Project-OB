@tool
extends EditorScenePostImport

var Scene_Node: Node

func _post_import(scene: Node) -> Object:
	print_rich("[color=pink]Map Settup Pluggin Activated[/color] \r")
	Scene_Node = scene
	
	print_rich("[color=pink]TEXTURE CORRECTION PROCESS")
	Process_Node(scene)
	print_rich("[color=pink]TEXTURE [color=green]CORRECTED")
	
	Create_Collision(scene)
	return scene

func Process_Node(node):
	if node is MeshInstance3D:
		var Mesh_Instance := node as MeshInstance3D
		var mesh := Mesh_Instance.mesh
			
		for surface in mesh.get_surface_count():
			var material = mesh.surface_get_material(surface)
			print_rich("[color=purple]Material:[color=red] [", material.resource_name, "] ", material)
			
			if material is StandardMaterial3D:
				var Copy_Material = material.duplicate()
				Copy_Material.metallic_specular = 0.0
				
				node.set_surface_override_material(surface, Copy_Material)
	
	for child in node.get_children():
		Process_Node(child)

func Create_Collision(node):
	if node.name in ["COLL", "_COLL", "Collision"]:
		print_rich("[color=pink]COLLISION SETTUP PROCESS")
		var Mesh_Instance := node as MeshInstance3D
		
		if Mesh_Instance.name in ["COLL", "_COLL", "Collision"]:
			Mesh_Instance.name = "_Collision"
			print_rich("[color=purple]Collision:[color=red] [", Mesh_Instance.name, "] ", Mesh_Instance)
			
			var Collision_Shape = CollisionShape3D.new()
			Collision_Shape.name = "_Collision Shape"
			Collision_Shape.shape = Mesh_Instance.mesh.create_trimesh_shape()
			print_rich("[color=purple]Collision:[color=red] [", Collision_Shape.name, "] ", Collision_Shape)
			
			var Static_Body = StaticBody3D.new()
			Static_Body.name = "_Collision Static"
			Static_Body.add_child(Collision_Shape)
			print_rich("[color=purple]Collision:[color=red] [", Static_Body.name, "] ", Static_Body)
			
			Mesh_Instance.add_child(Static_Body)
			if Mesh_Instance.get_child_count() > 0:
				Static_Body.owner = Mesh_Instance.owner
				Collision_Shape.owner = Mesh_Instance.owner
				print_rich("[color=pink]COLLISION [color=green]CREATED")
				Mesh_Instance.visible = false
				Create_Navigation_Mesh(Mesh_Instance)
				return true
			else:
				print_rich("[color=pink]COLLISION [color=red]FAILED")
				return true
		
		else:
			print_rich("[color=pink]COLLISION [color=red]NODE NOT FOUND")
			return true
	
	for child in node.get_children():
		if Create_Collision(child):
			return true

func Create_Navigation_Mesh(Collision_Mesh: MeshInstance3D):
	print_rich("[color=pink]NAVEGATION MESH CREATION PROCESS")
	
	var Navegation_Collision = Collision_Mesh.duplicate()
	var Navegation_Path = NavigationRegion3D.new()
	
	Navegation_Path.name = "_NPC Navegation"
	Navegation_Collision.name = "_Navegation Collision"
	
	Scene_Node.add_child(Navegation_Path)
	print_rich("[color=purple]Navegation:[color=red] [", Navegation_Path.name, "] ", Navegation_Path)
	Navegation_Path.add_child(Navegation_Collision)
	print_rich("[color=purple]Navegation:[color=red] [", Navegation_Collision.name, "] ", Navegation_Collision)
	
	Navegation_Path.owner = Scene_Node
	Navegation_Collision.owner = Scene_Node
	
	for child in Scene_Node.get_children():
		if child.name == Navegation_Path.name:
			if child.get_child_count() > 0:
				print_rich("[color=pink]NAVEGATION [color=green]CREATED")
			else:
				print_rich("[color=pink]NAVEGATION [color=red]FAILED")
	
	Navegation_Collision.visible = false
	if Navegation_Path.navigation_mesh == null:
		var Nav_Mesh := NavigationMesh.new()
		Navegation_Path.navigation_mesh = Nav_Mesh
		
	else:
		print_rich("[color=pink]NAVEGATION [color=orange]NEW NAV MESH NOT CREATED")
