extends CharacterBody2D
class_name EnemyBase

@export var max_health := 2

@export var hit_knockback_x := 220.0
@export var hit_knockback_y := -140.0
@export var stun_time := 0.15
@export var receives_knockback := true

var current_health := 0
var is_dead := false
var stunned := false

var gravity = ProjectSettings.get_setting(
	"physics/2d/default_gravity"
)

func _ready():
	current_health = max_health

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func take_damage(amount, source_position = Vector2.ZERO):
	if is_dead:
		return

	current_health -= amount

	var direction = sign(
		global_position.x - source_position.x
	)

	if receives_knockback:
		velocity.x = direction * hit_knockback_x
		velocity.y = hit_knockback_y

	start_stun()

	print(
		name,
		" Vida:",
		current_health
	)

	if current_health <= 0:
		die()


func start_stun():
	print("Stun")
	if stunned:
		return

	stunned = true

	_finish_stun()


func _finish_stun():
	await get_tree().create_timer(
		stun_time
	).timeout

	stunned = false


func die():
	if is_dead:
		return

	is_dead = true

	GameManager.add_enemy_kill()
