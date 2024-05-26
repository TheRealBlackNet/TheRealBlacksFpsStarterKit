extends PickupableInterface
class_name FillableBox

@onready var white = %White
@onready var black = %Black

@onready var red = %Red
@onready var green = %Green
@onready var blue = %Blue

@onready var rg_y = %"RG-Y"
@onready var gb_c = %"GB-C"
@onready var rb_p = %"RB-P"

enum FillingType {
	Clear,
	White,Black,
	Red, Green, Blue,
	Yellow, Cyan, Pink
}

@export var filling:FillingType = FillingType.Clear

var allArr:Array

func _ready():
	allArr = [white, black, red, green, blue, rg_y, gb_c, rb_p]
	updateItem()

func fill(fill:FillingType):
	if  FillingType.Clear == fill:
		filling = FillingType.Clear
	elif FillingType.Clear == filling\
		or FillingType.White == filling:
			filling = fill
	elif fill == filling:
		pass # DO NOTHING
	elif FillingType.Red == filling:
		if FillingType.Green == fill:
			filling = FillingType.Yellow
		elif FillingType.Blue == fill:
			filling = FillingType.Pink
		else:
			filling = FillingType.Black # DEAD
	elif FillingType.Green == filling:
		if FillingType.Red == fill:
			filling = FillingType.Yellow
		elif FillingType.Blue == fill:
			filling = FillingType.Cyan
		else:
			filling = FillingType.Black # DEAD
	elif FillingType.Blue == filling:
		if FillingType.Red == fill:
			filling = FillingType.Pink
		elif FillingType.Green == fill:
			filling = FillingType.Cyan
		else:
			filling = FillingType.Black # DEAD
	else:
		filling = FillingType.Black # DEAD

	updateItem()

func updateItem():
	for x: Node3D in allArr:
		x.hide()
	
	if FillingType.White == filling:
		white.show()
	elif FillingType.Black == filling:
		black.show()
	elif FillingType.Red == filling:
		red.show()
	elif FillingType.Green == filling:
		green.show()
	elif FillingType.Blue == filling:
		blue.show()
	elif FillingType.Yellow == filling:
		rg_y.show()
	elif FillingType.Cyan == filling:
		gb_c.show()
	elif FillingType.Pink == filling:
		rb_p.show()


