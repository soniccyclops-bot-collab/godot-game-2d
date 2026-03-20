extends KinematicBody2D

class_name Player

const SPEED = 200.0
const ACCELERATION = 500.0

export var follow_mouse = true
var velocity = Vector2.ZERO

func _ready() -> void:
	if not follow_mouse and has_node("Sprite"):
		$Sprite.modulate = Color.green

func _process(delta: float) -> void:
	var input_dir = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		input_dir.x += 1
	if Input.is_action_pressed("ui_left"):
		input_dir.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_dir.y += 1
	if Input.is_action_pressed("ui_up"):
		input_dir.y -= 1
	
	if input_dir != Vector2.ZERO:
		velocity = velocity.move_toward(input_dir.normalized() * SPEED, ACCELERATION * delta)
		if has_node("Sprite"):
			$Sprite.rotation = velocity.angle()
	else:
		velocity = velocity.move_toward(Vector2.ZERO, ACCELERATION * delta)
	
	velocity = move_and_slide(velocity)
	
	# Follow mouse if enabled
	if follow_mouse and get_viewport():
		var mouse_pos = get_local_mouse_position()
		if mouse_pos.length() > 0:
			$Sprite.rotation = mouse_pos.angle()

func move_to(target: Vector2) -> void:
	var direction = (target - global_position).normalized()
	velocity = direction * SPEED

func stop() -> void:
	velocity = Vector2.ZERO
