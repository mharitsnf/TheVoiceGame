extends CanvasLayer

# STORE THE SCENE PATH
var path = ""
var _params = null

# PUBLIC FUNCTION. CALLED WHENEVER YOU WANT TO CHANGE SCENE
func fade_to(scn_path, params = null):
	self.path = scn_path # store the scene path
	self._params = params
	get_node("AnimationPlayer").play("modulate") # play the transition animation

func get_param(name):
	if _params != null and _params.has(name):
		return _params[name]
	return null

# PRIVATE FUNCTION. CALLED AT THE MIDDLE OF THE TRANSITION ANIMATION
func change_scene():
	if path != "":
		get_tree().change_scene(path)
