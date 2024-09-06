class_name CheatCode extends Resource

enum CODE_ACTIONS {Empty, Up, Down, Left, Right}

@export var name: String
@export var effect: String
@export var sequence: Array[CODE_ACTIONS]
var sequence_idx: int = 0

# Whether the code was used already
var code_used: bool = false

## Advances the cheat code
## Returns true if sequence is finished
func check_code(input: CODE_ACTIONS) -> bool:
	if code_used:
		return false
	
	if input == sequence[sequence_idx]:
		if sequence_idx == (sequence.size() -1):
			sequence_idx = 0
			code_used = true
			return true
		else:
			sequence_idx += 1
	else:
		sequence_idx = 0
	return false
