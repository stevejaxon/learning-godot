extends TileMap

# A dictionary containing the mappings between a Player's activity and the corrosponding tileset index
var PLAYER_TO_ACTIVITY_DICTIONARY = {
	Players.ONE: {
		Posts.FOOD: 2,
		Posts.SELFIE: 4,
		Posts.TRAVEL: 6
	},
	Players.TWO: { 
		Posts.FOOD: 3,
		Posts.SELFIE: 5,
		Posts.TRAVEL: 7
	}
}

func playerLandedOnCell(player, coord, intermediateStep = false):
	if intermediateStep:
		return
	if player == Players.ONE:
		set_cellv(coord, 0)
	elif player == Players.TWO:
		set_cellv(coord, 1)
		
func newPost(player, coord, activity):
	set_cellv(coord, PLAYER_TO_ACTIVITY_DICTIONARY[player][activity])