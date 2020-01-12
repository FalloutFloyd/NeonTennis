extends Control

onready var SP = $MarginContainer/VBoxContainer/VBoxContainer2/Singleplayer
onready var OPT = $MarginContainer/VBoxContainer/VBoxContainer2/Options
onready var EXIT = $MarginContainer/VBoxContainer/VBoxContainer2/Exit

var selection = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	SinglePlayerLogic.CurrentMode = "MENU"
	
	$MarginContainer/VBoxContainer/Label2.set_text("HIGH SCORE: "+str(SinglePlayerLogic.topScore)+"\n\n")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	if selection > 3:
		selection = 1
	elif selection < 1:
		selection = 3

	if selection == 1:
		SP.grab_focus()
	elif selection == 2:
		OPT.grab_focus()
	else:
		EXIT.grab_focus()
	
	if $Timer.get_time_left() == 0:
		input()
	$MarginContainer/VBoxContainer/Label.modulate = Color(SinglePlayerLogic.RGB[0], SinglePlayerLogic.RGB[1], SinglePlayerLogic.RGB[2], 1)
	print(get_global_mouse_position())

func _on_Singleplayer_pressed():
	SinglePlayerLogic.explosion(Vector2(720,620))
	get_tree().change_scene(Preload.SP)

#quits game
func _on_Exit_pressed():
	get_tree().quit()

func _on_Options_pressed():
	SinglePlayerLogic.explosion(Vector2(720,725))
	get_tree().change_scene(Preload.settings)
	
func input():
	if Input.is_action_pressed("menu_up"):
		selection -= 1
		$Timer.start()
	elif Input.is_action_pressed("menu_down"):
		selection += 1
		$Timer.start()