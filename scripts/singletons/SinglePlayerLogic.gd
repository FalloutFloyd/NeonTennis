extends Node

var score
var topScore = 0

var CurrentMode = null

var RGB = [1,0,0]
var phase = 1
var ColourSpeed = 0.001

var SFXvolume = 0
var MUSICvolume = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !Global.babbyMode:
		if CurrentMode == "SP":
			if(phase == 1):
				if(RGB[1] < 1):
					RGB[1] += ColourSpeed
				else:
					phase = 2
			if(phase == 2):
				if(RGB[0] > 0):
					RGB[0] -= ColourSpeed
				else:
					phase = 3
			if(phase == 3):
				if(RGB[2] < 1):
					RGB[2] += ColourSpeed
				else:
					phase = 4
			if(phase == 4):
				if(RGB[1] > 0):
					RGB[1] -= ColourSpeed
				else:
					phase = 5
			if(phase == 5):
				if(RGB[0] < 1):
					RGB[0] += ColourSpeed
				else:
					phase = 6
			if(phase == 6):
				if(RGB[2] > 0):
					RGB[2] -= ColourSpeed
				else:
					phase = 1
	else:
		RGB[0] = 1
		RGB[1] = 1
		RGB[2] = 1


func explosion(pos):
	var colour = Global.rng.randi_range(1,1000)
	#buch of logic determining ball colour
	if colour <= 249.25:
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
	elif colour <= 498.5:
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
	elif colour <= 747.75:
		var explG = Preload.explosionGreen.instance()
		add_child(explG)
		explG.emitting = true
		explG.set_position(pos)
		var sound = Global.rng.randi_range(1,3)
		if sound == 1:
			Global.playSound("res://Sound/explosion1.wav", explG.get_position(), true, 1, 1.5)
		elif sound == 2:
			Global.playSound("res://Sound/explosion2.wav", explG.get_position(), true, 1, 1.5)
		else:
			Global.playSound("res://Sound/explosion3.wav", explG.get_position(), true, 1, 1.5)
	elif colour <= 997:
		var explP = Preload.explosionPink.instance()
		add_child(explP)
		explP.emitting = true
		explP.set_position(pos)
		var sound = Global.rng.randi_range(1,3)
		if sound == 1:
			Global.playSound("res://Sound/explosion1.wav", explP.get_position(), true, 1, 1.5)
		elif sound == 2:
			Global.playSound("res://Sound/explosion2.wav", explP.get_position(), true, 1, 1.5)
		else:
			Global.playSound("res://Sound/explosion3.wav", explP.get_position(), true, 1, 1.5)
	elif colour == 998:
		var explLGBT = Preload.explosionLGBT.instance()
		add_child(explLGBT)
		explLGBT.emitting = true
		explLGBT.set_position(pos)
		var sound = Global.rng.randi_range(1,3)
		if sound == 1:
			Global.playSound("res://Sound/explosion1.wav", explLGBT.get_position(), true, 1, 1.5)
		elif sound == 2:
			Global.playSound("res://Sound/explosion2.wav", explLGBT.get_position(), true, 1, 1.5)
		else:
			Global.playSound("res://Sound/explosion3.wav", explLGBT.get_position(), true, 1, 1.5)
	elif colour == 999:
		var explACE = Preload.explosionACE.instance()
		add_child(explACE)
		explACE.emitting = true
		explACE.set_position(pos)
		var sound = Global.rng.randi_range(1,3)
		if sound == 1:
			Global.playSound("res://Sound/explosion1.wav", explACE.get_position(), true, 1, 1.5)
		elif sound == 2:
			Global.playSound("res://Sound/explosion2.wav", explACE.get_position(), true, 1, 1.5)
		else:
			Global.playSound("res://Sound/explosion3.wav", explACE.get_position(), true, 1, 1.5)
	elif colour == 1000:
		var explTRANS = Preload.explosionTRANS.instance()
		add_child(explTRANS)
		explTRANS.emitting = true
		explTRANS.set_position(pos)
		var sound = Global.rng.randi_range(1,3)
		if sound == 1:
			Global.playSound("res://Sound/explosion1.wav", explTRANS.get_position(), true, 1, 1.5)
		elif sound == 2:
			Global.playSound("res://Sound/explosion2.wav", explTRANS.get_position(), true, 1, 1.5)
		else:
			Global.playSound("res://Sound/explosion3.wav", explTRANS.get_position(), true, 1, 1.5)
	Input.start_joy_vibration(0, 0.3,0.3,0.2)