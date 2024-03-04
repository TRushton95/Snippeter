extends Object
class_name Snippeter_Disk

const SNIPPETS_DIR =  "res://addons/snippeter/snippets/"
const FILE_FORMAT = "%s.txt"
const PATH_FORMAT = SNIPPETS_DIR + FILE_FORMAT


static func save_snippet(content: String, name: String) -> void:
	if !snippet_file_exists(SNIPPETS_DIR):
		DirAccess.make_dir_recursive_absolute(SNIPPETS_DIR)
		
	var path = PATH_FORMAT % name
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(content)


static func read_snippet_data(name: String) -> String:
	var path = PATH_FORMAT % name
	var file = FileAccess.open(path, FileAccess.READ) as FileAccess
	
	return file.get_as_text()


static func read_all_snippets() -> Array[Snippeter_Snippet]:
	var result = [] as Array[Snippeter_Snippet]
	
	if !DirAccess.dir_exists_absolute(SNIPPETS_DIR):
		return result
	
	var dir = DirAccess.open(SNIPPETS_DIR)
	
	for filename in dir.get_files():
		var file = FileAccess.open(SNIPPETS_DIR + filename, FileAccess.READ) as FileAccess
		var snippet = Snippeter_Snippet.new(file.get_path().get_file().trim_suffix(".txt"), file.get_as_text())
		result.push_back(snippet)
		
	return result


static func snippet_exists(name: String) -> bool:
	var path = PATH_FORMAT % name
	return FileAccess.file_exists(path)


static func delete(snippet_name: String) -> void:
	if !snippet_file_exists(snippet_name):
		return
		
	var file_name = FILE_FORMAT % snippet_name
	var dir = DirAccess.open(SNIPPETS_DIR) as DirAccess
	dir.remove(file_name)


static func snippet_file_exists(name: String) -> bool:
	var path = PATH_FORMAT % name
	return FileAccess.file_exists(path)
