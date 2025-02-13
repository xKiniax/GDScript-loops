extends Node2D

# Exported variables for customization
@export var petal_count: int = 8
@export var petal_length: float = 100.0
@export var petal_width: float = 50.0
@export var petal_color: Color = Color(1, 0.5, 0.5)  # Light red
@export var center_radius: float = 20.0
@export var center_color: Color = Color(1, 1, 0)  # Yellow
@export var stem_length: float = 200.0  # Length of the stem
@export var stem_color: Color = Color(0, 0.5, 0)  # Green
@export var stem_width: float = 10.0  # Width of the stem

func _ready():
	generate_flower()

func generate_flower():
	# Clear any existing children (e.g., if regenerating)
	for child in get_children():
		child.queue_free()

	# Draw the stem (behind everything)
	var stem = Line2D.new()
	stem.points = PackedVector2Array([Vector2(0, 0), Vector2(0, stem_length)])
	stem.width = stem_width
	stem.default_color = stem_color
	stem.position = Vector2(0, 0)  # Position the stem at the base of the flower
	add_child(stem)  # Add the stem first so it's drawn behind the petals

	# Draw the petals
	var angle_step = 2 * PI / petal_count
	for i in range(petal_count):
		var angle = i * angle_step
		var petal = create_realistic_petal(petal_length, petal_width, petal_color)
		petal.position = Vector2.ZERO
		petal.rotation = angle
		add_child(petal)  # Add petals after the stem

	# Draw the flower center (on top of everything)
	var center = create_flower_center(center_radius, center_color)
	add_child(center)  # Add the center last so it's drawn on top

func create_realistic_petal(length: float, width: float, color: Color) -> Polygon2D:
	var petal = Polygon2D.new()
	var petal_shape = PackedVector2Array()

	# Define a Bézier curve for the petal shape
	var curve = Curve2D.new()
	curve.add_point(Vector2(0, 0))  # Start at the base of the petal
	curve.add_point(Vector2(-width / 2, -length / 3), Vector2(-width / 4, -length / 6), Vector2(-width / 4, -length / 6))  # Control points for the left side
	curve.add_point(Vector2(0, -length))  # Tip of the petal
	curve.add_point(Vector2(width / 2, -length / 3), Vector2(width / 4, -length / 6), Vector2(width / 4, -length / 6))  # Control points for the right side

	# Sample points along the curve to create the petal shape
	var resolution = 20  # Number of points to sample
	for i in range(resolution + 1):
		var t = float(i) / resolution
		var point = curve.sample_baked(t * curve.get_baked_length())
		petal_shape.append(point)

	# Close the shape by returning to the base
	petal_shape.append(Vector2(0, 0))

	petal.polygon = petal_shape
	petal.color = color
	return petal

func create_flower_center(radius: float, color: Color) -> Polygon2D:
	var center = Polygon2D.new()
	var center_shape = PackedVector2Array()

	# Create a circle for the flower center
	var resolution = 32  # Number of points to approximate a circle
	for i in range(resolution):
		var angle = 2 * PI * i / resolution
		center_shape.append(Vector2(radius * cos(angle), radius * sin(angle)))

	center.polygon = center_shape
	center.color = color
	return center
