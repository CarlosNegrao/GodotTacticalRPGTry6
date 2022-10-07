extends Node2D

enum State{IDLE, MOVE_START, MOVE_END, ATTACK_START, ATTACK_END}
enum Turn{PLAYER, AI}

@export var grid : Resource

var _turn : Turn
var _turn_number := 0
var _move_start_point : Vector2i
var _move_end_point : Vector2i
var _state := State.IDLE 
var _unit_positions := {}
var _unit = null

@onready var units = $Units

func _ready():
	grid.tilemap = $LevelMap
	grid.prepare()
	for u in units.get_children():
		_snap_units_to_grid(u)
		u.died.connect(_on_unit_died)
		_unit_positions[u.grid_position] = u

func _process(delta):
	if Input.is_action_just_released("left_click"):
		if _state != State.ATTACK_START:
			var pos = get_global_mouse_position()
			var grid_position = grid.to_grid(pos)
			_select_unit(grid_position)


# public methods
# private methods
func _snap_units_to_grid(u):
	u.grid_position = grid.to_grid(u.global_position)
	u.global_position = grid.from_grid(u.grid_position)

func _on_unit_died(u):
	var pos = u.grid_position
	grid.move_unit(pos, null)

func _select_unit(grid_position):
	var tmp = _unit_positions.get(grid_position)
	if _unit != tmp:
		if _unit != null:
			_unit.activated = false
	_unit = tmp
	if _unit != null:
		_unit.activated = true
