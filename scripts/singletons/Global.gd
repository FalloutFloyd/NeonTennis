extends Node

var rng = RandomNumberGenerator.new()
var currentInput = "keyboard"

var babbyMode = false
var babbyModePressed = false
var fullscreenPressed = false
var mute = false
var mutePressed = false

var settingsSelection = 1
var soundSelection = 1
var graphicsSelection = 1
var menuSelection = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	
	OS.window_size = OS.get_screen_size() / 1.5
	
	OS.center_window()
	
	OS.window_fullscreen = fullscreenPressed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event is InputEventJoypadMotion or event is InputEventJoypadButton:
		currentInput = "controller"
	else: 
		currentInput = "keyboard"

func playSound(sound, pos, shift, shift1 := 1, shift2 := 1.5):
	if !mute:
		if shift == false:
			var audio = AudioStreamPlayer2D.new()
			add_child(audio)
			audio.connect("finished", self, "_on_audio_finished", [audio])
			audio.set_position(pos)
			audio.volume_db = SinglePlayerLogic.SFXvolume
			audio.stream = load(sound)
			audio.play()
		elif shift == true:
			var audio = AudioStreamPlayer2D.new()
			add_child(audio)
			audio.connect("finished", self, "_on_audio_finished", [audio])
			audio.set_position(pos)
			audio.volume_db = SinglePlayerLogic.SFXvolume
			audio.stream = load(sound)
			audio.pitch_scale = rng.randf_range(shift1,shift2)
			audio.play()
	else:
		pass
	
func _on_audio_finished(audio):
	audio.queue_free()