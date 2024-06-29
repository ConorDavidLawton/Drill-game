extends Node2D


func toggle_display():
	if self.visible: self.visible = false
	else: self.visible = true
