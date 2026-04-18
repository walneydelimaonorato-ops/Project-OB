extends Node
@onready var PlayerVars: Node = $"../../../../Script Nodes/Player Stats"
@onready var StatsMan: Node = $"../../../../Script Nodes/Stats Management"
@onready var MenuReady: Node = %"Menus (Ready)"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("request_popup", on_request_popup)

@warning_ignore("unused_parameter")
func on_request_popup(Choice_Names, source):
	%"Choice Menu".visible = true
	%Stance.text = Choice_Names.stance_text
	%Confirm.text = Choice_Names.yes_text
	%Deny.text = Choice_Names.no_text
	MenuReady.focus_first_visible(%"Yes_No Choice Box")


func on_confirm() -> void:
	var Choice_Answer: bool = true
	SignalBus.emit_signal("reply_popup", Choice_Answer)
	%"Choice Menu".visible = false

func on_deny() -> void:
	var Choice_Answer: bool = false
	SignalBus.emit_signal("reply_popup", Choice_Answer)
	%"Choice Menu".visible = false
