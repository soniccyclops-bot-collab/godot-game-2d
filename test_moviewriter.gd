extends Node

func _ready():
	var mw = MovieWriter.new()
	print("MovieWriter methods:")
	for method in mw.get_method_list():
		print("  - ", method.name)
	get_tree().quit()
