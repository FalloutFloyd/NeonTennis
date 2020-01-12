extends Control

onready var RESUME = $MarginContainer/VBoxContainer/Resume
onready var MAIN = $MarginContainer/VBoxContainer/MainMenu
onready var EXIT = $MarginContainer/VBoxContainer/QuitOS

var selection = 1

#grabs resume's focus for controller
func _ready():
	RESUME.grab_focus()

#changes controller focus if you mouse over
func _process(delta):
	if selection > 3:
		selection = 1
	elif selection < 1:
		selection = 3

	if selection == 1:
		RESUME.grab_focus()
	elif selection == 2:
		MAIN.grab_focus()
	else:
		EXIT.grab_focus()
	
	if $Timer.get_time_left() == 0 and visible:
		input()

#when paused, makes the visability and pause the opposite of current value
func _input(event):
	if event.is_action_pressed("pause"):
		get_tree().paused = not get_tree().paused
		visible = not visible

#resumes game
func _on_Resume_pressed():
	get_tree().paused = not get_tree().paused
	visible = not visible

#quits game
func _on_QuitOS_pressed():
	get_tree().quit()
	

#unpauses game and takes you to menu
func _on_MainMenu_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/menu.tscn")

func input():
	if Input.is_action_pressed("menu_up"):
		selection -= 1
		$Timer.start()
	elif Input.is_action_pressed("menu_down"):
		selection += 1
		$Timer.start()