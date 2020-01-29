extends Control

onready var SP = $MarginContainer/VBoxContainer/VBoxContainer2/Singleplayer
onready var MP = $MarginContainer/VBoxContainer/VBoxContainer2/Multiplayer
onready var OPT = $MarginContainer/VBoxContainer/VBoxContainer2/Options
onready var EXIT = $MarginContainer/VBoxContainer/VBoxContainer2/Exit

var selection = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	SinglePlayerLogic.CurrentMode = "MENU"
	$MarginContainer/VBoxContainer/Label2.set_text("HIGH SCORE: "+str(SinglePlayerLogic.topScore)+"\n\n")
	selection = Global.menuSelection
	$AudioStreamPlayer.volume_db = linear2db(Settings.MUSICvolume)
	
	if !Settings.mute:
		$AudioStreamPlayer.play()
	else: 
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$MarginContainer/VBoxContainer/Label.modulate = Color(SinglePlayerLogic.RGB[0], SinglePlayerLogic.RGB[1], SinglePlayerLogic.RGB[2], 1)
	
	Global.menuSelection = selection
	if selection > 4:
		selection = 1
	elif selection < 1:
		selection = 4

	if selection == 1:
		SP.grab_focus()
	elif selection == 2:
		MP.grab_focus()
	elif selection == 3:
		OPT.grab_focus()
	else:
		EXIT.grab_focus()
	
	if $Timer.get_time_left() == 0:
		input()

func _on_Singleplayer_pressed():
	SinglePlayerLogic.explosion(Vector2(720,620))
	$Timer1.start()

func _on_Multiplayer_pressed():
	SinglePlayerLogic.explosion(Vector2(720,668))
	$Timer2.start()

#quits game
func _on_Exit_pressed():
	get_tree().quit()

func _on_Options_pressed():
	SinglePlayerLogic.explosion(Vector2(720,725))
	$Timer3.start()
	
	
func input():
	if Input.is_action_pressed("menu_up"):
		selection -= 1
		Global.playSound("res://Sound/select.wav", Vector2(1920/2, 1080/2), true, 1, 1.2)
		$Timer.start()
	elif Input.is_action_pressed("menu_down"):
		selection += 1
		Global.playSound("res://Sound/select.wav", Vector2(1920/2, 1080/2), true, 1, 1.2)
		$Timer.start()




func _on_Timer1_timeout():
	get_tree().change_scene(Preload.SP)


func _on_Timer2_timeout():
	get_tree().change_scene(Preload.MP)


func _on_Timer3_timeout():
	get_tree().change_scene(Preload.settings)
