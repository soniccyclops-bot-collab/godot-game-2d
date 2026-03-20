extends GutTest

var timer: GameTimer

func before_each() -> void:
	timer = GameTimer.new()
	add_child(timer)

func after_each() -> void:
	timer.queue_free()

func test_initial_state() -> void:
	assert_eq(timer.current_phase, "setup")
	assert_eq(timer.elapsed_time, 0.0)
	assert_false(timer.is_running)

func test_start_running() -> void:
	timer.start()
	assert_true(timer.is_running)
	assert_eq(timer.current_phase, "setup")

func test_stop_not_running() -> void:
	timer.start()
	timer.stop()
	assert_false(timer.is_running)

func test_setup_remaining_time() -> void:
	timer.start()
	timer.elapsed_time = 100.0
	var remaining = timer.get_setup_remaining()
	assert_eq(remaining, 800.0)  # 900 - 100

func test_setup_remaining_at_max() -> void:
	timer.start()
	var remaining = timer.get_setup_remaining()
	assert_eq(remaining, 900.0)

func test_setup_remaining_after_transition() -> void:
	timer.start()
	timer.transition_to_invasion()
	var remaining = timer.get_setup_remaining()
	assert_eq(remaining, 0.0, "Should return 0 when not in setup")

func test_invasion_elapsed_time() -> void:
	timer.start()
	timer._set_elapsed_time(950.0)
	assert_eq(timer.current_phase, "invasion")
	var elapsed = timer.get_invasion_elapsed()
	assert_eq(elapsed, 50.0)  # 950 - 900

func test_phase_transition_automatic() -> void:
	timer.start()
	assert_eq(timer.current_phase, "setup")
	
	# Process until setup ends
	timer._process(SETUP_DURATION + 1.0)
	assert_eq(timer.current_phase, "invasion")

func test_is_invasion_phase() -> void:
	timer.start()
	assert_false(timer.is_invasion_phase())
	
	timer.transition_to_invasion()
	assert_true(timer.is_invasion_phase())

func test_invasion_started_signal() -> void:
	var signal_received = false
	timer.invasion_started.connect(func():
		signal_received = true
	)
	
	timer.start()
	timer.transition_to_invasion()
	assert_true(signal_received)

func test_phase_changed_signal() -> void:
	var signal_received = false
	var new_phase = ""
	timer.phase_changed.connect(func(phase):
		signal_received = true
		new_phase = phase
	)
	
	timer.start()
	timer.transition_to_invasion()
	assert_true(signal_received)
	assert_eq(new_phase, "invasion")

func test_double_transition_ignored() -> void:
	timer.start()
	timer.transition_to_invasion()
	assert_eq(timer.current_phase, "invasion")
	
	# This should be idempotent
	timer.transition_to_invasion()
	assert_eq(timer.current_phase, "invasion")

const SETUP_DURATION = 900
