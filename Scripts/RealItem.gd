class_name RealItem

enum StatType {MiningPower, ActionSpeed, IncreasedMiningPower, IncreasedActionSpeed}

var item: Item;
var fullName: String;
var implicits: Dictionary; #StatType -> float
var prefixes: Dictionary; #StatType -> float;
var suffixes: Dictionary; #StatType -> float;

func _init(item: Item):
  self.item = item;