extends Node2D
@export var speed: float = 150.0  # Parallax speed, slower than ground

var pieces: Array[Sprite2D] = []

func _ready():
	pieces.clear()
	# Only include Sprite2D children
	for c in get_children():
		if c is Sprite2D:
			pieces.append(c)
	# Sort pieces by X position so leftmost is pieces[0]
	pieces.sort_custom(func(a, b): return a.position.x < b.position.x)
	# Snap sprites perfectly side-by-side (no gaps), start at x = 0.0
	var x := 0.0
	for s in pieces:
		var w := 0.0
		if s.texture:
			w = s.texture.get_width() * s.scale.x
		s.position.x = x
		x += w

func _process(delta):
	for s in pieces:
		s.position.x -= speed * delta
	_wrap_leftmost_if_needed()

func _wrap_leftmost_if_needed():
	var first := pieces[0]
	var first_w := 0.0
	if first.texture:
		first_w = first.texture.get_width() * first.scale.x
	# If the first sprite is completely off-screen to the left
	if first.position.x + first_w < 0.0:
		var last := pieces[pieces.size() - 1]
		var last_w := 0.0
		if last.texture:
			last_w = last.texture.get_width() * last.scale.x
		first.position.x = last.position.x + last_w
		# Rotate array to move recycled sprite to the end
		pieces.remove_at(0)
		pieces.append(first)
