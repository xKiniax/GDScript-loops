extends Node2D

func _ready() -> void:
	#loops - is a statement that allow your code to be repeated (similar to if statements but can repeat)
	
	_draw
	
	
	
	var  inc = 0
	while inc < 10:
		print("running a loop", inc)
		inc += 1
	
	for x in range(10):
		print("The value is ", x)
	
	for x in range(3):
		for y in range(0, 3):
			print(y)
		print()
	
		
func _process(delta: float) -> void:
	pass

var z = draw_line

func _draw() -> void:
	for z in range(10):
		draw_line(Vector2(1.5, 1.0), Vector2(1.5, 4.0), Color.GREEN, 1.0)
	
	var cen = Vector2(100, 100)
	var rad = 40
	var col = Color(1,0,0)

	for c in range(10):
		draw_circle(cen,rad,col)
