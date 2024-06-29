extends Node2D
@export var dirt_weight = 0

func toggle_display():
	if self.visible: self.visible = false
	else: self.visible = true

func update_dirt():
	dirt_weight = dirt_weight + 50
	$"CanvasLayer/Dirt container/Dirt weight".text = str(dirt_weight+50) + " kg"
