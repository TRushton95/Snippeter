@tool
extends PanelContainer
class_name Snippetter_Menu

signal snippets_updated

const DELETE_CONFIRMATION_TEXT_FORMAT : String = "Are you sure you want to delete %s?"

@export var listing_scene : PackedScene

@onready var _delete_confirmation_dialog : ConfirmationDialog = $DeleteConfirmationDialog
@onready var _editor : Snippetter_Editor = $Editor
@onready var _listing_container : VBoxContainer = $VBoxContainer/ScrollContainer/MarginContainer/ListingContainer
@onready var _main_scene : Node = $VBoxContainer

var _pending_snippet_deletion : String = ""


func _on_add_button_pressed() -> void:
	_editor.clear()
	_editor.show()


func _on_listing_copy_button_pressed(snippet_name: String) -> void:
	var snippet_content = Snippetter_Disk.read_snippet_data(snippet_name)
	
	if snippet_content != null:
		DisplayServer.clipboard_set(snippet_content)


func _on_listing_edit_button_pressed(snippet_name: String) -> void:
	var snippet_content = Snippetter_Disk.read_snippet_data(snippet_name)
	var snippet = Snippetter_Snippet.new(snippet_name, snippet_content)
	_editor.populate(snippet)
	_editor.show()


func _on_listing_remove_button_pressed(snippet_name: String) -> void:
	_pending_snippet_deletion = snippet_name
	_delete_confirmation_dialog.dialog_text = DELETE_CONFIRMATION_TEXT_FORMAT % snippet_name
	_delete_confirmation_dialog.show()


func _on_delete_confirmation_dialog_canceled() -> void:
	_pending_snippet_deletion = ""


func _on_editor_save_button_pressed(snippet: Snippetter_Snippet) -> void:
	if !_editor.is_edit_mode() && Snippetter_Disk.snippet_exists(snippet.get_name()):
		_editor.show_existing_name_dialog()
		return
	
	Snippetter_Disk.save_snippet(snippet.get_data(), snippet.get_name())
	add_listing(snippet.get_name())
	_editor.hide()
	snippets_updated.emit()


func _on_editor_close_button_presssed() -> void:
	_editor.hide()


func _on_delete_confirmation_dialog_confirmed() -> void:
	if _pending_snippet_deletion == "":
		return
	
	Snippetter_Disk.delete(_pending_snippet_deletion)
	remove_listing(_pending_snippet_deletion)
	snippets_updated.emit()


func _ready() -> void:
	name = "Snippetter"
	
	for snippet in Snippetter_Disk.read_all_snippets() as Array[Snippetter_Snippet]:
		add_listing(snippet.get_name())


func add_listing(snippet_name: String) -> void:
	if _listing_container.has_node(snippet_name):
		return
	
	var listing : Snippetter_Listing = listing_scene.instantiate()
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
