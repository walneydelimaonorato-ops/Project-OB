@tool
extends EditorScenePostImport

func _post_import(scene: Node) -> Object:
	print_rich("[color=pink]Texture Correction Pluggin Activated[/color]")
	Create_Collision(scene)
	Process_Node(scene)
	return scene

func Process_Node(node):
	if node is MeshInstance3D:
		var Mesh_Instance := node as MeshInstance3D
		var mesh := Mesh_Instance.mesh
			
		for surface in mesh.get_surface_count():
			var material = mesh.surface_get_material(surface)
			print_rich("[color=purple]Material: [color=red]", material, "[/color]")
			
			if material is StandardMaterial3D:
				var Copy_Material = material.duplicate()
				Copy_Material.metallic_specular = 0.0
				
				node.set_surface_override_material(surface, Copy_Material)
	
	for child in node.get_children():
		Process_Node(child)

func Create_Collision(node):
	if node.name in ["COLL", "_Collision"]:
		print_rich("[color=pink]COLLISION SETTUP PROCESS")
		var Mesh_Instance := node as MeshInstance3D
		
		if Mesh_Instance.name in ["COLL", "_Collision"]:
			Mesh_Instance.name = "_Collision"
			print_rich("[color=purple]Collision: [color=red] [", Mesh_Instance.name, "] ", Mesh_Instance)
			
			var Collision_Shape = CollisionShape3D.new()
			Collision_Shape.name = "_Collision Shape"
			Collision_Shape.shape = Mesh_Instance.mesh.create_trimesh_shape()
			print_rich("[color=purple]Collision: [color=red] [", Collision_Shape.name, "] ", Collision_Shape)
			
			var Static_Body = StaticBody3D.new()
			Static_Body.name = "_Collision Static"
			Static_Body.add_child(Collision_Shape)
			print_rich("[color=purple]Collision: [color=red] [", Collision_Shape.name, "] ", Collision_Shape)
			
			Mesh_Instance.add_child(Static_Body)
			if Mesh_Instance.get_child_count() > 0:
				Static_Body.owner = Mesh_Instance.owner
				Collision_Shape.owner = Mesh_Instance.owner
				print_rich("[color=pink]COLLISION COMPLETED")
				Mesh_Instance.visible = false
				return true
			else:
				print_rich("[color=pink]COLLISION FAILED")
				return true
				
		else:
			print_rich("[color=pink]COLLISION NODE NOT FOUND")
			return true
	
	for child in node.get_children():
		if Create_Collision(child):
			return true
