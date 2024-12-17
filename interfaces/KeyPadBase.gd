extends Menue
class_name KeyPadBase

signal codeMatch(sender:KeyPad)
signal codeError(sender:KeyPad)

signal codeClose(sender:KeyPad)

@export_category("KeyPad Options")
@export var codeSize = 4
@export var result:String = "----"
@export var elementActive = true:
	get:
		return elementActive
	set(val):
		elementActive = val
		if elementActive:
			clearCode()
			self.process_mode = Node.PROCESS_MODE_INHERIT
			self.show()
		else:
			self.process_mode = Node.PROCESS_MODE_DISABLED
			self.hide()

var currentCode:String = "":
	set(val):
		currentCode = val
		setCurrentCode(currentCode)
	get:
		return currentCode

func setCurrentCode(text):
	pass # for overwrite

func _on_number_clicked(key, char):
	if elementActive:
		if currentCode.length() >= codeSize:
			checkCode()
		else:
			currentCode = currentCode + char

func _on_clear_clicked(key, char):
	clearCode()

func _on_enter_clicked(key, char):
	checkCode()

func closeKeypad():
	codeClose.emit(self)
	clearCode()
	elementActive = false


func checkCode():
	if elementActive:
		if currentCode == result:
			codeMatch.emit(self)
		else:
			currentCode = ""
			codeError.emit(self)

func clearCode():
	currentCode = ""
