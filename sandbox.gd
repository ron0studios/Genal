extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var gene = [[TYPE_INT,5,3],[TYPE_STRING,3]]
	Genal.set_genome(gene,10)
	Genal.GEN_SIZE = 5
	Genal.random_gen()
	for i in Genal._generations[0]:
		print(i)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
