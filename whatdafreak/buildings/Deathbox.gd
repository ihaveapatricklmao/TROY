extends Area3D

@onready var Player = $"../Player"
@onready var Point = $"../SendPoint"


func _on_body_entered(body):
	if body == Player:
		Player.global_position = Point.global_position
	
