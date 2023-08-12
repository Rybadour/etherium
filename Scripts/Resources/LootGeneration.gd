class_name LootGeneration

var itemConfig: ItemConfig = ItemConfig.new();
var rand = RandomNumberGenerator.new();

const ITEM_FROM_ROCK_CHANCE = 0.5;

func generateLootFromRock():
	if rand.randf() <= ITEM_FROM_ROCK_CHANCE:
		return generateItem();


func generateItem():
	var possibleItems: Dictionary = {
		Globals.SlotType.Weapon: itemConfig.weaponItems,
		Globals.SlotType.Head: itemConfig.helmetItems,
		Globals.SlotType.Chest: itemConfig.chestItems,
		Globals.SlotType.Amulet: itemConfig.amuletItems,
		Globals.SlotType.Ring: itemConfig.ringItems,
		Globals.SlotType.Gloves: itemConfig.glovesItems,
		Globals.SlotType.Boots: itemConfig.bootsItems,
	};
	var itemType = rand.randi_range(0, Globals.SlotType.values().size()-1);
	var itemIndex = rand.randi_range(0, possibleItems[itemType].size()-1);
	return generateItemWithStats(possibleItems[itemType][itemIndex]);


const NUM_STATS = 2;

func generateItemWithStats(item: Item):
	var realItem = RealItem.new(item);
	# Roll implicits
	for implicit in item.implicits:
		realItem.implicits[implicit.stat] = generateModifierAmount(implicit.tiers, rand.randi_range(0, implicit.totalWeight));
	
	var affixesAlreadyFound: Array[String];
	for i in NUM_STATS:
		var roll = rand.randi_range(0, item.totalWeight);
		for affix in item.affixes:
			if roll < affix.totalWeight:
				var statVal = generateModifierAmount(affix.tiers, roll);
				if affix.type == Globals.AffixType.Prefix:
					realItem.prefixes[affix.stat] = statVal;
				else:
					realItem.suffixes[affix.stat] = statVal;
				
			else:
				roll -= affix.totalWeight;

	return realItem;


func generateModifierAmount(tiers: Array[ModifierTier], relativeRoll: int):
	for tier in tiers:
		if relativeRoll <= tier.weight:
			return rand.randi_range(tier.statMin, tier.statMax);
		else:
			relativeRoll -= tier.weight;
