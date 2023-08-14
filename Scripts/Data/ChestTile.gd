extends Node
class_name ChestTile

var tileSourceId: int;
var tileId: Vector2i;

func _init(tileSourceId: int, tileId: Vector2i):
	self.tileSourceId = tileSourceId;
	self.tileId = tileId;
