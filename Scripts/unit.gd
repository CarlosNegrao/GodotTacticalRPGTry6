extends Node2D

signal hp_changed
signal mp_changed
signal died(value)

var grid_position := Vector2i.ZERO
var activated := false :
	set(value):
		animated_sprite.use_parent_material = not value
		activated = value

@onready var animated_sprite := $AnimatedSprite2d
@onready var hp_bar := $Bars/HPBar
@onready var mp_bar := $Bars/MPBar
@onready var stats := $Stats
@onready var equipment := $Equipment

# Called when the node enters the scene tree for the first time.
func _ready():
	stats.setup()
	hp_bar.max_value = stats.Max_HP
	mp_bar.max_value = stats.Max_MP
	hp_bar.value = stats.current_hp
	mp_bar.value = stats.current_mp


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# get stats from the unit, then adds any stat modifier from the equipment
# I considered duplicating the stats, but changed mymind since the overhead
# should be minimal, and makes un-ncessary to update on equipemnt changes
func _get_stat(stat):
	var calculated_stat = 0
	if stats.get(stat) != null:
		calculated_stat += stats.get(stat)
	for e in equipment.get_children():
		if e.get(stat) != null:
			calculated_stat += e.get(stat)
	
func _die():
	emit_signal("died", self)
	queue_free()

func _on_stats_hp_changed():
	hp_bar.value = stats.current_hp
	if stats.current_hp == 0:
		_die()


func _on_stats_mp_changed():
	mp_bar.value = stats.current_mp
