extends Label

export var separator = "  "

func from(position, name, score):
	var _position = str(position)
	_position+="."
	if _position.length()<3:
		_position+=" "
	
	var _name = name
	while _name.length()<SaveRecord.max_name_length:
		_name += " "
	
	var _score = StringUtils.to_minutes(score)
	
	
	text = _position + separator + _name + separator + _score
	
