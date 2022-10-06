class_name Grid
extends Resource

var tilemap : TileMap

var astar = null
# Vector2i to point_id
var points = {}
# point id to Vector2i
var point_ids = {}

var _unit_positions = {}

func _init():
	astar = AStar2D.new()
	print("grid init")	


func prepare():
	# get all cells used in layer0 for the map
	print("prepare grid from map")
	var used_points = tilemap.get_used_cells(0)
	for point_position in used_points:
		var point_id = astar.get_available_point_id()
		point_ids[point_position] = point_id
		points[point_id] = point_position
		astar.add_point(point_id, point_position)
	_default_connect_all_points()

func to_grid(pos : Vector2i):
	var grid_position = tilemap.local_to_map(pos)
	return grid_position


func from_grid(pos : Vector2i):
	pos = tilemap.to_local(pos)
	var tmp_position = tilemap.map_to_local(pos)
	return tmp_position
	
func move_unit(from, to):
	_unit_positions[from] = false
	_unit_positions[to] = true
	if from != null:
		astar.set_point_disabled(point_ids[from], false)
	if to != null:
		astar.set_point_disabled(point_ids[to], true)
	
func _default_connect_all_points():
	for point_position in point_ids:
		if point_ids.has(point_position + Vector2i.UP):
			astar.connect_points(point_ids[point_position], point_ids[point_position + Vector2i.UP])
		if point_ids.has(point_position + Vector2i.DOWN):
			astar.connect_points(point_ids[point_position], point_ids[point_position + Vector2i.DOWN])
		if point_ids.has(point_position + Vector2i.LEFT):
			astar.connect_points(point_ids[point_position], point_ids[point_position + Vector2i.LEFT])
		if point_ids.has(point_position + Vector2i.RIGHT):
			astar.connect_points(point_ids[point_position], point_ids[point_position + Vector2i.RIGHT])


	
