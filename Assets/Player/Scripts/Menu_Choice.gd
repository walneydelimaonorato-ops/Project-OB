extends Node
@onready var PlayerVars: Node = $"../../../../Script Nodes/Player Stats"
# STATSMAN Node = $"../../../../Script Nodes/Stats Management"
@onready var MenuReady: Node = %"Menus (Ready)"

var Local_Confirm_Name: String
var Local_Deny_Name: String
var Local_Adress_Name: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("request_popup", on_request_popup)

func on_request_popup(Choice_Names, Address_From):
	Local_Confirm_Name = Choice_Names.yes_text
	Local_Deny_Name = Choice_Names.no_text
	Local_Adress_Name = Address_From
	#print(Local_Confirm_Name, " ", Local_Deny_Name)
	
	%"Choice Menu".visible = true
	%Stance.text = Choice_Names.stance_text
	%Confirm.text = Choice_Names.yes_text
	%Deny.text = Choice_Names.no_text
	MenuReady.focus_first_visible(%"Yes_No Choice Box")

func on_confirm() -> void:
	var Choice_Answer: String = Local_Confirm_Name
	var Address_To: String = Local_Adress_Name
	SignalBus.emit_signal("reply_popup", Choice_Answer, Address_To)
	%"Choice Menu".visible = false

func on_deny() -> void:
	var Choice_Answer: String = Local_Deny_Name
	var Address_To: String = Local_Adress_Name
	SignalBus.emit_signal("reply_popup", Choice_Answer, Address_To)
	%"Choice Menu".visible = false
