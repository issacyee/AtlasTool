@tool
extends AtlasTexture
class_name AtlasTextureTool


@export_global_dir var save_path: String
@export var preview: Image
@export var rotation: int = 0:
	set(value):
		rotation = value
		cut_out()
@export var left_rotate: bool:
	set(value):
		var rt = rotation
		rt -= 1
		rt %= 4
		rotation = rt
@export var right_rotate: bool:
	set(value):
		var rt = rotation
		rt += 1
		rt %= 4
		rotation = rt
@export var refresh: bool = false:
	set(value):
		cut_out()
@export var save_png: bool = false:
	set(value):
		save_image()
		
func cut_out() -> void:
	if not atlas:
		printerr("没有设置图集")
		return
	var image := atlas.get_image()
	if not image:
		printerr("图像为空")
		return
	preview = image.get_region(region)
	if rotation < 0:
		for i in abs(rotation):
			preview.rotate_90(COUNTERCLOCKWISE)
	if rotation > 0:
		for i in abs(rotation):
			preview.rotate_90(CLOCKWISE)
		
func save_image() -> void:
	if not save_path:
		print("没有设置保存路径")
		return
	if not atlas:
		print("没有设置图集")
		return
	if not preview:
		return
	var resouce_path = atlas.resource_path
	var prefix = "res://"
	if resouce_path.begins_with(prefix):
		resouce_path = resouce_path.substr(len(prefix))
	var last_dot_idx = resouce_path.rfind(".")
	if last_dot_idx != -1:
		resouce_path = resouce_path.substr(0, last_dot_idx)
	var dir = "%s/%s" % [save_path, resouce_path]
	if not DirAccess.dir_exists_absolute(dir):
		var err = DirAccess.make_dir_recursive_absolute(dir)
		if err:
			printerr(err)
			return
	var save_path = "%s/x%d_y%d_w%d_h%d.png" % [dir, region.position.x, region.position.y, region.size.x, region.size.y]
	var err = preview.save_png(save_path)
	if err != OK:
		printerr(err)
		return
	print("图像已保存到%s" % [save_path])
