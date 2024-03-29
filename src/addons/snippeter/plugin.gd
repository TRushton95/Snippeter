@tool
extends EditorPlugin

var menu : Control
var quick_select : Control


func _on_snippeter_snippets_updated() -> void:
	quick_select.refresh()


func _enter_tree() -> void:
	menu = load("res://addons/snippeter/menu/menu.tscn").instantiate()
	add_control_to_container(CustomControlContainer.CONTAINER_PROJECT_SETTING_TAB_RIGHT, menu)
	
	quick_select = load("res://addons/snippeter/quick_select/quick_select.tscn").instantiate()
	add_control_to_dock(EditorPlugin.DOCK_SLOT_RIGHT_UL, quick_select)
	
	menu.snippets_updated.connect(_on_snippeter_snippets_updated)


func _exit_tree() -> void:
	remove_control_from_container(CustomControlContainer.CONTAINER_PROJECT_SETTING_TAB_RIGHT, menu)
	remove_control_from_docks(quick_select)
	
	if menu != null:
		menu.free()
		menu = null
		
	if quick_select != null:
		quick_select.free()
		quick_select = null
