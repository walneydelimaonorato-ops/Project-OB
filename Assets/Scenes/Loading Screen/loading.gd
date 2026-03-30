extends Node2D

@onready var loading_progress: TextureProgressBar = $"Loading Progress"

var progress: Array[float] = []

func _ready() -> void:
	ResourceLoader.load_threaded_request(Global.Next_Scene)

func _process(_delta: float) -> void:
	var Status = ResourceLoader.load_threaded_get_status(Global.Next_Scene, progress)
	
	match Status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			var percentage = progress[0] * 100
			loading_progress.value = percentage
		ResourceLoader.THREAD_LOAD_LOADED:
			var scene = ResourceLoader.load_threaded_get(Global.Next_Scene)
			get_tree().change_scene_to_packed(scene)
