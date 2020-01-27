extends Control

onready var FULL = $CenterContainer/VBoxContainer/fullscreen
onready var BABBY = $CenterContainer/VBoxContainer/babbyMode
onready var BACK = $CenterContainer/VBoxContainer/TextureButton
onready var SPEED = $CenterContainer/VBoxContainer/SPEED

var selection = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	BABBY.pressed = Settings.babbyMode
	FULL.pressed = Settings.fullscreen
	SPEED.value = Settings.ColourSpeed
	
	
	selection = Global.graphicsSelection

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	Global.graphicsSelection = selection
	
	if selection > 4:
		selection = 1
	elif selection < 1:
		selection = 4
	
	if selection == 1:
		BABBY.grab_focus()
	elif selection == 2:
		FULL.grab_focus()
	elif selection == 3:
		SPEED.grab_focus()
	else:
		BACK.grab_focus()
	
	if $Timer.get_time_left() == 0:
		input()
	
	Settings.ColourSpeed = SPEED.value
	
	if FULL.is_pressed():
		Settings.fullscreen = true
		OS.window_fullscreen = Settings.fullscreen
	else:
		Settings.fullscreen = false
		OS.window_fullscreen = Settings.fullscreen
	
	if BABBY.is_pressed():
		Settings.babbyMode = true
	else:
		Settings.babbyMode = false
		SinglePlayerLogic.RGB[0] = 1
		SinglePlayerLogic.RGB[1] = 0
		SinglePlayerLogic.RGB[2] = 0


func input():
	if Input.is_action_pressed("menu_up"):
		selection -= 1
		Global.playSound("res://Sound/select.wav", Vector2(1920/2, 1080/2), true, 1, 1.2)
		$Timer.start()
	elif Input.is_action_pressed("menu_down"):
		selection += 1
		Global.playSound("res://Sound/select.wav", Vector2(1920/2, 1080/2), true, 1, 1.2)
		$Timer.start()
		
	if selection == 3 and Input.is_action_pressed("menu_left"):
		SPEED.value -= 0.001
		$Timer.start()
	elif selection == 3 and Input.is_action_pressed("menu_right"):
		SPEED.value += 0.001
		$Timer.start()

func _on_TextureButton_pressed():
	get_tree().change_scene(Preload.settings)
