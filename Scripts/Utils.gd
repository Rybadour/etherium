extends Node
class_name Utils

static func comma_sep(number):
	var string = str(number)
	var mod = string.length() % 3
	var res = ""

	for i in range(0, string.length()):
		if i != 0 && i % 3 == mod:
			res += ","
		res += string[i]

	return res


static func getModifierText(stat: Globals.StatType, value: float):
	var text = '';
	if stat == Globals.StatType.MiningPower:
		text = "%.0f" % value + ' Mining Power';
	elif stat == Globals.StatType.IncreasedMiningPower:
		text = '+' + "%.0f" % value + '% Mining Power';
	elif stat == Globals.StatType.ActionSpeed:
		text = "%.2f" % value + ' Action Speed';
	elif stat == Globals.StatType.IncreasedActionSpeed:
		text = '+' + "%.0f" % value + '% Action Speed';
	elif stat == Globals.StatType.FireDamage:
		text = '+' + "%.0f" % value + ' Fire Damage';
	elif stat == Globals.StatType.IncreasedFireDamage:
		text = '+' + "%.0f" % value + '% Fire Damage';
	elif stat == Globals.StatType.OilCapacity:
		text = '+' + "%.0f" % value + ' Oil Capacity';
	elif stat == Globals.StatType.MovementSpeed:
		text = '+' + "%.0f" % value + '% Move Speed';
	return text;

