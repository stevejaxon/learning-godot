extends TileMap

signal player_move_finished
signal new_post_activity

const PLAYER_1_START_POSITION = Vector2(2, 2)
const PLAYER_2_START_POSITION = Vector2(4, 7)
# Note: this is not an ideal solution, but it's handy due to the way that the isometric tilemap returns the occupied cells and the difficulty of converting this back to an cartesian grid
const BOARD_ROW_SIZES = [5,6,7,8,9,8,7,6,5]

var tile_size = get_cell_size()

# Note: if more rows are added to the board this needs to be updated too
var grid = [[],[],[],[],[],[],[],[],[]]
var boardState = [[],[],[],[],[],[],[],[],[]]
var player1Instance
var player1Coordinates
var player2Instance
var player2Coordinates

onready var Player1Scene = preload("res://scenes/Player1.tscn")
onready var Player2Scene = preload("res://scenes/Player2.tscn")
onready var Activity = preload("res://scripts/games/Activity.gd")

onready var Sorter = $YSort

func _ready():
	self.connect("new_post_activity", get_node("../PostOverlays"), "playerLandedOnCell")
	_createGridIndex()
	_createPlayers()
	
func newPost(_player, _activity):
	var coord = _getPlayerCurrentCoordinates(_player)
	boardState[coord.y][coord.x] = Activity.new(_player, _activity)
	print(boardState)
	
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
		#Also initialise the board state, as blank, at the same time
		boardState[row].append(null)
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
	var boardCoords = grid[coord.y][coord.x]
	player.position = map_to_world(boardCoords, true)
	emit_signal("new_post_activity", _reversePlayerLookup(player), boardCoords)
	
func movePlayer(player, vector):
	var p = _getPlayer(player)
	var coord = _getPlayerCurrentCoordinates(player)
	# TODO figure out how to deal with updating the player's coordinates
	player1Coordinates = _getNextCoordinates(coord, vector)
	_placePlayer(p, player1Coordinates)
	emit_signal("player_move_finished")
	
func _getNextCoordinates(current, vector):
	# Determine the next row that the player will move to
	var nextRow = current.y + vector.y
	# Handle the situation when the player wraps around from the top to the bottom or bottom to top
	if nextRow < 0:
		nextRow = grid.size() - 1
	elif nextRow == grid.size():
		nextRow = 0
	
	var currentRowLength = grid[current.y].size()
	var nextRowLength = grid[nextRow].size()
	var nextX = current.x + vector.x
	# Deal with the situation where the player moves diagonally on a hexagonal board
	if currentRowLength > nextRowLength and vector.x > 0:
		nextX = current.x
	elif currentRowLength < nextRowLength and vector.x < 0:
		nextX = current.x
	# Use the above information to determine the resulting coordinates
	if nextX < 0:
		return Vector2(nextRowLength - 1, nextRow) 
	elif nextX < nextRowLength:
		return Vector2(nextX, nextRow)
	elif nextX == nextRowLength:
		return Vector2(0, nextRow)
	
func _getPlayer(player):
	match player:
		Players.ONE:
			return player1Instance
		Players.TWO:
			return player2Instance
			
func _reversePlayerLookup(instance):
	match instance:
		player1Instance:
			return Players.ONE
		player2Instance:
			return Players.TWO

func _getPlayerCurrentCoordinates(player):
	match player:
		Players.ONE:
			return player1Coordinates
		Players.TWO:
			return player2Coordinates