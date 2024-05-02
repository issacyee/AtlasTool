@tool
extends EditorPlugin

const BASE: String = "AtlasTexture"
const TYPE: String = "AtlasTextureTool"


func _enter_tree():
	# Initialization of the plugin goes here.
	add_custom_type(TYPE, BASE, preload("scripts/atlas_texture_tool.gd"), preload("assets/AtlasTexture.svg"))


func _exit_tree():
	# Clean-up of the plugin goes here.
	remove_custom_type(TYPE)
