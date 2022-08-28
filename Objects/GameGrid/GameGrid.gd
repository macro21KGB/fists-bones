extends Control
class_name GameGrid

onready var total1 = $Total1
onready var total2 = $Total2
onready var total3 = $Total3

onready var totalSum = $TotalSum

# Signals
signal grid_is_full


func _ready() -> void:
	GameEvents.connect("next_turn", self, "_on_next_turn")

func updateTotal():
	var total : Array = getValueForEveryColumn()

	total1.text = str(total[0])
	total2.text = str(total[1])
	total3.text = str(total[2])
	
	totalSum.text = str(total[0] + total[1] +total[2])

func resetTotal():
	total1.text = str(0)
	total2.text = str(0)
	total3.text = str(0)
	totalSum.text = str(0)

func resetGrid():
	for cell in getAllCells(griglia):
		cell.reset()
	resetTotal()
	

func solvePointForColumn(arrayOfCells: Array) -> int:
	var value_array = Utils.convertCellArrayIntoDiceValueArray(arrayOfCells)
	var dict = Utils.countEveryElementInArray(value_array)
	
	var selected_high = -1
	var keys_dict = dict.keys()
	for key in keys_dict:
		if dict[key] >= 2 and key != 0:
			selected_high = key
	
	for i in value_array.size():
		if value_array[i] == selected_high:
			arrayOfCells[i].setHighlight(true)
	
	var sum = Utils.sumDictionaryWithDoubles(dict)
	return sum

func getValueForEveryColumn() -> Array:

	var col1 =  getColumnByIndex(griglia, 0)
	var col2 = getColumnByIndex(griglia, 1)
	var col3 = getColumnByIndex(griglia, 2)


	var sum1 = solvePointForColumn(col1)
	var sum2 = solvePointForColumn(col2)
	var sum3 = solvePointForColumn(col3)

	return [sum1,sum2,sum3]


func getColumnByIndex(grid: GridContainer, idx: int):
	var result : Array = []
	var cells = getAllCells(grid)
	
	for i in cells.size():
		if i % 3 == idx:
			result.append_array([cells[i]])
	return result


func findFirstEmptyCell(column: Array):
	for i in column.size():
		if column[i].getDiceValue() == 0:
			return column[i]
	return null


func addDiceToColumn(value: int, column_idx: int) -> bool:
	var column = getColumnByIndex(griglia, column_idx)
	var selected_cell = findFirstEmptyCell(column)
	if selected_cell != null:
		selected_cell.setDiceValue(value)
		return true
	return false

func checkIfGridIsFull() -> bool:
	for cell in getAllCells(griglia):
		if cell.getDiceValue() == 0:
			return false
	return true

func getAllCells(grid: GridContainer) -> Array:
	return grid.get_children()

onready var griglia = $GridContainer


func _on_next_turn(grid: GameGrid) -> void:
	if grid == self:
		updateTotal()
		if checkIfGridIsFull():
			emit_signal("grid_is_full")
