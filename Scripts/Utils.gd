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
		text = str(value) + ' Mining Power';
	elif stat == Globals.StatType.IncreasedMiningPower:
		text = '+' + str(value) + '% Mining Power';
	elif stat == Globals.StatType.ActionSpeed:
		text = str(value) + ' Action Speed';
	elif stat == Globals.StatType.IncreasedActionSpeed:
		text = '+' + str(value) + '% Action Speed';
	elif stat == Globals.StatType.FireDamage:
		text = '+' + str(value) + ' Fire Damage';
	elif stat == Globals.StatType.IncreasedFireDamage:
		text = '+' + str(value) + '% Fire Damage';
	elif stat == Globals.StatType.OilCapacity:
		text = '+' + str(value) + ' Oil Capacity';
	elif stat == Globals.StatType.MovementSpeed:
		text = '+' + str(value) + '% Move Speed';
	return text;

