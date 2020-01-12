extends Control

onready var FULL = $CenterContainer/VBoxContainer/fullscreen
onready var BABBY = $CenterContainer/VBoxContainer/babbyMode
onready var BACK = $CenterContainer/VBoxContainer/TextureButton
onready var SPEED = $CenterContainer/VBoxContainer/SPEED

var selection = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	BABBY.pressed = Global.babbyModePressed
	FULL.pressed = Global.fullscreenPressed
	SPEED.value = SinglePlayerLogic.ColourSpeed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
	
	SinglePlayerLogic.ColourSpeed = SPEED.value
	
	if FULL.is_pressed():
		OS.window_fullscreen = true
		Global.fullscreenPressed = true
	else:
		OS.window_fullscreen = false
		Global.fullscreenPressed = false
	
	if BABBY.is_pressed():
		Global.babbyMode = true
		Global.babbyModePressed = true
	else:
		Global.babbyMode = false
		Global.babbyModePressed = false
		SinglePlayerLogic.RGB[0] = 1
		SinglePlayerLogic.RGB[1] = 0
		SinglePlayerLogic.RGB[2] = 0
	if Global.babbyModePressed == true:
		BABBY.pressed = true
	else:
		BABBY.pressed = false

func input():
	if Input.is_action_pressed("menu_up"):
		selection -= 1
		$Timer.start()
	elif Input.is_action_pressed("menu_down"):
		selection += 1
		$Timer.start()
		
	if selection == 3 and Input.is_action_pressed("menu_left"):
		SPEED.value -= 0.001
		$Timer.start()
	elif selection == 3 and Input.is_action_pressed("menu_right"):
		SPEED.value += 0.001
		$Timer.start()

func _on_TextureButton_pressed():
	get_tree().change_scene(Preload.settings)
