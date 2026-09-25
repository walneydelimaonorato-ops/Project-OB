extends Node

func _ready() -> void:
	BugBus.Report.connect(Reporting)
	%"Player Report".text = "Reporting Player"
	%"Map Report".text = "Reporting Map"
	%"Actor Report".text = "Reporting Actor"

func Reporting(Target: String, Report: String):
	var Repo: TextEdit
	
	match Target:
		"Player":
			Repo = %"Player Report"
		"Map":
			Repo = %"Map Report"
		"Actor":
			Repo = %"Actor Report"
	
	Repo.text += str("\n|", Engine.get_frames_drawn(), "|", Report)

func board_tabs_changed(tab: int) -> void:
	%"Player Report".visible = false
	%"Map Report".visible = false
	%"Actor Report".visible = false
	
	match tab:
		0:
			%"Player Report".visible = true
		1:
			%"Map Report".visible = true
		2:
			%"Actor Report".visible = true
