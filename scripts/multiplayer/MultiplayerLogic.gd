extends Node


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func explosion(pos, colour):
	#buch of logic determining ball colour
	if colour == "orange":
		var expl = Preload.explosion.instance()
		add_child(expl)
		expl.emitting = true
		expl.set_position(pos)
		var sound = Global.rng.randi_range(1,3)
		if sound == 1:
			Global.playSound("res://Sound/explosion1.wav", expl.get_position(), true, 1, 1.5)
		elif sound == 2:
			Global.playSound("res://Sound/explosion2.wav", expl.get_position(), true, 1, 1.5)
		else:
			Global.playSound("res://Sound/explosion3.wav", expl.get_position(), true, 1, 1.5)
	elif colour == "blue":
		var explB = Preload.explosionBlue.instance()
		add_child(explB)
		explB.emitting = true
		explB.set_position(pos)
		var sound = Global.rng.randi_range(1,3)
		if sound == 1:
			Global.playSound("res://Sound/explosion1.wav", explB.get_position(), true, 1, 1.5)
		elif sound == 2:
			Global.playSound("res://Sound/explosion2.wav", explB.get_position(), true, 1, 1.5)
		else:
			Global.playSound("res://Sound/explosion3.wav", explB.get_position(), true, 1, 1.5)
	Input.start_joy_vibration(0, 0.3,0.3,0.2)
	
func explosionDIR(pos, colour, dir):
		#buch of logic determining ball colour
	if colour == "orange":
		var expl = Preload.explosionDIR.instance()
		add_child(expl)
		expl.rotation_degrees = dir
		expl.set_position(pos)
		expl.emitting = true
		var sound = Global.rng.randi_range(1,3)
		if sound == 1:
			Global.playSound("res://Sound/explosion1.wav", expl.get_position(), true, 1, 1.5)
		elif sound == 2:
			Global.playSound("res://Sound/explosion2.wav", expl.get_position(), true, 1, 1.5)
		else:
			Global.playSound("res://Sound/explosion3.wav", expl.get_position(), true, 1, 1.5)
	elif colour == "blue":
		var explB = Preload.explosionBlueDIR.instance()
		add_child(explB)
		explB.set_position(pos)
		explB.rotation_degrees = dir
		explB.emitting = true
		var sound = Global.rng.randi_range(1,3)
		if sound == 1:
			Global.playSound("res://Sound/explosion1.wav", explB.get_position(), true, 1, 1.5)
		elif sound == 2:
			Global.playSound("res://Sound/explosion2.wav", explB.get_position(), true, 1, 1.5)
		else:
			Global.playSound("res://Sound/explosion3.wav", explB.get_position(), true, 1, 1.5)
	Input.start_joy_vibration(0, 0.3,0.3,0.2)