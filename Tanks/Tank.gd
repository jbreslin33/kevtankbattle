extends KinematicBody2D

signal shoot
signal health_changed
signal dead

export (PackedScene) var Bullet
export (int) var max_speed
export (float) var rotation_speed
export (float) var gun_cooldown
export (int) var max_health

var velocity = Vector2()
var can_shoot = true
var alive = true
var health

func _ready():
	health = max_health
	emit_signal("health_changed", health * 100/max_health)
	$Timer.wait_time = gun_cooldown

func control(delta):
	pass

func shoot():
	#print("shoot")
	if can_shoot:
		can_shoot = false
		$Timer.start()
		var dir = Vector2(1, 0).rotated($Turret.global_rotation)
		var pos = $Turret/Muzzle.global_position
		emit_signal("shoot", Bullet, $Turret/Muzzle.global_position, dir)

func _physics_process(delta):
	if not alive:
		return
	control(delta)
	move_and_slide(velocity)

func take_damage(amount):
	health -= amount
	emit_signal("health_changed", health * 100/max_health)
	if health <= 0:
		explode()

func explode():
	queue_free()

func _on_Timer_timeout():
	can_shoot = true