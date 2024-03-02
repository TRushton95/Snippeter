@tool
extends PanelContainer
class_name Menu

signal snippets_updated

@export var listing_scene : PackedScene

@onready var _listing_container : VBoxContainer = $MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/VBoxContainer
@onready var _editor : Editor = $Editor
@onready var _main_scene : Node = $MarginContainer


func _on_add_button_pressed() -> void:
	_editor.clear()
	goto_editor()


func _on_listing_copy_button_pressed(snippet_name: String) -> void:
	var snippet_content = Disk.read_snippet_data(snippet_name)
	
	if snippet_content != null:
		DisplayServer.clipboard_set(snippet_content)


func _on_listing_edit_button_pressed(snippet_name: String) -> void:
	var snippet_content = Disk.read_snippet_data(snippet_name)
	var snippet = Snippet.new(snippet_name, snippet_content)
	_editor.populate(snippet)
	goto_editor()


func _on_listing_remove_button_pressed(snippet_name: String) -> void:
	Disk.delete(snippet_name)
	remove_listing(snippet_name)
	snippets_updated.emit()


func _on_editor_save_button_pressed(snippet: Snippet) -> void:
	Disk.save_snippet(snippet.get_data(), snippet.get_name())
	add_listing(snippet.get_name())
	goto_main()
	snippets_updated.emit()


func _on_editor_cancel_button_presssed() -> void:
	goto_main()


func _ready() -> void:
	for snippet in Disk.read_all_snippets() as Array[Snippet]:
		add_listing(snippet.get_name())


func add_listing(snippet_name: String) -> void:
	if _listing_container.has_node(snippet_name):
		return
	
	var listing : Listing = listing_scene.instantiate()
	listing.name = snippet_name
	_listing_container.add_child(listing)
	listing.setup(snippet_name)
	listing.copy_button_pressed.connect(_on_listing_copy_button_pressed)
	listing.edit_button_pressed.connect(_on_listing_edit_button_pressed)
	listing.delete_button_pressed.connect(_on_listing_remove_button_pressed)


func remove_listing(snippet_name: String) -> void:
	if _listing_container.has_node(snippet_name):
		_listing_container.get_node(snippet_name).queue_free()


func goto_editor() -> void:
	_main_scene.hide()
	_editor.show()


func goto_main() -> void:
	_editor.hide()
	_main_scene.show()
