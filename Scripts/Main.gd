extends Control


const DIR_ERR = 'ERROR: Failed to create directory "%s". Error code %s.'

# Equivalent to '~/Documents/AseScale' in Linux
var export_path := OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)+"/AseScale"

var file_path := ""


func _ready() -> void:
	# Connect signal for drag-and-drop
	get_tree().connect("files_dropped", self, "get_files_path")


func get_files_path(files: PoolStringArray, _screen: int) -> void:
	file_path = files[0]
	if not file_path.empty():
		aseprite()


func aseprite() -> void:
	# Creater directory first if it doesn't exist yet
	var directory := Directory.new()

	if _create_directory(directory, export_path) == true:
		# Copy original file name and rename it on outputs
		var output_name := file_path.get_file().get_basename()
		OS.execute("aseprite", ["--batch" , file_path, "--scale", "2", "--save-as", export_path + "/" + output_name + "_x2.png"])
		OS.execute("aseprite", ["--batch" , file_path, "--scale", "4", "--save-as", export_path + "/" + output_name + "_x4.png"])
		OS.execute("aseprite", ["--batch" , file_path, "--scale", "6", "--save-as", export_path + "/" + output_name + "_x6.png"])
		OS.execute("aseprite", ["--batch" , file_path, "--scale", "8", "--save-as", export_path + "/" + output_name + "_x8.png"])
		OS.execute("aseprite", ["--batch" , file_path, "--scale", "10", "--save-as", export_path + "/" + output_name + "_x10.png"])


func _create_directory(directory, path) -> bool:
	var exists := false
	if not directory.dir_exists(path):
		var error_code = directory.make_dir(path)
		exists = true
		if error_code != OK:
			printerr(DIR_ERR % [path, error_code])
			exists = false
	else:
		exists = true
	return exists
