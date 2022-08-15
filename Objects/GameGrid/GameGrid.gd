extends Control
class_name GameGrid


export (bool) var isActive = false

onready var total1 = $Total1
onready var total2 = $Total2
onready var total3 = $Total3

onready var totalSum = $TotalSum

func updateTotal():
	var total = getValueForEveryColumn()

	total1.text = str(total[0])
	total2.text = str(total[1])
	total3.text = str(total[2])
	
	
	totalSum.text = str(total[0] + total[1] +total[2])





func solvePointForColumn(arrayOfCells: Array) -> int:
	var value_array = Utils.convertCellArrayIntoDiceValueArray(arrayOfCells)
	var dict = Utils.countEveryElementInArray(value_array)
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


func getAllCells(grid: GridContainer) -> Array:
	return grid.get_children()

onready var griglia = $GridContainer


func _process(_delta):
	updateTotal()
