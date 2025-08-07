class_name State extends Node

var parent_state_machine: StateMachine = null
var character_context: CharacterBody2D = null

func _ready() -> void:
    pass

func enter() -> void:
    pass

func process(_delta: float) -> void:
    pass

func physics_process(_delta: float) -> void:
    pass

func exit() -> void:
    pass

func handle_input(_event: InputEvent) -> void:
    pass

func transition_to(state_name: String) -> void:
    if parent_state_machine:
        parent_state_machine.transition_to(state_name)

func set_character_context(context: CharacterBody2D) -> void:
    character_context = context

func set_parent_state_machine(state_machine: StateMachine) -> void:
    parent_state_machine = state_machine