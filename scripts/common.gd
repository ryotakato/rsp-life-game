extends RefCounted

class_name Common

enum Kind {
	ROCK,
	SCISSORS,
	PAPER,
	NONE
}

static func kind_string(k:Kind) -> String:
	match k:
		Kind.ROCK:
			return "Rock"
		Kind.SCISSORS:
			return "Scissors"
		Kind.PAPER:
			return "Paper"
		_:
			return "None"

static var kind_color_dict = {
	Kind.ROCK: Color8(255, 182, 193), # lightpink
	Kind.SCISSORS: Color8(135, 206, 250), # lightskyblue
	Kind.PAPER: Color8(255, 255, 224), # lightyellow
	Kind.NONE: Color8(211, 211, 211) # lightgray
}

static func kind_color(k:Kind) -> Color:
	return kind_color_dict[k]
