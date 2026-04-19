extends Node2D
#how fast Sunny moves
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape: CollisionShape2D = $Area2D/CollisionShape2D
var current_level : Node
var movement : float = 250
var transitioning : bool = false

func _ready() -> void:
	current_level = Scene_Manager.load_scene("level_1")
	animation_player.play("sunny")
	
func _process(delta: float) -> void:
	position.x += movement * delta
	if Input.is_action_pressed("Up"):
		position.y -= movement * delta
	if Input.is_action_pressed("Down"):
		position.y += movement * delta
	position.y = clamp(position.y, 0, 720)

func _on_area_2d_body_entered(body):
	if transitioning:
		return
	if body.is_in_group("obstacles"):
		transitioning = true
		collision_shape.set_deferred("disabled", true)
		current_level.queue_free()
		current_level = Scene_Manager.load_scene("level_1")
		position = Vector2(0, 360)
		collision_shape.set_deferred("disabled", false)
		transitioning = false
	elif body.is_in_group("feathers"):
		transitioning = true
		collision_shape.set_deferred("disabled", true)
		var cutscene = preload("res://scenes/cutscenes.tscn").instantiate()
		cutscene.next_scene_name = "level_2"
		_switch_to_cutscene.call_deferred(cutscene)

func _switch_to_cutscene(cutscene):
	reparent(get_tree().root)
	get_tree().root.add_child(cutscene)
	get_tree().current_scene = cutscene

func reset_for_new_level(new_level: Node) -> void:
	transitioning = false
	current_level = new_level
	position = Vector2(0, 360)
	collision_shape.set_deferred("disabled", false)
