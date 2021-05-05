extends Node2D


func _ready() -> void:
	if has_node("grid"):get_node("grid").visible = false
	generate_vue()
	
	
func _process(_delta: float) -> void:
	if has_node("player") and has_node("cam"):
		var half =((get_global_mouse_position() - $player.global_position) / 3) + $player.global_position
		$cam.global_position = lerp($cam.global_position, half, 0.07)
		if Input.is_action_pressed("ui_down"):
			$cam/Camera2D.zoom.x +=0.3
		if Input.is_action_pressed("ui_up"):
			$cam/Camera2D.zoom.x -=0.3
		$cam/Camera2D.zoom.x = clamp($cam/Camera2D.zoom.x, 1, 8)
		$cam/Camera2D.zoom.y =$cam/Camera2D.zoom.x
		
		
func generate_vue()->void:
	$TileMap.visible = false
	var rec = $TileMap.get_used_rect()
	for x in rec.size.x:
		for y in rec.size.y:
			var st:=""
			var v = Vector2(x,y)
#			$vue2.set_cellv(v, randi()%8 )
			var i = $TileMap.get_cellv(v)
			if i == 0:
				$vue.set_cellv(v, randi()%8 )
			if i == -1:
				if $TileMap.get_cellv(v+Vector2.LEFT)  != -1: st+="L"
				if $TileMap.get_cellv(v+Vector2.UP)    != -1: st+="U"
				if $TileMap.get_cellv(v+Vector2.RIGHT) != -1: st+="R"
				if $TileMap.get_cellv(v+Vector2.DOWN)  != -1: st+="D"
				
				if st == "L": $vue.set_cellv(v, r_arr([24,25,26,27]))
				if st == "U": $vue.set_cellv(v, r_arr([16,17,18,19,20,21,22,23])) 
				if st == "R": $vue.set_cellv(v, r_arr([28,29,30,31])) 
				if st == "D": $vue.set_cellv(v, r_arr([8,9,10,11,12,13,14,15])) 
				
				if st == "LU": $vue.set_cellv(v, 34) 
				if st == "UR": $vue.set_cellv(v, 35) 
				if st == "RD": $vue.set_cellv(v, 33) 
				if st == "LD": $vue.set_cellv(v, 32) 
				
				if st == "LR": $vue.set_cellv(v, 40) 
				if st == "UD": $vue.set_cellv(v, 43)
				
				if st == "LUR": $vue.set_cellv(v, 37)  
				if st == "URD": $vue.set_cellv(v, 39) 
				if st == "LRD": $vue.set_cellv(v, 36) 
				if st == "LUD": $vue.set_cellv(v, 38)
				
				if st == "LURD": $vue.set_cellv(v, 46)
				
				
func r_arr(arr:Array):
	return arr[randi()% arr.size()]
				
