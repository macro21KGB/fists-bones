class_name Utils



static func generateDiceRoll() -> int:
	randomize()
	return randi() % 6 + 1


static func getDiceValueFromCell(cell: Cell) -> int:
	return cell.getDiceValue()


static func checkForMoreThanOneMatch(arrayOfCells: Array) -> int:
	var moreThanOneValue = 0

	for i in range(arrayOfCells.size()):
		var current_cell_i = getDiceValueFromCell(arrayOfCells[i])

		if current_cell_i == 0:
			continue

		for j in range(arrayOfCells.size()):
			var current_cell_j = getDiceValueFromCell(arrayOfCells[j]) 

			if j != i and current_cell_i == current_cell_j:
				moreThanOneValue = current_cell_i
				return moreThanOneValue			
				
	return moreThanOneValue
				


static func filterOutNumberFromArray(array: Array, number_to_find: int) -> int:
	
	for item in array:
		if item != number_to_find:
			return item
	return 0

static func sumItemInArray(array: Array) -> int:
	var out = 0
	for item in array:
		out += item
	return out

static func convertCellArrayIntoDiceValueArray(arrayOfCells: Array) -> Array:
	var out = []
	for cell in arrayOfCells:
		var cell_value = cell.getDiceValue()
		out.append_array([cell_value])
	return out

# taken an array of integer, return a dict with how many are there
static func countEveryElementInArray(arr: Array) -> Dictionary:
	var dict = {}
	for elem in arr:
		if not (elem  in dict):
			dict[elem] = 1
		else:
			dict[elem] += 1
	return dict
	
static func sumDictionaryWithDoubles(dict: Dictionary) -> int:
	var keys = dict.keys()
	var out = 0
	for key in keys:
		var current_value = dict[key]
		
		if current_value == 0:
			continue
		
		if dict[key] > 1:
			out += (key + key) * 2
		else:
			out += key
			
	return out
