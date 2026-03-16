extends Control

@onready var property_container : VBoxContainer = $"DB Insight/DB_List"
#@onready var PlayerValue: Node3D = $"../../../../PlayerValues"
var property

var dact = false
var DMenu = 1

func _ready():
	global.debug = self
	visible = false

func _process(delta: float) -> void:
	global.Gdebug_active = dact
	global.Debug_Menu_Page = DMenu
	#if Input.is_action_just_pressed("InD_Heal"):
		#PlayerValue.Heal("Full", 0)
	DMenu = wrapi(DMenu, 1, 4)

func _input(event):
	if event.is_action_pressed("In_Debug"):
		visible = !visible # Show pannel
		dact = !dact
	
	if Input.is_action_pressed("In_Debug_Pu"):
		DMenu += 1
	if Input.is_action_pressed("In_Debug_Pd"):
		DMenu -= 1
	
	elif event.is_action_pressed("In_Joy_Debug"):
		visible = !visible #Show pannel
		dact = !dact

func add_property(title : String, value, order): # Callable function to add to the pannel
	var target
	target = property_container.find_child(title, true, false) # Try find Lable with same name
	if !target: # No Lable for property
		target = Label.new() # Creates new label node
		property_container.add_child(target) # Add node as child to Vbox contaier
		target.name = title # Set name to title
		target.text = target.name + ": " + str(value) # Set text value
	elif visible:
		target.text = title + ": " + str(value) # Update text value
		property_container.move_child(target, order) # Reorder property based on given order
