extends Control


const DIR_ERR = 'ERROR: Failed to create directory "%s". Error code %s.'

# Equivalent to '~/Documents/AseScale' in Linux
var export_path := OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)+"/AseScale"

var file_path := ""

onready var format_btn := $Center/Info/Options/Format
onready var scales_btn := $Center/Info/Options/Scales
onready var format := 0
onready var scales := 0


func _ready() -> void:
	# Connect signal for drag-and-drop
	get_tree().connect("files_dropped", self, "_get_files_path")


func _get_files_path(files: PoolStringArray, _screen: int) -> void:
	file_path = files[0]
	if not file_path.empty():
		_ase_cli()


func _ase_cli() -> void:
	# Create directory first if it doesn't exist yet
	var directory := Directory.new()

	if _create_directory(directory, export_path) == true:
		# Copy original file name and rename it on outputs
		var output_name := file_path.get_file().get_basename()

		var file_format := ""
		match format:
			0: file_format = "png"
			1: file_format = "gif"

		for export_size in scales+2:
			if export_size == 0:
				OS.execute("aseprite", ["--batch" , file_path, "--scale", "1", "--save-as", export_path + "/" + output_name + "_x1."+file_format])
			else:
				OS.execute("aseprite", ["--batch" , file_path, "--scale", String((export_size)*2), "--save-as", export_path + "/" + output_name + "_x"+String((export_size)*2)+"."+file_format])


func _create_directory(directory: Directory, path: String) -> bool:
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


func _on_Format_item_selected(index: int) -> void:
	format = index


func _on_Scales_item_selected(index: int) -> void:
	scales = index
