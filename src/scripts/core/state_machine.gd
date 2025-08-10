class_name StateMachine
extends Node

@export var initial_state_name: String = ""

var states: Dictionary = {}
var current_state: State
var previous_state: State
var character_context: CharacterBody2D

func _ready() -> void:
	# Registrar estados
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.set_parent_state_machine(self)
			child.set_character_context(character_context)

	# Estado inicial
	if initial_state_name and states.has(initial_state_name):
		transition_to(initial_state_name)
	elif states.size() > 0:
		transition_to(states.keys()[0])
	else:
		push_warning("StateMachine: No hay estados válidos.")

func _process(delta: float) -> void:
	if current_state:
		current_state.process(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_process(delta)

func _input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)

func transition_to(state_name: String) -> void:
	if not states.has(state_name):
		push_error("StateMachine: Estado no existente: ", state_name)
		return

	# Evitar transiciones redundantes
	if current_state and current_state.name == state_name:
		return

	# Salir del estado actual
	if current_state:
		current_state.exit()
		previous_state = current_state

	# Cambiar de estado
	current_state = states[state_name]
	current_state.enter()
	print("FSM → Estado:", state_name)

func return_to_previous_state() -> void:
	if previous_state:
		transition_to(previous_state.name)

func set_character_context(context: CharacterBody2D) -> void:
	character_context = context
	for state in states.values():
		state.set_character_context(character_context)