extends TileMap

const PLAYER_1_START_POSITION = Vector2(1, 1)
const PLAYER_2_START_POSITION = Vector2(-1, -1)

var tile_size = get_cell_size()

var grid = []

onready var Player1 = preload("res://scenes/Player1.tscn")
onready var Player2 = preload("res://scenes/Player2.tscn")

onready var Sorter = $YSort

func _ready():
	_createGridIndex()
	print(grid)
	_placePlayers()
		
func _createGridIndex():
	var currentY = 0
	var gridY = 0
	for coord in get_used_cells():
		print(coord)
		if currentY == 0:
			currentY = coord.y
			grid.append([])
		elif currentY != coord.y:
			# There seems to be some odd behaviour where the coordinates are the mirror of what I was expecting...
			# Reversing to get the expected logic
			gridY = gridY + 1
			grid.append([])
			currentY = coord.y
		
		grid[gridY].append(coord)
		
func _placePlayers():
	var player1Coord = grid[PLAYER_1_START_POSITION.y][PLAYER_1_START_POSITION.x]
	_placePlayer(Player1, player1Coord)
	
func _placePlayer(type, coord):
	var newPlayer = type.instance()
	newPlayer.position = map_to_world(Vector2(13, -11), true)
	add_child(newPlayer)