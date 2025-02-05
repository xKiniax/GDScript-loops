extends Node2D

func _ready() -> void:
	#loops - is a statement that allow your code to be repeated (similar to if statements but can repeat)
	
	var  inc = 0
	while inc < 10:
		print("running a loop", inc)
		inc += 1
	
	for x in range(10):
		print("The value is ", x)
		
		
func _process(delta: float) -> void:
	pass
