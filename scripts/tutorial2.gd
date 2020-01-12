extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Tween.interpolate_property(self, "modulate", Color(1,1,1,0), Color(1,1,1,1), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.currentInput == "controller":
		self.texture = load("res://Img/tutorial/tutorialC2.png")
	else:
		self.texture = load("res://Img/tutorial/tutorialK2.png")


func _on_Timer_timeout():
	$Tween2.interpolate_property(self, "modulate", Color(1,1,1,1), Color(1,1,1,0), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween2.start()


func _on_Tween2_tween_completed(object, key):
	self.queue_free()
