class_name StateMachine extends Node

@export var initial_state_name: String = ""

var states: Dictionary = {}
var current_state: State = null
var character_context: CharacterBody2D = null

func _ready() -> void:
    for child in get_children():
        if child is State:
            states[child.name] = child
            child.set_parent_state_machine(self)
            child.set_character_context(character_context)
    if initial_state_name and states.has(initial_state_name):
        transition_to(initial_state_name)
    else:
        if states.size() > 0:
            var first_state_name = states.keys()[0]
            transition_to(first_state_name)
        else:
            push_warning("StateMachine: No se encontraron estados o initial_state_name no es válido.")

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
    if states.has(state_name):
        if current_state:
            current_state.exit()
        
        current_state = states[state_name]
        current_state.enter()
        print("Transicionando a estado: ", state_name)
    else:
        push_error("StateMachine: Intento de transición a un estado no existente: ", state_name)

func set_character_context(context: CharacterBody2D) -> void:
    character_context = context
    for state in states.values():
        state.set_character_context(character_context)