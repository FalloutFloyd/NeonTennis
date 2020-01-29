extends Node

#spawnable things
onready var ball = preload("res://Scenes/singleplayer/ball.tscn")
onready var negBall = preload("res://Scenes/powerup/negBall.tscn")
onready var addBall = preload("res://Scenes/powerup/posBall.tscn")
onready var addTen = preload("res://Scenes/powerup/pos10.tscn")
onready var negTen = preload("res://Scenes/powerup/neg10.tscn")
onready var posLife = preload("res://Scenes/powerup/posLife.tscn")
onready var negLife = preload("res://Scenes/powerup/negLife.tscn")
onready var explosion = preload("res://Scenes/explosions/Explosion.tscn")
onready var explosionBlue = preload("res://Scenes/explosions/ExplosionBlue.tscn")
onready var explosionGreen = preload("res://Scenes/explosions/ExplosionGreen.tscn")
onready var explosionPink = preload("res://Scenes/explosions/ExplosionPink.tscn")
onready var explosionLGBT = preload("res://Scenes/explosions/ExplosionLGBT.tscn")
onready var explosionACE = preload("res://Scenes/explosions/ExplosionACE.tscn")
onready var explosionTRANS = preload("res://Scenes/explosions/ExplosionTRANS.tscn")
onready var MULTball = preload("res://Scenes/mutliplayer/ball.tscn")
onready var explosionDIR = preload("res://Scenes/explosions/directional/Explosion.tscn")
onready var explosionBlueDIR = preload("res://Scenes/explosions/directional/ExplosionBlue.tscn")
onready var explosionGreenDIR = preload("res://Scenes/explosions/directional/ExplosionGreen.tscn")
onready var explosionPinkDIR = preload("res://Scenes/explosions/directional/ExplosionPink.tscn")
onready var explosionLGBTDIR = preload("res://Scenes/explosions/directional/ExplosionLGBT.tscn")
onready var explosionACEDIR = preload("res://Scenes/explosions/directional/ExplosionACE.tscn")
onready var explosionTRANSDIR = preload("res://Scenes/explosions/directional/ExplosionTRANS.tscn")

onready var neg1 = preload("res://Scenes/powerup/multiplayer/neg1.tscn")
onready var add1 = preload("res://Scenes/powerup/multiplayer/add1.tscn")
onready var MULTaddball = preload("res://Scenes/powerup/multiplayer/posBall.tscn")
onready var paddleGrow = preload("res://Scenes/powerup/multiplayer/paddleGrow.tscn")

#main scenes
var settings = "res://Scenes/settings.tscn"
var graphics = "res://Scenes/graphics.tscn"
var menu = "res://Scenes/menu.tscn"
var sound = "res://Scenes/sound.tscn"
var SP = "res://Scenes/singleplayer/game.tscn"
var credits = "res://Scenes/credits.tscn"
var MP = "res://Scenes/mutliplayer/game.tscn"
var gameplay = "res://Scenes/gameplay.tscn"

func _ready():
	pass