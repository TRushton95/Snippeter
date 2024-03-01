extends PanelContainer

@export var _option_scene : PackedScene

@onready var _option_container : VBoxContainer = $VBoxContainer/PanelContainer/VBoxContainer

var _snippets : Array[Snippet]


func _on_focus_exited() -> void:
	clear()


func _on_line_edit_focus_entered() -> void:
	push_snippets(_snippets)


func _on_line_edit_text_changed(text: String) -> void:
	clear()
	
	var matching_snippets = get_matching_snippets(text)
	push_snippets(matching_snippets)


func _on_option_selected(snippet_name: String, snippet_data: String) -> void:
	DisplayServer.clipboard_set(snippet_data)
	clear()


func _ready() -> void:
	load_snippets()


func load_snippets() -> void:
	_snippets = Disk.read_all_snippets()


func push_snippets(snippets: Array[Snippet]):
	for snippet in snippets:
		var option = _option_scene.instantiate()
		_option_container.add_child(option)
		option.setup(snippet.get_name())
		option.selected.connect(_on_option_selected.bind(snippet.get_name(), snippet.get_data()))


func get_matching_snippets(search_string: String) -> Array[Snippet]:
	var result = [] as  Array[Snippet]
	
	for snippet in _snippets:
		if snippet.get_name().begins_with(search_string):
			result.push_back(snippet)
			
	return result


func clear() -> void:
	for option in _option_container.get_children():
		option.queue_free()
