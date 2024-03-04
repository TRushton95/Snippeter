@tool
extends PanelContainer
class_name Snippeter_QuickSelect

@export var _option_scene : PackedScene

@onready var _option_container : VBoxContainer = $VBoxContainer/PanelContainer/VBoxContainer
@onready var _search_edit : LineEdit = $VBoxContainer/LineEdit

var _snippets : Array[Snippeter_Snippet]


func _on_line_edit_text_changed(text: String) -> void:
	_clear()
	
	var matching_snippets = _get_matching_snippets(text)
	_push_snippets(matching_snippets)


func _on_option_selected(snippet_name: String, snippet_data: String) -> void:
	DisplayServer.clipboard_set(snippet_data)


func _ready() -> void:
	name = "Snippeter"
	refresh()


func refresh() -> void:
	_clear()
	_load_snippets()
	
	var matching_snippets = _get_matching_snippets(_search_edit.text)
	_push_snippets(matching_snippets)


func _clear() -> void:
	for option in _option_container.get_children():
		option.queue_free()


func _load_snippets() -> void:
	_snippets = Snippeter_Disk.read_all_snippets()


func _push_snippets(snippets: Array[Snippeter_Snippet]):
	for snippet in snippets:
		var option = _option_scene.instantiate()
		_option_container.add_child(option)
		option.setup(snippet.get_name())
		option.selected.connect(_on_option_selected.bind(snippet.get_name(), snippet.get_data()))


func _get_matching_snippets(search_string: String) -> Array[Snippeter_Snippet]:
	var result = [] as  Array[Snippeter_Snippet]
	
	for snippet in _snippets:
		if snippet.get_name().begins_with(search_string):
			result.push_back(snippet)
			
	return result
