extends TileMap

func playerLandedOnCell(player, coord):
	prints("the eagle has landed", coord)
	if player == Utils.Player.ONE:
		set_cellv(coord, 0)
	elif player == Utils.Player.TWO:
		set_cellv(coord, 1)