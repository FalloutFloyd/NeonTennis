extends Control

onready var MUTE = $CenterContainer/VBoxContainer/mute
onready var BACK = $CenterContainer/VBoxContainer/TextureButton
onready var SFX = $CenterContainer/VBoxContainer/HSlider
onready var MUSIC = $CenterContainer/VBoxContainer/HSlider2

var selection = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	MUTE.pressed = Global.mutePressed
	
	SFX.value = SinglePlayerLogic.SFXvolume
	MUSIC.value = SinglePlayerLogic.MUSICvolume
	
	selection = Global.soundSelection

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Global.soundSelection = selection
	
	if selection > 4:
		selection = 1
	elif selection < 1:
		selection = 4
	
	if selection == 1:
		MUTE.grab_focus()
	elif selection == 2:
		SFX.grab_focus()
	elif selection == 3:
		MUSIC.grab_focus()
	elif selection == 4:
		BACK.grab_focus()
	
	SinglePlayerLogic.SFXvolume = SFX.value
	SinglePlayerLogic.MUSICvolume = MUSIC.value
	
	if $Timer.get_time_left() == 0:
		input()
	
	if MUTE.is_pressed():
		Global.mute = true
		Global.mutePressed = true
	else:
		Global.mute = false
		Global.mutePressed = false

func input():
	if Input.is_action_pressed("menu_up"):
		selection -= 1
		$Timer.start()
	elif Input.is_action_pressed("menu_down"):
		selection += 1
		$Timer.start()
		
	if selection == 2 and Input.is_action_pressed("menu_left"):
		SFX.value -= 2.5
		$Timer.start()
	elif selection == 2 and Input.is_action_pressed("menu_right"):
		SFX.value += 2.5
		$Timer.start()
		
	if selection == 3 and Input.is_action_pressed("menu_left"):
		MUSIC.value -= 2.5
		$Timer.start()
	elif selection == 3 and Input.is_action_pressed("menu_right"):
		MUSIC.value += 2.5
		$Timer.start()

func _on_TextureButton_pressed():
	get_tree().change_scene(Preload.settings)
