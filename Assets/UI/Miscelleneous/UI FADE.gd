extends Node

var Active: bool = false
var Fade: bool = false
var Local_Element: Control

func _ready() -> void:
	ExtSigBus.Viggnette.connect(Vignettaaaa)
	Vignette(true, %Vignette)

func _process(delta: float) -> void:
	if Active == true:
		if Fade == true and Local_Element.modulate.a >= 0.01:
			Local_Element.modulate.a = lerp(Local_Element.modulate.a, 0.0, 0.05)
			#print(Local_Element.modulate.a)
		
		elif Fade == false and Local_Element.modulate.a <= 0.95:
			Local_Element.modulate.a = lerp(Local_Element.modulate.a, 1.0, 0.05)
			#print(Local_Element.modulate.a)
		
		else:
			Vignette(false, Local_Element)
	
	elif Active == false:
		pass

func Vignette(Param1: bool, Element: Control):
	Local_Element = Element
	print(Active)
	print(Fade)
	print("\n ")
	if Param1 == true:
		Active = true
		
		Fade = !Fade
		if Fade == true:
			Local_Element.modulate.a = 1.0
		elif Fade == false:
			Local_Element.modulate.a = 0.0
			
	elif Param1 == false:
		if Local_Element.modulate.a <= 0.1:
			Local_Element.visible = false
		Active = false

func Vignettaaaa(Param1: bool):
	Vignette(Param1, %Vignette)
