extends Node2D

@export var headItems: Array[Item];

var rand = RandomNumberGenerator.new();

func _ready():
	generateItem();

# Note: This should probably first choose an item type then an individual item from the list
func generateItem():
	var possibleItems: Dictionary = {
		Item.SlotType.Weapon: [42],
		Item.SlotType.Head: [2],
		Item.SlotType.Chest: [21],
		Item.SlotType.Amulet: [2],
		Item.SlotType.Ring: [4],
		Item.SlotType.Gloves: [6],
		Item.SlotType.Boots: [],
	};
	var itemType = rand.randi_range(0, Item.SlotType.values().size());
	print_debug(possibleItems[itemType]);


const NUM_STATS = 2;

func generateItemWithStats(item: Item):
	var realItem = RealItem.new(item);
	# Roll implicits
	for implicit in item.implicits:
		realItem.implicits[implicit.stat] = implicit.generateModifierAmount(rand.randi_range(0, implicit.totalWeight));
	
	var affixesAlreadyFound: Array[String];
	for i in NUM_STATS:
		var roll = rand.randi_range(0, item.totalWeight);
		for affix in item.affixes:
			if roll < affix.totalWeight:
				var statVal = affix.generateModifierAmount(roll);
				if affix.type == AffixType.Prefix:
					realItem.prefixes[affix.stat] = statVal;
				else:
					realItem.suffixes[affix.stat] = statVal;
				
			else:
				roll -= affix.totalWeight;


