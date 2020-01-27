extends Area2D


signal paddleGrow(colour)

onready var tween = $Tween

var colour

# Called when the node enters the scene tree for the first time.
func _ready():
	
	tween.interpolate_property(self, "modulate", Color(1,1,1, 0), Color(1, 1, 1, 1), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	
	var randColor = Global.rng.randi_range(1,2)
	print(randColor)
	if randColor == 1:
		colour = "blue"
		$Sprite.modulate = Color(0,0,1,1)
	else:
		colour = "orange"
		$Sprite.modulate = Color(1,0.5,0,1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_paddleGrow_area_entered(area):
	if "ball" in area.name:
		MultiplayerLogic.explosion(self.get_position(), colour)
		emit_signal("paddleGrow", colour)
		$CollisionShape2D.queue_free()
		tween.interpolate_property(self, "modulate", Color(1,1,1, 1), Color(1, 1, 1, 0), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()
		Global.playSound("res://Sound/powerup.wav", self.get_position(), false, 1, 1)
		$Timer.start()


func _on_Timer_timeout():
	queue_free()
