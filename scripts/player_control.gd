extends CharacterBody2D


@export var speed : float = 300.0
@export var jump_velocity : float = -400.0
@export var double_jump_velocity : float = -300.0
#looks for nodes and finds this specific body
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false
var animation_locked : bool = false
var was_in_air : bool = false
var direction : Vector2 = Vector2.ZERO

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		was_in_air = true
	else:
		has_double_jumped = false

		if was_in_air == true :
			land()

	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			#normal jump from floor
			jump()
		elif not has_double_jumped:
			#double jump in air
			velocity.y = double_jump_velocity
			has_double_jumped = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left","right", "up", "down")
	if direction:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	update_facing_direction()

func jump():
	velocity.y = jump_velocity
	animated_sprite.play("jump_air")
	animation_locked = true

func land():
	animated_sprite.play("normal")

func update_facing_direction() :
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true
