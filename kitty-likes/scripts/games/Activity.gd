extends Node

var player
var postType

func _init(_player, _type):
	player = _player
	postType = _type
	
func getPlayer():
	return player
	
func getPostType():
	return postType