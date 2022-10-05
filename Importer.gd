@tool
extends EditorImportPlugin

func _get_importer_name():
	return "lithtech.dtx.import"

func _get_visible_name():
	return "Lithtech DTX Importer"

func _get_recognized_extensions():
	return ["dtx", "DTX"]

func _get_save_extension():
	return "tres"

func _get_resource_type():
	return "ImageTexture"

func _get_preset_count():
	return 1

func _get_preset_name(i):
	return "Default"

func _get_import_options(path: String, preset_index: int):
	return []
	
func _get_option_visibility(path: String, option_name: StringName, options: Dictionary):
	return true
	
func _get_priority():
	return 1.0
	
func _get_import_order():
	return 1

var _texture_builder = null

func _init():
	var path = "%s/TextureBuilder.gd" % self.get_script().get_path().get_base_dir()
	self._texture_builder = load(path).new()
	
func _import(source_file, save_path, options, platform_variants, gen_files):
	var scene = self._texture_builder.build(source_file, options)
	
	var filename = save_path + "." + _get_save_extension()
	print("Saving as ", filename)
	ResourceSaver.save(scene, filename)
	return OK

