extends Control

var selection = 1

onready var GRAPH = $CenterContainer/VBoxContainer/graphics
onready var SOUND = $CenterContainer/VBoxContainer/sound
onready var GAME = $CenterContainer/VBoxContainer/gameplay
onready var CRED = $CenterContainer/VBoxContainer/credits
onready var BACK = $CenterContainer/VBoxContainer/back

# Called when the node enters the scene tree for the first time.
func _ready():
	SinglePlayerLogic.CurrentMode = "OPTIONS"
	selection = Global.settingsSelection

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):	
	Global.settingsSelection = selection
	
	if selection > 5:
		selection = 1
	elif selection < 1:
		selection = 5

	if selection == 1:
		GRAPH.grab_focus()
	elif selection == 2:
		SOUND.grab_focus()
	elif selection == 3:
		GAME.grab_focus()
	elif selection == 4:
		CRED.grab_focus()
	else:
		BACK.grab_focus()
	
	if $Timer.get_time_left() == 0:
		input()
	print($Timer.get_time_left())
	
func input():
	if Input.is_action_pressed("menu_up"):
		selection -= 1
		Global.playSound("res://Sound/select.wav", Vector2(1920/2, 1080/2), true, 1, 1.2)
		$Timer.start()
	elif Input.is_action_pressed("menu_down"):
		selection += 1
		Global.playSound("res://Sound/select.wav", Vector2(1920/2, 1080/2), true, 1, 1.2)
		$Timer.start()
		


func _on_graphics_pressed():
	get_tree().change_scene(Preload.graphics)


func _on_back_pressed():
	Settings.saveEverything()
	get_tree().change_scene(Preload.menu)


func _on_sound_pressed():
	get_tree().change_scene(Preload.sound)


func _on_credits_pressed():
	get_tree().change_scene(Preload.credits)


func _on_gameplay_pressed():
	get_tree().change_scene(Preload.gameplay)
