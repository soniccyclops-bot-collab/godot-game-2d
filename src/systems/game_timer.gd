# Game Timer System
# Manages match phases: Setup (0-900s) -> Invasion (900s+)

class_name GameTimer
extends Node

signal phase_changed(new_phase: String)
signal time_remaining_changed(seconds: int)
signal invasion_started

const SETUP_DURATION = 900  # 15 minutes in seconds

var current_phase: String = "setup"
var elapsed_time: float = 0.0
var is_running: bool = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if not is_running:
		return
	
	elapsed_time += delta
	
	# Check phase transition
	if current_phase == "setup" and elapsed_time >= SETUP_DURATION:
		transition_to_invasion()

func start() -> void:
	is_running = true
	elapsed_time = 0.0
	current_phase = "setup"

func stop() -> void:
	is_running = false

## Get remaining time in setup phase
func get_setup_remaining() -> float:
	if current_phase != "setup":
		return 0.0
	return max(0.0, SETUP_DURATION - elapsed_time)

## Get elapsed time in invasion phase
func get_invasion_elapsed() -> float:
	if current_phase != "invasion":
		return 0.0
	return elapsed_time - SETUP_DURATION

## Check if we're in invasion phase
func is_invasion_phase() -> bool:
	return current_phase == "invasion"

## Transition from setup to invasion
func transition_to_invasion() -> void:
	if current_phase == "invasion":
		return  # Already in invasion
	
	current_phase = "invasion"
	phase_changed.emit("invasion")
	invasion_started.emit()

## Reset for testing
func reset() -> void:
	elapsed_time = 0.0
	current_phase = "setup"
	is_running = false

## For testing: fast forward time
func _set_elapsed_time(seconds: float) -> void:
	elapsed_time = seconds
	if elapsed_time >= SETUP_DURATION and current_phase == "setup":
		transition_to_invasion()
