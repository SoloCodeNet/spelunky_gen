extends TileMap

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("generateR"):generate(5,5)
	
func generate(col, row)-> void:
	randomize()
	# fill the board with X tiles
	clear()
	for xx in col:
		for yy in row:
			set_cell(xx,yy,0)

	# define the random col cursor on the top row 
	var start_col = floor(rand_range(0, col))
	var stop:=1
	var pos : = Vector2(start_col , 0)
	set_cell(pos.x,pos.y, 1) 
	
	while stop < (row) :
		var rnd = randi()%5
		if rnd in [0, 1]:
			if pos.x +1 <col-1 :
				pos.x += 1 						# right
				if get_cell(pos.x, pos.y) == 0:
					set_cell(pos.x,pos.y, 1) 
				
		elif rnd in [2, 3]: 
			if pos.x-1 >= 0:
				pos.x -= 1   					# left
				if get_cell(pos.x, pos.y) == 0:
					set_cell(pos.x,pos.y, 1) 
		else:
			if get_cell(pos.x, pos.y -1) != 2: 
				set_cell(pos.x,pos.y, 2)
				pos.y += 1  
				set_cell(pos.x,pos.y, 3)		# down
				stop+=1

	# array of the rest tiles X 
	var lst_dipo = get_used_cells_by_id(0)
	lst_dipo.shuffle()

	var ok = 4
	var rooms=[]
	while ok < 7:
		var side :Vector2 = Vector2.RIGHT if randi()%2 >0 else Vector2.LEFT
		var cell = lst_dipo[randi()%lst_dipo.size()]
		if get_cellv(cell + side) in [1,2,3]:
			lst_dipo.remove(lst_dipo.find(cell))
			set_cellv(cell, ok )
			ok+=1
