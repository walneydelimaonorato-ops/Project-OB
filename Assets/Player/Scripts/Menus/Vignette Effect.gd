extends ColorRect

var Active: bool = false
var Fade: bool = false
var Local_Element: Control

func _ready() -> void:
	print_rich("Vignette Effect Working")
	Vignette(true, %Vignette)

func _process(delta: float) -> void:
	if Active == true:
		if Fade == true and Local_Element.modulate.a >= 0.0001:
			Local_Element.modulate.a = lerp(Local_Element.modulate.a, 0.0, 0.05)
			print(Local_Element.modulate.a)
		
		elif Fade == false and Local_Element.modulate.a <= 0.95:
			Local_Element.modulate.a = lerp(Local_Element.modulate.a, 1.0, 0.05)
			print(Local_Element.modulate.a)
		
		else:
			Vignette(false, Local_Element)
	
	elif Active == false:
		pass

func Vignette(Param1: bool, Element: Control):
	if Param1 == true:
		Local_Element = Element
		Active = true
		
		Fade = !Fade
		if Fade == true:
			Local_Element.modulate.a = 1.0
		elif Fade == false:
			Local_Element.modulate.a = 0.0
			
	elif Param1 == false:
		Active = false
