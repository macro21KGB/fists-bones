extends Control
class_name Cell


const BLACK = Color(0,0,0,1)
const YELLOW = Color(1,1,0,1)
const WHITE = Color(1,1,1,1)

export (int) var valore_dado = 0
export (bool) var is_highlight = false setget setHighlight, getHighlight

onready var colorRect = $ColorRect
var current_color = BLACK
var current_text_color = WHITE

func setHighlight(value: bool):
	is_highlight = value
	
func getHighlight():
	return is_highlight

func setDiceValue(value: int) -> void: 
	valore_dado = value
	$Dice.text = formatDiceValue(valore_dado)

func getDiceValue() -> int:
	return valore_dado

func setTextColor(new_color: Color) -> void:
	if new_color != current_text_color:
		current_text_color = new_color
		$Dice.modulate = current_text_color

func formatDiceValue(value: int) -> String:
	if value == 0:
		return ""
	return str(value)

func setNewColor(new_color: Color):
	if new_color != current_color:
		current_color = new_color
		colorRect.color = current_color

func reset():
	setDiceValue(0)
	setHighlight(false)
	setTextColor(WHITE)

func _ready() -> void:
	setNewColor(BLACK)

func _process(delta: float) -> void:
	if valore_dado == 0:
		setHighlight(false)
	
	if is_highlight:
		setNewColor(YELLOW)
		setTextColor(BLACK)
	else:
		setNewColor(BLACK)
		setTextColor(WHITE)

