extends Control

onready var BALL = $CenterContainer/VBoxContainer/ballMovement
onready var BACK = $CenterContainer/VBoxContainer/TextureButton

var selection = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	BALL.pressed = Settings.newMovement
	selection = Global.gameplaySelection

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	Global.graphicsSelection = selection
	
	if selection > 2:
		selection = 1
	elif selection < 1:
		selection = 2
	
	if selection == 1:
		BALL.grab_focus()
	else:
		BACK.grab_focus()
	
	if $Timer.get_time_left() == 0:
		input()
	
	
	if BALL.is_pressed():
		Settings.newMovement = true
	else:
		Settings.newMovement = false



func input():
	if Input.is_action_pressed("menu_up"):
		selection -= 1
		Global.playSound("res://Sound/select.wav", Vector2(1920/2, 1080/2), true, 1, 1.2)
		$Timer.start()
	elif Input.is_action_pressed("menu_down"):
		selection += 1
		Global.playSound("res://Sound/select.wav", Vector2(1920/2, 1080/2), true, 1, 1.2)
		$Timer.start()

func _on_TextureButton_pressed():
	get_tree().change_scene(Preload.settings)
