extends Node2D

@onready var pathFollow := $Path2D/PathFollow2D
@onready var animationPlayer := $Path2D/PathFollow2D/AnimationPlayer
@onready var sprite := $Path2D/PathFollow2D/Sprite2D
@export var moveSpeed := 100

var lastXPos : float

func _ready() -> void:
	lastXPos = sprite.global_position.x
	animationPlayer.play("flap")

func _process(delta: float) -> void:
	pathFollow.progress += moveSpeed * delta


func _on_hurt_area_2d_area_entered(area: Area2D) -> void:
	if (area.is_in_group("Player") || area.get_parent().is_in_group("Player")):
		GameManager.player._on_hurt(self)
