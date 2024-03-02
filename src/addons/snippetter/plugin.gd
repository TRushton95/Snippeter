@tool
extends EditorPlugin

var menu : Menu
var quick_select : QuickSelect


func _on_snippetter_snippets_updated() -> void:
	print("snippets updated, refreshing quick_select")
	quick_select.refresh()


func _enter_tree() -> void:
	menu = load("res://addons/snippetter/menu/menu.tscn").instantiate()
	add_control_to_container(CustomControlContainer.CONTAINER_PROJECT_SETTING_TAB_LEFT, menu)
	
	quick_select = load("res://addons/snippetter/quick_select/quick_select.tscn").instantiate()
	add_control_to_dock(EditorPlugin.DOCK_SLOT_RIGHT_UL, quick_select)
	
	menu.snippets_updated.connect(_on_snippetter_snippets_updated)


func _exit_tree() -> void:
	remove_control_from_container(CustomControlContainer.CONTAINER_PROJECT_SETTING_TAB_RIGHT, menu)
	remove_control_from_docks(quick_select)
	
	if menu != null:
		menu.free()
		menu = null
		
	if quick_select != null:
		quick_select.free()
		quick_select = null
