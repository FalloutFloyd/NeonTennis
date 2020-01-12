extends Node2D

onready var anim = $AnimationPlayer

#plays the splash animation
func _ready():
	anim.play("fade")

#if any button is pressed, takes you to menu
func _input(event):
	if event.is_action_pressed("SkipIntro"):
		get_tree().change_scene(Preload.menu)

#takes you to menu after animation plays
func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene(Preload.menu)
