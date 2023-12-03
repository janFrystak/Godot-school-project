extends DirectionalLight3D


# Called when the node enters the scene tree for the first time.
func _ready():
	rotation.x = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var  clock = 0
	clock +=1
	if (clock == 100):
		rotation.x += 1
		clock = 0
	
