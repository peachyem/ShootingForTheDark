extends CharacterBody2D
class_name Player


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const double_jump_velocity = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var was_in_air : bool = false
var has_double_jumped : bool = false
var push_force = 80.00

func _ready():
	GameManager.player = self

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		was_in_air = true
	else:
		has_double_jumped = false

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("reset")):
		die()
	pass

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") || Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif not has_double_jumped:
			velocity.y = double_jump_velocity
			has_double_jumped = true


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if velocity.x > 0:
		$Sprite2D.flip_h = true
		$AnimationPlayer.play("Walk")
	elif velocity.x < 0:
		$Sprite2D.flip_h = false
		$AnimationPlayer.play("Walk")
	else:
		$AnimationPlayer.play("RESET")

	move_and_slide()


	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)

func die():
	GameManager.respawn_player()

func _on_hurt(sender: Node):
	if (sender.is_in_group("Spike")):
		die()
	elif (sender.is_in_group("Bat")):
		die()
