extends GutTest

var player: Player

func before_each() -> void:
	player = load("res://src/scenes/player.gd").new()
	add_child(player)
	player.position = Vector2(100, 100)

func after_each() -> void:
	player.queue_free()

func test_player_starts_at_position() -> void:
	assert_eq(player.position, Vector2(100, 100))

func test_player_can_move() -> void:
	player.velocity = Vector2(100, 0)
	player._process(0.1)
	assert_gt(player.position.x, 100, "Player should move right")

func test_player_velocity_decelerates() -> void:
	player.velocity = Vector2(200, 0)
	var initial_vel = player.velocity
	player._process(0.1)
	assert_lt(player.velocity.length(), initial_vel.length(), "Velocity should decelerate to stop")

func test_player_stops() -> void:
	player.velocity = Vector2(100, 100)
	player.stop()
	assert_eq(player.velocity, Vector2.ZERO)

func test_player_moves_to_target() -> void:
	player.position = Vector2(0, 0)
	player.move_to(Vector2(100, 100))
	assert_gt(player.velocity.length(), 0, "Velocity should be set toward target")
	assert_true(player.velocity.normalized().is_equal_approx(Vector2(100, 100).normalized()))
