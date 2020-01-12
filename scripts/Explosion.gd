extends Particles2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


#kills explosion a bit after fade out. hopefully every PC on earth wont die playing the game.
func _on_Timer_timeout():
	queue_free()
