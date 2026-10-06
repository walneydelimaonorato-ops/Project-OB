extends Node

func _ready() -> void:
	%"Debug Board".visible = false
	BugBus.Report.connect(Reporting)
	%"Player Report".text = ""
	%"Map Report".text = ""
	%"Actor Report".text = ""

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Deb_Context_Menu"):
		%"Debug Board".visible = !%"Debug Board".visible

func Reporting(Target: String, Report: String):
	%"Debug Board".visible = false
	var Repo: TextEdit
	match Target:
		"Player":
			Repo = %"Player Report"
		"Map":
			Repo = %"Map Report"
		"Actor":
			Repo = %"Actor Report"
	
	Repo.text += str(Engine.get_frames_drawn(), " | ", Report, "\n")
