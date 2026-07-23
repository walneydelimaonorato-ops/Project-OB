extends Control

var STX_bus = AudioServer.get_bus_index("STX")
var SFX_bus = AudioServer.get_bus_index("SFX")

var Menu_Active: String
var Menu_Type: String = ""
var Master_Icon: String
var Icon1: String
var Icon2: String

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	
	Hints_Matchup()
	%"Page Main".visible = true
	%"Page Start".visible = false
	%"Page Options".visible = false
	%"SubPage Input Showcase".visible = false

func Menu_Matchup(Switch_To_Menu: String):
	%"Page Main".visible = false
	%"Page Start".visible = false
	%"Page Options".visible = false
	%"SubPage Input Showcase".visible = false
	
	match Switch_To_Menu:
		"Main":
			%"Menu forward".play()
			Menu_Active = Switch_To_Menu
			%"Page Main".visible = true
		"Start":
			%"Menu forward".play()
			Menu_Active = Switch_To_Menu
			%"Page Start".visible = true
		"Options":
			%"Menu forward".play()
			Menu_Active = Switch_To_Menu
			%"Page Options".visible = true
		"Sub Control Layout":
			%"Menu forward".play()
			%"Page Options".visible = true
			print("\r")
			print(%"SubPage Input Showcase".visible)
			%"SubPage Input Showcase".visible = !%"SubPage Input Showcase".visible
			print(%"SubPage Input Showcase".visible)
			print("\r")

func Hints_Matchup():
	match Global.Player_Data.Control_Mode:
		"Key":
			Master_Icon = "uid://clom51u3qv08t"
			Icon1 = "uid://c4pcxjw2avyi8"
			Icon2 = "uid://ccyq52iqsllv1"
		"Joy":
			Master_Icon = "uid://coayw8b5mdpen"
			Icon1 = "uid://dc1xk808sl8if"
			Icon2 = "uid://b7k14ccnc0d7h"
	
	if Global.Player_Data.Control_Mode == "Key" or Global.Player_Data.Control_Mode == "Joy":
		%Hints.text = "[img=30]" + Icon1 + "[/img]: Select // [img=30]" + Icon2 + "[/img]: Return"
		%"Control Type Icon".text = "[img=30]" + Master_Icon + "[/img]"
	
	else:
		%Hints.text = "Control type error"

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("In_Mouse_R"):
		match Menu_Active:
			"Start":
				Menu_Matchup("Main")
			"Options":
				Menu_Matchup("Main")
			_:
				pass
		%"Menu backwards".play()

#region Transporting Buttons
func start_pressed() -> void:
	Global.Next_Scene = "uid://1vffiiuaho52"
	get_tree().change_scene_to_packed(Global.Load_New)

func options_pressed() -> void:
	Menu_Matchup("Options")

func exit_pressed() -> void:
	get_tree().quit()

func control_layout_pressed() -> void:
	Menu_Matchup("Sub Control Layout")
#endregion



#region Music Loop
func _on_title_music_intro_finished() -> void:
	%"Title Music Loop".play()

func _on_title_music_loop_finished() -> void:
	%"Title Music Loop".play()
#endregion


func control_type_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		Global.Player_Data.Control_Mode = "Key"
	elif toggled_on == false:
		Global.Player_Data.Control_Mode = "Joy"
	Hints_Matchup()

func music_toggle(toggled_on: bool) -> void:
	if toggled_on == true:
		AudioServer.set_bus_mute(STX_bus, true)
		%"Music Toggle Icon".text = "[img=30]uid://ca4epqslbci2x[/img]"
	if toggled_on == false:
		AudioServer.set_bus_mute(STX_bus, false)
		%"Music Toggle Icon".text = "[img=30]uid://dlkmikw71v145[/img]"

func sound_effect_toggle(toggled_on: bool) -> void:
	if toggled_on == true:
		AudioServer.set_bus_mute(SFX_bus, true)
		%"Sound Effect Toggle".text = "[img=30]uid://dc643h5meq1bd[/img]"
	if toggled_on == false:
		AudioServer.set_bus_mute(SFX_bus, false)
		%"Sound Effect Toggle".text = "[img=30]uid://d255fqfvrcc7g[/img]"
