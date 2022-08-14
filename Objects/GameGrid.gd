extends Control
class_name GameGrid

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func getTotalSumOfEveryColumn(cells: Array) -> int:
	var total = 0
	for cell in cells:
		total += cell
	return total

func getValueForEveryColumn(cells: Array ) -> Array:
	var out = [0,0,0] 
	for i in cells.size():
		out[i%3] += cells[i].get_dice_value()
	return out

func getColumnByIndex(griglia: GridContainer, idx: int):
	var result : Array = []
	var allCells = getAllCells(griglia)
	for i in allCells.size():
		if i % 3 == idx:
			result.append_array([allCells[i%3]])
	
	return result


func addDiceToColumn(value: int, column_idx: int):
	pass

func getAllCells(grid: GridContainer) -> Array:
	return griglia.get_children()

onready var griglia = $GridContainer
var allCells = []

# Called when the node enters the scene tree for the first time.
func _ready():
	allCells = getAllCells(griglia)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
