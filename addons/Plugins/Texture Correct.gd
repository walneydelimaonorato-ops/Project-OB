@tool
extends EditorScenePostImport

func _post_import(scene: Node) -> Object:
	print_rich("[color=purple]Texture Correction Pluggin Activated[/color]")
	Process_Node(scene)
	return scene

func Process_Node(node):
	if node is MeshInstance3D:
		var Mesh_Instance := node as MeshInstance3D
		var mesh := Mesh_Instance.mesh
		
		if Mesh_Instance.name == "_Collision":
			print("BOOBIES")
			
		for surface in mesh.get_surface_count():
			var material = mesh.surface_get_material(surface)
			print_rich("[color=purple]Material:[/color]", "[color=red]", material, "[/color]")
			
			if material is StandardMaterial3D:
				var Copy_Material = material.duplicate()
				Copy_Material.metallic_specular = 0.0
				
				node.set_surface_override_material(surface, Copy_Material)
			
			#print(material)
	
	
	
	for child in node.get_children():
		Process_Node(child)


#
#func _enable_plugin() -> void:
	## Add autoloads here.
	#pass
#
#
#func _disable_plugin() -> void:
	## Remove autoloads here.
	#pass
#
#
#func _enter_tree() -> void:
	## Initialization of the plugin goes here.
	#pass
#
#
#func _exit_tree() -> void:
	## Clean-up of the plugin goes here.
	#pass
