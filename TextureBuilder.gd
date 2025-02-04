extends Node

func build(source_file, options):
	var file = FileAccess.open(source_file, FileAccess.READ)
	if file.get_error() != OK:
		print("Failed to open %s" % source_file)
		
	#print("Opened %s" % source_file)
	
	var path = "%s/Models/DTX.gd" % self.get_script().get_path().get_base_dir()
	var dtx_file = load(path)
	
	# Model as in MVC model, not mesh model!
	var model = dtx_file.DTX.new()
	
	var response = model.read(file)
	
	#file.close()
	
	if response.code == model.IMPORT_RETURN.ERROR:
		print("IMPORT ERROR: %s" % response.message)
		return null
		
	var texture = ImageTexture.create_from_image(model.image)
	
	return texture
