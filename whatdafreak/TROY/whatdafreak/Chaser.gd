extends CharacterBody3D
class_name EnemyBase

# onready

@onready var Player = $"../Player"
@onready var Agent = $Agent
@onready var Ray = $RayCast

# info vars

# HEALTH VARS
@export_group("HEALTH STUFF")
@export var hp : int
@export var max_hp : int

# ATTACK VARS
@export_group("ATTACK STUFF")
@export_enum("Attack1","Attack2","Attack3","Attack4") var attack_type: String

# PHYSICS VAR
@export_group("PHYSICS STUFF")
@export_enum("Grounded","Floating") var movement_type: String
@export var speed : float
@export var gravity : float

# ABILITIES
@export_group("SPECIAL ABILITIES")
@export_enum("None","Teleport","ReviveSelf","ReviveOthers") var special_ability : String = ("None")

# pathfinding stuff
var current_target = null

func _ready():
	current_target = Player

func _physics_process(delta):
	
	velocity.y -= gravity * delta
	Agent.set_target_position(current_target.transform.origin)
	Agent.get_final_position()
	var next_path = Agent.get_next_path_position()
	
	global_rotation_degrees = current_target.global_rotation_degrees
	
	if Agent.is_target_reachable() == false:
		print("target is not reachable!")
	
	
	velocity = (next_path - global_position).normalized() * speed*100 * delta
	move_and_slide()
