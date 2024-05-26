extends StaticBody3D
class_name BottlingMachine

@onready var point_input_snap = %PointInputSnap
@onready var point_filling = %PointFilling
@onready var point_output = %PointOutput

@onready var color_display = %ColorDisplay
@export var fillingType:FillableBox.FillingType = FillableBox.FillingType.Black

const place_sound_array:Array = [
	"kenney_CC/impactMining_000.ogg",
	"kenney_CC/impactMining_001.ogg",
	"kenney_CC/impactMining_002.ogg",
	"kenney_CC/impactMining_003.ogg",
	"kenney_CC/impactMining_004.ogg"]

const fill_sound:Array = ["kenney_CC/phaserDown2.ogg"]

const done_sound:Array = ["kenney_CC/threeTone1.ogg"]
var box:FillableBox = null

func _ready():
	var mat:StandardMaterial3D = StandardMaterial3D.new()
	mat.albedo_color = fillingTypeToColor(fillingType)
	color_display.material_override = mat


func _on_input_zone_body_entered(body):
	if body is FillableBox and null == box:
		box = body
		body.pickedUp()
		
		var tween = get_tree().create_tween()
		tween.parallel()
		tween.tween_property(box, "position",\
			point_input_snap.global_position, 0.25)
		tween.parallel()
		tween.tween_property(box, "rotation",\
			point_input_snap.global_rotation, 0.125)
		
		tween.tween_property(box, "position",\
			point_input_snap.global_position, 0.5)
		tween.tween_callback(box_placed_tween)
		tween.play()

func box_placed_tween():
	Audio.play(place_sound_array)
	var tween = get_tree().create_tween()
	tween.tween_property(box, "position",\
		point_filling.global_position, 2.0)
	tween.tween_callback(box_mid_tween)
	tween.play()

func box_mid_tween():
	Audio.play(fill_sound)
	box.fill(fillingType)
	var tween = get_tree().create_tween()
	tween.tween_property(box, "position",\
		point_filling.global_position, 2.0)
	tween.tween_property(box, "position",\
		point_output.global_position, 2.0)
	tween.tween_callback(box_end_tween)
	tween.play()

func box_end_tween():
	Audio.play(done_sound)
	box.dropped()
	box = null;


func fillingTypeToColor(filling) -> Color:
	if filling == FillableBox.FillingType.White:
		return Color.WHITE
	elif filling == FillableBox.FillingType.Black:
		return Color.BLACK

	elif filling == FillableBox.FillingType.Red:
		return Color.RED
	elif filling == FillableBox.FillingType.Green:
		return Color.GREEN
	elif filling == FillableBox.FillingType.Blue:
		return Color.BLUE

	elif filling == FillableBox.FillingType.Yellow:
		return Color.YELLOW
	elif filling == FillableBox.FillingType.Cyan:
		return Color.CYAN
	elif filling == FillableBox.FillingType.Pink:
		return Color.RED
	else:
		return Color.TRANSPARENT
