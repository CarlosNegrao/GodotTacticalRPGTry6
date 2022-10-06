class_name Stats
extends Node2D

signal hp_changed
signal mp_changed

@export var Name : String
@export var Max_HP : int
@export var Max_MP : int
@export var Str : int
@export var Dex : int
@export var Wis : int
@export var Con : int
@export var Int : int
@export var Mobility : int

var current_hp : int : 
	set(value):
		current_hp = clamp(value, 0, Max_HP)
		emit_signal("hp_changed")
		
var current_mp : int :
	set(value):
		current_mp = clamp(value, 0, Max_MP)
		emit_signal("mp_changed")

func setup():
	current_hp = Max_HP
	current_mp = Max_MP
