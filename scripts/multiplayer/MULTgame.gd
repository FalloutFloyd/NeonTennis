extends Node2D

#referencing multiple nodes to maybe use later
onready var paddleOrange = $paddleOrange/PaddleOrange
onready var paddleBlue = $paddleBlue/PaddleBlue
onready var paddle1Sprite = $paddleOrange/PaddleOrange/Sprite
onready var paddle2Sprite = $paddleBlue/PaddleBlue/Sprite
onready var blueScoreLabel = $GUI/blueScore
onready var orangeScoreLabel = $GUI/orangeScore
onready var ballSpawn = $ballSpawn
onready var timer = $ballTimer
onready var gameOver = $GameOver
onready var gameOverText = $GameOver/CenterContainer/Label
onready var powerupTimer = $powerupTimer
onready var gameTimer = $gameTimer
onready var timeLeftLabel= $GUI/TimeLeft

#defines the score as 0, lives as 4 and number of balls as 1
var ballCount = 1

#checks if the game is over
var lost = false

var orangeScore = 0
var blueScore = 0

var blueGrown = false
var orangeGrown = false

var i = 1

func _ready():	
	Global.rng.randomize()
	SinglePlayerLogic.CurrentMode = "MP"
	timer.wait_time = Global.rng.randi_range(10, 20)
	timer.start()
	
	paddle1Sprite.modulate = Color(1,0.5,0, 1)
	paddle2Sprite.modulate = Color(0,0,1, 1)
	
	$AudioStreamPlayer.volume_db = linear2db(Settings.MUSICvolume)
	
	if !Settings.mute:
		$AudioStreamPlayer.play()
	else: 
		pass
	
	
	var spawnTime = Global.rng.randi_range(5,10)
	powerupTimer.wait_time = spawnTime
	powerupTimer.start()
	
	
func _physics_process(delta):
	#the forces(?) for both paddles along with speeds
	var pad1Pos = Vector2(0,0)
	var pad2Pos = Vector2(0,0)
	
	var speed = 1500
	var dir1 = Input.get_action_strength("pad1_down") - Input.get_action_strength("pad1_up")
	var dir2 = Input.get_action_strength("pad2_downMULT") - Input.get_action_strength("pad2_upMULT")
	
#	if Input.is_action_just_pressed("screenie"):
#		i += 1
#		var image = get_viewport().get_texture().get_data()
#		image.flip_y()
#		image.save_png("res://screenshot" + str(i) + ".png")
	
	pad1Pos.y = speed * dir1
	pad2Pos.y = speed * dir2
	
	#actually moves the paddles
	pad1Pos = paddleOrange.move_and_slide(pad1Pos)
	pad2Pos = paddleBlue.move_and_slide(pad2Pos)
	
	
	blueScoreLabel.set_text(str(blueScore))
	orangeScoreLabel.set_text(str(orangeScore))
	

	var timeLeft = str(int(gameTimer.get_time_left()) / 60) + ":" + str(int(gameTimer.get_time_left()) % 60).pad_zeros(2)
	
	timeLeftLabel.set_text(timeLeft)
	
	
	#constantly checks for loss condition
	loss_handling()



#increases score on collision
func _on_Pad1Score_body_entered(body):
	if "ball" in body.name:
		Input.start_joy_vibration(0,0.7,0.7,0.2)
		var sound = Global.rng.randi_range(1,2)
		if sound == 1:
			Global.playSound("res://Sound/score.wav", $paddleOrange/PaddleOrange.get_position(), false, 1, 1)
		else:
			Global.playSound("res://Sound/score2.wav", $paddleOrange/PaddleOrange.get_position(), false, 1, 1)

#increases score on collision
func _on_Pad2Score_body_entered(body):
	if "ball" in body.name:
		var sound = Global.rng.randi_range(1,2)
		if sound == 1:
			Global.playSound("res://Sound/score.wav", $paddleBlue/PaddleBlue.get_position(), false, 1, 1)
		else:
			Global.playSound("res://Sound/score2.wav", $paddleBlue/PaddleBlue.get_position(), false, 1, 1)

#MORE BALL
func _on_ballTimer_timeout():
	if(ballCount < 5):
		ballCount +=1
		var newBall = Preload.MULTball.instance()
		add_child(newBall)
		newBall.set_position(ballSpawn.get_position())
		MultiplayerLogic.explosion(ballSpawn.get_position(), newBall.colour)
		timer.wait_time = Global.rng.randi_range(15, 20)
		timer.start()


func _on_scoreBlue_body_entered(body):
	if "ball" in body.name and !lost:
		ballCount -= 1
		blueScore += 1
		if ballCount <= 0:
			ballCount +=1
			var newBall = Preload.MULTball.instance()
			#add_child(newBall)
			call_deferred("add_child", newBall)
			newBall.set_position(ballSpawn.get_position())
			MultiplayerLogic.explosion(ballSpawn.get_position(), newBall.colour)

func _on_scoreOrange_body_entered(body):
	if "ball" in body.name and !lost:
		ballCount -= 1
		orangeScore += 1
		if ballCount <= 0:
			ballCount +=1
			var newBall = Preload.MULTball.instance()
			#add_child(newBall)
			call_deferred("add_child", newBall)
			newBall.set_position(ballSpawn.get_position())
			MultiplayerLogic.explosion(ballSpawn.get_position(), newBall.colour)

#sets lost to true if num of balls < 1 or lives < 1
func loss_handling():
	if gameTimer.get_time_left() == 0 and !lost:
		$AudioStreamPlayer/Tween.interpolate_property($AudioStreamPlayer, "volume_db", linear2db(Settings.MUSICvolume), linear2db(0), 3, Tween.TRANS_LINEAR,Tween.EASE_IN, 0)
		$AudioStreamPlayer/Tween.start()
		lost = true 
		
	#sets gameover screen to true and starts timer to go back to menu
	if lost:
		gameOver.visible = true
		
		if orangeScore > blueScore:
			gameOverText.modulate = Color(1,0.5,0,1)
			gameOverText.set_text("Orange Wins!")
		elif blueScore > orangeScore:
			gameOverText.modulate = Color(0,0,1,1)
			gameOverText.set_text("Blue Wins!")
		else:
			gameOverText.modulate = Color(1,1,1,1)
			gameOverText.set_text("It's a tie!")
		
		if($GameOver/MenuTimer.is_stopped()):
			Global.playSound("res://Sound/lose.wav", Vector2(1920/2, 1080/2), false, 1, 1)
			Input.start_joy_vibration(0,1,1,1)
			$GameOver/MenuTimer.start()

#returns to menu
func _on_MenuTimer_timeout():
	get_tree().change_scene("res://Scenes/menu.tscn")

#powerup functions. maybe helpful???
func _on_powerupTimer_timeout():
	Global.rng.randomize()
	var spawnTime = Global.rng.randi_range(10, 15)
	powerupTimer.wait_time = spawnTime
	powerupTimer.start()
	
	var powerup = Global.rng.randi_range(1, 17)

	if powerup > 0 and powerup < 6:
		var N1 = Preload.neg1.instance()
		add_child(N1)
		var randX = Global.rng.randi_range(480, 1440)
		var randY = Global.rng.randi_range(200,900)
		N1.set_position(Vector2(randX, randY))
		MultiplayerLogic.explosion(Vector2(randX, randY), N1.colour)
		N1.connect("neg1", self, "_neg1")
	elif powerup > 5 and powerup < 11:
		var A1 = Preload.add1.instance()
		add_child(A1)
		var randX = Global.rng.randi_range(480, 1440)
		var randY = Global.rng.randi_range(200,900)
		A1.set_position(Vector2(randX, randY))
		MultiplayerLogic.explosion(Vector2(randX, randY), A1.colour)
		A1.connect("add1", self, "_add1")
	elif powerup > 10 and powerup < 16:
		var AB = Preload.MULTaddball.instance()
		add_child(AB)
		var randX = Global.rng.randi_range(480, 1440)
		var randY = Global.rng.randi_range(200,900)
		AB.set_position(Vector2(randX, randY))
		MultiplayerLogic.explosion(ballSpawn.get_position(), AB.colour)
		AB.connect("addBall", self, "_addBall")
	elif powerup > 15 and powerup < 18:
		var PG = Preload.paddleGrow.instance()
		add_child(PG)
		var randX = Global.rng.randi_range(480, 1440)
		var randY = Global.rng.randi_range(200,900)
		PG.set_position(Vector2(randX, randY))
		MultiplayerLogic.explosion(ballSpawn.get_position(), PG.colour)
		PG.connect("paddleGrow", self, "_paddleGrow")


func _neg1(colour):
	if colour == "blue":
		blueScore -= 1
	else:
		orangeScore -= 1
		
func _add1(colour):
	if colour == "blue":
		blueScore += 1
	else:
		orangeScore += 1
		
func _addBall(pos):
	ballCount += 1
	var newBall = Preload.MULTball.instance()
	call_deferred("add_child", newBall)
	newBall.set_position(pos)
	
func _paddleGrow(colour):
	if colour == "orange" and !orangeGrown:
		$paddleOrange/AnimationPlayer.play("Grow")
		$paddleOrange/orangeTimer.start()
		orangeGrown = true
		print("agent orange")
	elif colour == "orange" and orangeGrown:
		$paddleOrange/orangeTimer.start()
	elif colour == "blue" and !blueGrown: 
		$paddleBlue/AnimationPlayer.play("Grow")
		$paddleBlue/blueTimer.start()
		blueGrown = true
		print("pee")
	else:
		$paddleBlue/blueTimer.start()

func _on_orangeTimer_timeout():
	$paddleOrange/AnimationPlayer.play("Shrink")
	orangeGrown = false


func _on_blueTimer_timeout():
	$paddleBlue/AnimationPlayer.play("Shrink")
	blueGrown = false
