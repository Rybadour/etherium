extends Node
class_name RockTile

var tileSourceId: int;
var tileId: Vector2i;
var ore: Globals.OreType;
var oreYield: int;
var strength: int;

func _init(tileSourceId: int, tileId: Vector2i, ore: Globals.OreType, oreYield: int, strength: int):
  self.tileSourceId = tileSourceId;
  self.tileId = tileId;
  self.ore = ore;
  self.oreYield = oreYield;
  self.strength = strength;