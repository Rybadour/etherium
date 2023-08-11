class_name Item

var name: String;
var prefixes: Array[String];
var suffixes: Array[String];

func _init(name: String):
  self.name = name;
  prefixes.append('10% Fire Damage');
  suffixes.append('15% Action Speed')