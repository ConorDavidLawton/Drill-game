extends Node2D


func toggle_paused():
	if get_tree().paused: get_tree().paused = false
	else: get_tree().paused = true
	if $CanvasLayer.visible: $CanvasLayer.visible = false
	else: $CanvasLayer.visible = true


func get_input():
	if Input.is_action_just_pressed("pause"):
		print("Pause")
		toggle_paused()


func _on_resume_pressed():
	toggle_paused()


func _on_settings_pressed():
	pass # Replace with function body.


func _on_main_menu_pressed():
	toggle_paused()
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_exit_game_pressed():
	get_tree().quit()


func _process(delta):
	get_input()
