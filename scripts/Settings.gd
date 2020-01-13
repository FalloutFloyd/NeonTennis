extends Control

var selection = 1

onready var GRAPH = $CenterContainer/VBoxContainer/graphics
onready var SOUND = $CenterContainer/VBoxContainer/sound
onready var CRED = $CenterContainer/VBoxContainer/credits
onready var BACK = $CenterContainer/VBoxContainer/back

# Called when the node enters the scene tree for the first time.
func _ready():
	SinglePlayerLogic.CurrentMode = "OPTIONS"
	selection = Global.settingsSelection

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	Global.settingsSelection = selection
	
	if selection > 4:
		selection = 1
	elif selection < 1:
		selection = 4

	if selection == 1:
		GRAPH.grab_focus()
	elif selection == 2:
		SOUND.grab_focus()
	elif selection == 3:
		CRED.grab_focus()
	else:
		BACK.grab_focus()
	
	if $Timer.get_time_left() == 0:
		input()
	print($Timer.get_time_left())
	
func input():
	if Input.is_action_pressed("menu_up"):
		selection -= 1
		$Timer.start()
	elif Input.is_action_pressed("menu_down"):
		selection += 1
		$Timer.start()
		


func _on_graphics_pressed():
	get_tree().change_scene(Preload.graphics)


func _on_back_pressed():
	get_tree().change_scene(Preload.menu)


func _on_sound_pressed():
	get_tree().change_scene(Preload.sound)


func _on_credits_pressed():
	get_tree().change_scene(Preload.credits)
