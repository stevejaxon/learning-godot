extends TileMap

# A dictionary containing the mappings between a Player's activity and the corrosponding tileset index
var PLAYER_TO_ACTIVITY_DICTIONARY = {
	Players.ONE: {
		Posts.FOOD: 2,
		Posts.SELFIE: 4,
		Posts.TRAVEL: 6,
		Posts.ADVERT: 8,
		Posts.MEME: 9,
		Posts.NEWS: 11,
		Posts.QUOTE: 13,
		Posts.INFOGRAPHIC: 15,
		Posts.WEDDING: 17
	},
	Players.TWO: { 
		Posts.FOOD: 3,
		Posts.SELFIE: 5,
		Posts.TRAVEL: 7,
		Posts.ADVERT: 8,
		Posts.MEME: 10,
		Posts.NEWS: 12,
		Posts.QUOTE: 14,
		Posts.INFOGRAPHIC: 16,
		Posts.WEDDING: 18
	}
}

func playerLandedOnCell(player, coord, intermediateStep = false):
	# We don't want to update the overlay when a player has landed on an already occupied cell
	if intermediateStep:
		return
	if player == Players.ONE:
		set_cellv(coord, 0)
	elif player == Players.TWO:
		set_cellv(coord, 1)
		
func newPost(player, coord, activity):
	set_cellv(coord, PLAYER_TO_ACTIVITY_DICTIONARY[player][activity])