extends Node2D

#referencing multiple nodes to maybe use later
onready var paddle1 = $paddle1/Paddle1
onready var paddle2 = $paddle2/Paddle2
onready var paddle1Sprite = $paddle1/Paddle1/Sprite
onready var paddle2Sprite = $paddle2/Paddle2/Sprite
onready var scoreCount = $GUI/Label
onready var liveCount = $GUI/Score
onready var ballSpawn = $ballSpawn
onready var timer = $ballTimer
onready var gameOver = $GameOver
onready var gameOverText = $GameOver/CenterContainer/Label
onready var powerupTimer = $powerupTimer


var i = 1

#defines the score as 0, lives as 4 and number of balls as 1
var lives = 4
var ballCount = 1

#checks if the game is over
var lost = false



func _ready():	
	SinglePlayerLogic.score = 0
	SinglePlayerLogic.CurrentMode = "SP"
	timer.wait_time = Global.rng.randi_range(5, 15)
	timer.start()
	
	$AudioStreamPlayer.volume_db = linear2db(Settings.MUSICvolume)
	
	if !Settings.mute:
		$AudioStreamPlayer.play()
	else: 
		pass
	
	Global.rng.randomize()
	
	var spawnTime = Global.rng.randi_range(10,20)
	powerupTimer.wait_time = spawnTime
	powerupTimer.start()
func _physics_process(_delta):
	#the forces(?) for both paddles along with speeds
	var pad1Pos = Vector2(0,0)
	var pad2Pos = Vector2(0,0)
	
	var speed = 1500
	var dir1 = Input.get_action_strength("pad1_down") - Input.get_action_strength("pad1_up")
	var dir2 = Input.get_action_strength("pad2_down") - Input.get_action_strength("pad2_up")
			
#
#	if Input.is_action_just_pressed("screenie"):
#		i += 1
#		var image = get_viewport().get_texture().get_data()
#		image.flip_y()
#		image.save_png("res://screenshot" + str(i) + ".png")
	
	pad1Pos.y = speed * dir1
	pad2Pos.y = speed * dir2
	
	#actually moves the paddles
	pad1Pos = paddle1.move_and_slide(pad1Pos)
	pad2Pos = paddle2.move_and_slide(pad2Pos)
	
	#changes the score counter
	scoreCount.set_text(str(SinglePlayerLogic.score))
	#calls function to set lives
	update_lives()
	#constantly checks for loss condition
	loss_handling()
	
	
	paddle1Sprite.modulate = Color(SinglePlayerLogic.RGB[0], SinglePlayerLogic.RGB[1], SinglePlayerLogic.RGB[2], 1)
	paddle2Sprite.modulate = Color(SinglePlayerLogic.RGB[0], SinglePlayerLogic.RGB[1], SinglePlayerLogic.RGB[2], 1)

#change the lives text
func update_lives():
	if(lives == 4):
		liveCount.set_text("")
	elif(lives == 3):
		liveCount.set_text("X")
	elif(lives == 2):
		liveCount.set_text("XX")
	elif(lives == 1):
		liveCount.set_text("XXX")


#increases score on collision
func _on_Pad1Score_body_entered(body):
	if "ball" in body.name and !lost:
		SinglePlayerLogic.score += 1
		Input.start_joy_vibration(0,0.7,0.7,0.2)
		var sound = Global.rng.randi_range(1,2)
		if sound == 1:
			Global.playSound("res://Sound/score.wav", $paddle1/Paddle1.get_position(), false, 1, 1)
		else:
			Global.playSound("res://Sound/score2.wav", $paddle1/Paddle1.get_position(), false, 1, 1)

#increases score on collision
func _on_Pad2Score_body_entered(body):
	if "ball" in body.name and !lost:
		SinglePlayerLogic.score += 1
		var sound = Global.rng.randi_range(1,2)
		if sound == 1:
			Global.playSound("res://Sound/score.wav", $paddle2/Paddle2.get_position(), false, 1, 1)
		else:
			Global.playSound("res://Sound/score2.wav", $paddle2/Paddle2.get_position(), false, 1, 1)

#MORE BALL
func _on_ballTimer_timeout():
	if(ballCount < 5):
		ballCount +=1
		var newBall = Preload.ball.instance()
		#add_child(newBall)
		call_deferred("add_child", newBall)
		newBall.set_position(ballSpawn.get_position())
		SinglePlayerLogic.explosion(ballSpawn.get_position())
		timer.wait_time = Global.rng.randi_range(15, 17)
		timer.start()

#checks if ball hit left lose
func _on_loseLeft_body_entered(body):
	if "ball" in body.name:
		ballCount -= 1
		lives -= 1

#checks if ball hit right lose
func _on_loseRight_body_entered(body):
	if "ball" in body.name:
		ballCount -= 1
		lives -= 1

#sets lost to true if num of balls < 1 or lives < 1
func loss_handling():
	if ballCount < 1 or lives < 1 and !lost:
		$AudioStreamPlayer/Tween.interpolate_property($AudioStreamPlayer, "volume_db", linear2db(Settings.MUSICvolume), linear2db(0), 3, Tween.TRANS_LINEAR,Tween.EASE_IN, 0)
		$AudioStreamPlayer/Tween.start()
		lost = true 
		
	#sets gameover screen to true and starts timer to go back to menu
	if lost:
		gameOver.visible = true
		gameOverText.set_text("YOU LOSE\nYOU SCORED: "+str(SinglePlayerLogic.score))
		if SinglePlayerLogic.score > SinglePlayerLogic.topScore:
			SinglePlayerLogic.topScore = SinglePlayerLogic.score
		if($GameOver/MenuTimer.is_stopped()):
			Global.playSound("res://Sound/lose.wav", Vector2(1920/2, 1080/2), false, 1, 1)
			Input.start_joy_vibration(0,1,1,1)
			$GameOver/MenuTimer.start()

#returns to menu
func _on_MenuTimer_timeout():
	get_tree().change_scene("res://Scenes/menu.tscn")


func _on_powerupTimer_timeout():
	var spawnTime = Global.rng.randi_range(15, 30)
	powerupTimer.wait_time = spawnTime
	powerupTimer.start()
	
	var powerup = Global.rng.randi_range(1, 6)
	
	if powerup == 1:
		var NB = Preload.negBall.instance()
		add_child(NB)
		var randX = Global.rng.randi_range(480, 1440)
		var randY = Global.rng.randi_range(200,900)
		NB.set_position(Vector2(randX, randY))
		SinglePlayerLogic.explosion(Vector2(randX, randY))
		NB.connect("removeBall", self, "_removeBall")
	elif powerup == 2:
		var AB = Preload.addBall.instance()
		add_child(AB)
		var randX = Global.rng.randi_range(480, 1440)
		var randY = Global.rng.randi_range(200,900)
		AB.set_position(Vector2(randX, randY))
		SinglePlayerLogic.explosion(Vector2(randX, randY))
		AB.connect("addBall", self, "_addBall")
	elif powerup == 3:
		var AT = Preload.addTen.instance()
		add_child(AT)
		var randX = Global.rng.randi_range(480, 1440)
		var randY = Global.rng.randi_range(200,900)
		AT.set_position(Vector2(randX, randY))
		SinglePlayerLogic.explosion(Vector2(randX, randY))
		AT.connect("add10", self, "_addTen")
	elif powerup == 4:
		var NT = Preload.negTen.instance()
		add_child(NT)
		var randX = Global.rng.randi_range(480, 1440)
		var randY = Global.rng.randi_range(200,900)
		NT.set_position(Vector2(randX, randY))
		SinglePlayerLogic.explosion(Vector2(randX, randY))
		NT.connect("neg10", self, "_removeTen")
	elif powerup == 5:
		var PX = Preload.posLife.instance()
		add_child(PX)
		var randX = Global.rng.randi_range(480, 1440)
		var randY = Global.rng.randi_range(200,900)
		PX.set_position(Vector2(randX, randY))
		SinglePlayerLogic.explosion(Vector2(randX, randY))
		PX.connect("addLife", self, "_addLife")
	elif powerup == 6:
		var NX = Preload.negLife.instance()
		add_child(NX)
		var randX = Global.rng.randi_range(480, 1440)
		var randY = Global.rng.randi_range(200,900)
		NX.set_position(Vector2(randX, randY))
		SinglePlayerLogic.explosion(Vector2(randX, randY))
		NX.connect("negLife", self, "_negLife")

func _removeBall():
	ballCount -= 1
	SinglePlayerLogic.score -= 5
	
func _addBall(pos):
	ballCount += 1
	SinglePlayerLogic.score += 5
	
	var newBall = Preload.ball.instance()
	call_deferred("add_child", newBall)
	newBall.set_position(pos)
	
func _addTen():
	SinglePlayerLogic.score += 10
	
func _removeTen():
	SinglePlayerLogic.score -= 10 

func _addLife():
	if lives >= 4:
		return
	else:
		lives += 1

func _negLife():
	lives -= 1