extends Node2D
#how fast Sunny moves
var movement : float = 250
#moves constantly to the right 
func _process(delta: float) -> void:
	position.x += movement * delta
# up and down if pressed up or down 
	if Input.is_action_pressed("Up"):
		position.y -= movement * delta
	if Input.is_action_pressed("Down"):
		position.y += movement * delta
#keep Sunny inside y bounds 
	position.y = clamp(position.y, 0, 720)

#makes colition with obstacles
func _on_area_2d_body_entered(body):
	#when touch, reload scene
	get_tree().reload_current_scene()

#Okay Ichi don't forget, you are making the cutscenes to implement them straight away
#We have basic movement, up and down, it moves to the side.
#Sunny can colide with obstacles now, we need to draw more obstacles 
# Feather system, half build, finish that first.
