extends CanvasLayer

var Interact_Prompt: String = "General"
var Valid_Prompt: bool = false

func _ready() -> void:
	print_rich("[color=#ffdf00]Interact Message Working[/color]")
	SignalBus.Sig_Interaction_HUD_Return.connect(Interact_Message_Display)

func _process(_delta: float) -> void:
	%"Interact Prompt".text = "[img=30]" + Global.Player_Data.UnHUDIcon_Interact + "[/img]: " + Interact_Prompt
	if %Ray2.is_colliding():
		SignalBus.emit_signal("Sig_General_Interaction", %Ray2, "HUD_Element")
	if !%Ray2.is_colliding():
		Valid_Prompt = false
	
	%"Interact Prompt".visible = Valid_Prompt

func Interact_Message_Display(Message):
	if Message.get_parent().has_method("HUD_Element"):
		if "HUD_Prompt" in Message.get_parent():
			if Message.get_parent().HUD_Prompt != "":
				Valid_Prompt = true
				Interact_Prompt = Message.get_parent().HUD_Prompt
		else:
			Valid_Prompt = false
			pass
