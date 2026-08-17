extends Node

var monitored_objects: Array[Node] = []
var visible_object: Dictionary = {}

func _ready() -> void:
	print_rich("[color=orange]===========================\rCulling Debug Initialization[/color]")
	var maps = get_tree().get_nodes_in_group("Cull Monitor")
	
	for map in maps:
		print_rich("[color=orange]Found map: ", map.name)
		
		var geometry = map.find_children("*", "GeometryInstance3D", true, false)
		
		for object in geometry:
			monitored_objects.append(object)
			
			object.visibility_changed.connect(ON_vis_chang.bind(object))
			
			if object.visible:
				visible_object[object] = true
	
	print_rich("[color=orange]Total Monitored Actors: ", monitored_objects.size())
	$"../Debug Backdrop/Page 5s/VBoxContainer/Total Actor".text = str("Total: ", monitored_objects.size())
	print_rich("[color=orange]Initial Viaible Actors: ", visible_object.size())
	
	Update()
	
	print_rich("[color=orange]===========================[/color]")

func Update():
	for child: Node in %"Visible Actor List".get_children():
		child.queue_free()
	
	var Header: Label = Label.new()
	Header.text = "Visible Actors:\r================"
	%"Visible Actor List".add_child(Header)
	
	for object in visible_object:
		var Actors: Label = Label.new()
		Actors.text = object.name
		Actors.add_theme_font_size_override("font_size", 7)
		%"Visible Actor List".add_child(Actors)

func ON_vis_chang(object):
	if object.visible:
		visible_object[object] = true
	else:
		visible_object.erase(object)
	
	print("Visibles: ", visible_object.size())
