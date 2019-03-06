extends TileMap

enum Player { PLAYER_1, PLAYER_2 }

signal player_move_finished

const PLAYER_1_START_POSITION = Vector2(1, 1)
const PLAYER_2_START_POSITION = Vector2(4, 7)
# Note: this is not an ideal solution, but it's handy due to the way that the isometric tilemap returns the occupied cells and the difficulty of converting this back to an cartesian grid
const BOARD_ROW_SIZES = [5,6,7,8,9,8,7,6,5]

var tile_size = get_cell_size()

# Note: if more rows are added to the board this needs to be updated too
var grid = [[],[],[],[],[],[],[],[],[]]
var player1Instance
var player1Coordinates
var player2Instance
var player2Coordinates

onready var Player1Scene = preload("res://scenes/Player1.tscn")
onready var Player2Scene = preload("res://scenes/Player2.tscn")

onready var Sorter = $YSort

func _ready():
	_createGridIndex()
	_createPlayers()
	
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
		
func _createPlayers():
	player1Instance = Player1Scene.instance()
	player1Coordinates = PLAYER_1_START_POSITION
	_placePlayer(player1Instance, player1Coordinates)
	add_child(player1Instance)
	player2Instance = Player2Scene.instance()
	player2Coordinates = PLAYER_2_START_POSITION
	_placePlayer(player2Instance, player2Coordinates)
	add_child(player2Instance)
	
func _placePlayer(player, coord):
	player.position = map_to_world(grid[coord.y][coord.x], true)
	
func movePlayer(player, vector):
	var p = _getPlayer(player)
	var coord = _getPlayerCurrentCoordinates(player)
	# TODO figure out how to deal with updating the player's coordinates
	player1Coordinates = _getNextCoordinates(coord, vector)
	_placePlayer(p, player1Coordinates)
	emit_signal("player_move_finished")
	
func _getNextCoordinates(current, vector):
	match vector:
		Vector2(-1, -1):
			pass
		Vector2(1, -1):
			pass
		Vector2(1, 0):
			return _getNextHorizontalCoordinate(current, 1)
		Vector2(1, 1):
			pass
		Vector2(-1, 1):
			pass
		Vector2(-1, 0):
			return _getNextHorizontalCoordinate(current, -1)
	
func _getNextHorizontalCoordinate(current, x):
	var nextX = current.x + x
	var length = grid[current.y].size()
	if nextX < 0:
		return Vector2(length - 1, current.y) 
	elif nextX < length:
		return Vector2(nextX, current.y)
	elif nextX == length:
		return Vector2(0, current.y)
	
func _getPlayer(player):
	match player:
		PLAYER_1:
			return player1Instance
		PLAYER_2:
			return player2Instance
			
func _getPlayerCurrentCoordinates(player):
	match player:
		PLAYER_1:
			return player1Coordinates
		PLAYER_2:
			return player2Coordinates