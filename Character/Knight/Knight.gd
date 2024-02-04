extends CharacterBody2D

class_name Player

signal update_hud(value,HUD)
signal damage_taken(currentHealth)
signal facing_direction_changed(facing_right:bool)
signal toggle_inventory()

@export var inventory_data: InventoryData
@export var equip_inventory_data: InventoryDataEquip
@export var player_base_stats: PlayerStats

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine = $CharacterStateMachine
@onready var heal_particle = $HealParticle
@onready var bounce_raycast = $BounceRaycast

var MOVEMENT_SPEED = 0
var HEALTH = 0
var ATTACK = 0
var ARMOR = 0
var MAGIC = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var facing_right = true
var wallet = 0
var is_inventory_open:bool = false

const HUD = preload("res://Levels/HUD/Hud_enum.gd")
func _ready():
	PlayerManager.player = self
	animation_tree.active = true
	player_base_stats.connect("update_stats", set_stats)
	set_stats()
	update_hud.emit(HEALTH,HUD.STATUS.UPDATE_HEALTH)
	update_hud.emit(ARMOR,HUD.STATUS.UPDATE_ARMOR)

func set_stats():
	MOVEMENT_SPEED = player_base_stats.base_movement_speed
	HEALTH = player_base_stats.base_health
	ATTACK = player_base_stats.base_attack
	ARMOR = player_base_stats.base_armor
	MAGIC = player_base_stats.base_magic
		
func _physics_process(delta):
	if bounce_raycast.is_colliding():
		var collision = bounce_raycast.get_collider()
		if collision.is_in_group('Enemy'):
			#Player jumped on the enemy
			#Kick the player back
			position.x -=  400 * delta
			velocity.y = -300
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	animation_tree.set("parameters/move/blend_position", direction)	
	if direction != 0  && state_machine.check_if_can_move():
		velocity.x = direction * MOVEMENT_SPEED
		#Flip character depending on the direction they're running
		if facing_right != (direction > 0) :
			flip()
		emit_signal("facing_direction_changed", !sprite.flip_h)
	else:
		velocity.x = move_toward(velocity.x, 0, MOVEMENT_SPEED)
	move_and_slide()

func _unhandled_input(event):
	if Input.is_action_pressed("inventory"):
		toggle_inventory.emit()
		is_inventory_open = !is_inventory_open

func flip():
	facing_right = !facing_right
	scale.x = abs(scale.x) *  -1

func addCoin(value):
	wallet += value
	update_hud.emit(wallet,HUD.STATUS.UPDATE_COIN)

func hit(value):
	#Armor will recude the hit by 70%
	if(ARMOR > value * 0.7):
		ARMOR -= value * 0.7
	else:
		ARMOR = 0
	
	if ARMOR > 0:
		HEALTH -= value * 0.3
	else:
		HEALTH -= value
	update_hud.emit(HEALTH,HUD.STATUS.UPDATE_HEALTH)
	update_hud.emit(ARMOR,HUD.STATUS.UPDATE_ARMOR)
	#damage_taken signal used in state anim
	#this only checks if the player is dead 
	emit_signal("damage_taken", HEALTH)

func get_drop_position() -> Vector2:
	var offset = 30
	if !facing_right:
		offset = -30
	return Vector2(position.x + offset,position.y)

##########################
#	CONSUMABLE_FUNCTIONS #
##########################
func heal(value):
	if HEALTH + value > player_base_stats.base_health:
		HEALTH = player_base_stats.base_health
	else:
		HEALTH += value
	update_hud.emit(HEALTH,HUD.STATUS.UPDATE_HEALTH)
	heal_particle.emitting = true

func increase_movement_speed(speed:float, duration: float):
	MOVEMENT_SPEED += speed
	await get_tree().create_timer(duration).timeout
	MOVEMENT_SPEED -= speed
