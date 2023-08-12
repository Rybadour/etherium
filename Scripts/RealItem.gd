class_name RealItem

var item: Item;
var fullName: String;
var implicits: Dictionary; #StatType -> float
var prefixes: Dictionary; #StatType -> float;
var suffixes: Dictionary; #StatType -> float;

func _init(item: Item):
	self.item = item;
	fullName = item.name;
