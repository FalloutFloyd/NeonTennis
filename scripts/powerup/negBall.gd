extends Area2D

signal removeBall

onready var tween = $Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	tween.interpolate_property($Sprite, "modulate", Color(1,0,0, 0), Color(1, 0, 0, 1), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_negBall_body_entered(body):
	if "ball" in body.name:
		SinglePlayerLogic.explosion(self.get_position())
		emit_signal("removeBall")
		$CollisionShape2D.queue_free()
		tween.interpolate_property($Sprite, "modulate", Color(1,0,0, 1), Color(1, 0, 0, 0), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()
		Global.playSound("res://Sound/powerdown.wav", self.get_position(), false, 1, 1)
		$Timer.start()


func _on_Timer_timeout():
	queue_free()
