extends CanvasLayer

var bar_red = preload("res://UI/barHorizontal_red_mid 200.png")
var bar_yellow = preload("res://UI/barHorizontal_yellow_mid 200.png")
var bar_green = preload("res://UI/barHorizontal_green_mid 200.png")
var bar_texture

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):

func update_healthbar(value):
	bar_texture = bar_green
	if value < 60:
		bar_texture = bar_yellow
	if value < 25:
		bar_texture = bar_red
	$Margins/Container/HealthBar.texture_progress = bar_texture
	$Margins/Container/HealthBar/Tween.interpolate_property($Margins/Container/HealthBar,
			'value', $Margins/Container/HealthBar.value, value,
			0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Margins/Container/HealthBar/Tween.start()
#	$AnimationPlayer.play("healthbar_flash")