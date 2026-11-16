@tool
extends EditorScenePostImport

func _post_import(scene: Node) -> Object:
	print_rich("[color=pink]Player Settup Pluggin Activated[/color] \r")
	Texture_Settup(scene)
	return scene

func Texture_Settup(scene):
	if scene is MeshInstance3D:
		var Mesh_Instance := scene as MeshInstance3D
		var mesh := Mesh_Instance.mesh
			
		for surface in mesh.get_surface_count():
			var material = mesh.surface_get_material(surface)
			print_rich("[color=purple]Material:[color=red] [", material.resource_name, "] ", material)
			
			if material is StandardMaterial3D:
				var Copy_Material = material.duplicate()
				Copy_Material.metallic_specular = 0.0
				
				scene.set_surface_override_material(surface, Copy_Material)
	
	for child in scene.get_children():
		Texture_Settup(child)
	
	for child in scene.get_children():
		Texture_Settup(child)
