extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func expect(value, expected):
	if value == expected:
		return true
	else:
		return false

# Called when the node enters the scene tree for the first time.
func _ready():
	var cell1 = Cell.new() 
	var cell2 = Cell.new() 
	var cell3 = Cell.new() 
	var grid = GameGrid.new()
	
	cell1.valore_dado = 1
	cell2.valore_dado = 1
	cell3.valore_dado = 3
	
	var arr = [cell1,cell2,cell3]
	


	var count = Utils.countEveryElementInArray([1,2,2])
	
	var sum = Utils.sumDictionaryWithDoubles(count)
	print(sum)
	
	print(cell1,cell2,cell3)
