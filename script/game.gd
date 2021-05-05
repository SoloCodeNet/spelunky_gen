extends Node2D

onready var _preview = preload("res://prefab/preview.tscn")
onready var _x = preload("res://maps_refs/x0.tscn")
onready var _n = preload("res://maps_refs/n0.tscn")
onready var _s = preload("res://maps_refs/s0.tscn")
onready var _e = preload("res://maps_refs/e0.tscn")
onready var _u = preload("res://maps_refs/u0.tscn")
onready var _d = preload("res://maps_refs/d0.tscn")
var size:= 5

func _ready() -> void:
	generate_board()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"): get_tree().reload_current_scene()

func generate_board()->void:
	var tm = _preview.instance()
	tm.generate(size,size)
	for x in size:
		for y in size:
			var i = tm.get_cell(x,y)
			var scene
			var r = 0
			match i:
				0:scene = load("res://maps_refs/x" + str(r)  +".tscn").instance()
				1:scene = load("res://maps_refs/n" + str(r)  +".tscn").instance()
				2:scene = load("res://maps_refs/d" + str(r)  +".tscn").instance()
				3:scene = load("res://maps_refs/u" + str(r)  +".tscn").instance()
				4:scene = load("res://maps_refs/e" + str(r)  +".tscn").instance()
				5:scene = load("res://maps_refs/s" + str(r)  +".tscn").instance()
				6:scene = load("res://maps_refs/k" + str(r)  +".tscn").instance()
			
			var pos = Vector2(1280 * x, 768 * y)
			add_child(scene)
			scene.position = pos
			scene.get_node("grid").visible = false
			
	for x in range(-1, size+1):
		var scene_up = load("res://maps_refs/F0.tscn").instance()
		add_child(scene_up)
		scene_up.position = Vector2(1280 * x, -768)
		
		var scene_dw = load("res://maps_refs/F0.tscn").instance()
		add_child(scene_dw)
		scene_dw.position = Vector2(1280 * x, 768 * size)
		
	for x in size:
		var scene_left = load("res://maps_refs/F0.tscn").instance()
		add_child(scene_left)
		scene_left.position = Vector2(-1280, 768 * x)
	
		var scene_right = load("res://maps_refs/F0.tscn").instance()
		add_child(scene_right)
		scene_right.position = Vector2(1280 * size, 768 * x)
