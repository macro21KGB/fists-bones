extends Control
class_name Cell


export (int) var valore_dado = 0

func setDiceValue(value: int) -> void: 
	valore_dado = value
	$Dice.text = formatDiceValue(valore_dado)

func getDiceValue() -> int:
	return valore_dado

func formatDiceValue(value: int) -> String:
	if value == 0:
		return ""

	return str(value)


