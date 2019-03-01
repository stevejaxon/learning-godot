extends TileMap

const PLAYER_1_START_POSITION = Vector2(1, 1)
const PLAYER_2_START_POSITION = Vector2(4, 7)
# Note: this is not an ideal solution, but it's handy due to the way that the isometric tilemap returns the occupied cells and the difficulty of converting this back to an cartesian grid
const BOARD_ROW_SIZES = [5,6,7,8,9,8,7,6,5]

var tile_size = get_cell_size()

# Note: if more rows are added to the board this needs to be updated too
var grid = [[],[],[],[],[],[],[],[],[]]

onready var Player1 = preload("res://scenes/Player1.tscn")
onready var Player2 = preload("res://scenes/Player2.tscn")

onready var Sorter = $YSort

func _ready():
	_createGridIndex()
	_placePlayers()
		
func _createGridIndex():
	var currentY = 0
	var currentRow = 0
	var row = 0
	for coord in get_used_cells():
		if currentY == 0:
			currentY = coord.y
		elif currentY != coord.y:
			currentY = coord.y
			if grid[currentRow].size() == BOARD_ROW_SIZES[currentRow]:				
				currentRow = currentRow + 1
			row = currentRow
		
		grid[row].append(coord)
		row = row + 1
		
	for row in grid:
		# The cells are returned from right to left so we need to invert them to get the expected format
		row.invert()
		
func _placePlayers():
	var player1Coord = grid[PLAYER_1_START_POSITION.y][PLAYER_1_START_POSITION.x]
	_placePlayer(Player1, player1Coord)
	var player2Coord = grid[PLAYER_2_START_POSITION.y][PLAYER_2_START_POSITION.x]
	_placePlayer(Player2, player2Coord)
	
func _placePlayer(type, coord):
	var newPlayer = type.instance()
	newPlayer.position = map_to_world(coord, true)
	add_child(newPlayer)