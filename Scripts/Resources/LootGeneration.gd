class_name LootGeneration

var itemConfig: ItemConfig = ItemConfig.new();

var rand = RandomNumberGenerator.new();

# Note: This should probably first choose an item type then an individual item from the list
func generateItem():
	var possibleItems: Dictionary = {
		Globals.SlotType.Weapon: itemConfig.weaponItems,
		Globals.SlotType.Head: itemConfig.weaponItems,
		Globals.SlotType.Chest: itemConfig.weaponItems,
		Globals.SlotType.Amulet: itemConfig.weaponItems,
		Globals.SlotType.Ring: itemConfig.weaponItems,
		Globals.SlotType.Gloves: itemConfig.weaponItems,
		Globals.SlotType.Boots: itemConfig.weaponItems,
	};
	var itemType = rand.randi_range(0, Globals.SlotType.values().size()-1);
	var itemIndex = rand.randi_range(0, possibleItems[itemType].size()-1);
	return generateItemWithStats(possibleItems[itemType][itemIndex]);


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
				if affix.type == Globals.AffixType.Prefix:
					realItem.prefixes[affix.stat] = statVal;
				else:
					realItem.suffixes[affix.stat] = statVal;
				
			else:
				roll -= affix.totalWeight;

	return realItem;

