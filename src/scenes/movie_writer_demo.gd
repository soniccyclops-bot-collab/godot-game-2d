extends Node

## Video capture using Godot 4's MovieWriter
## This script starts video recording immediately and quits after duration

var movie_writer: MovieWriter
var recording: bool = false
var start_time: float = 0.0
var duration: float = 4.0  # 4 seconds

func _ready():
	print("MovieWriter demo starting...")
	
	# Start video recording
	movie_writer = MovieWriter.new()
	var err = movie_writer.add_frame(get_viewport())
	if err != OK:
		print("ERROR: Failed to initialize MovieWriter: ", err)
		get_tree().quit()
		return
	
	recording = true
	start_time = Time.get_ticks_msec() / 1000.0
	print("Recording started")

func _process(delta):
	if not recording:
		return
	
	var elapsed = Time.get_ticks_msec() / 1000.0 - start_time
	
	# Add frame to video
	if movie_writer:
		movie_writer.add_frame(get_viewport())
	
	print("Recording... %.1f/%.1f seconds" % [elapsed, duration])
	
	# Stop after duration
	if elapsed >= duration:
		print("Recording complete!")
		movie_writer = null
		recording = false
		get_tree().quit()
