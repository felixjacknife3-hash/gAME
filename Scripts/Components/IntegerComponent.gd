extends Node
class_name IntegerComponent

@export var value: int = 0

func addValue(val: int) -> void:
	value += val
func subtractValue(val: int) -> void:
	value -= val
func multiplyValue(val: int) -> void:
	value *= val
func divideValue(val: int) -> void:
	value = roundi(float(value) / val)
func exponentValue(power: int) -> void:
	value **= power
