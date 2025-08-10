class_name State extends Node

var parent_state_machine: StateMachine
var character_context: CharacterBody2D

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

func play_animation(anim_name: String, connect_signal := false, signal_method: String = "") -> void:
	if not character_context:
		return
	
	var sprite: AnimatedSprite2D = character_context.get_node_or_null("AnimatedSprite2D")
	if sprite:
		sprite.play(anim_name)
		
		if connect_signal and signal_method != "":
			var callable = Callable(self, signal_method)
			
			# Evitar múltiples conexiones
			if not sprite.animation_finished.is_connected(callable):
				sprite.animation_finished.connect(callable)

func stop_animation_signal(signal_method: String = "") -> void:
	if not character_context:
		return
	
	var sprite: AnimatedSprite2D = character_context.get_node_or_null("AnimatedSprite2D")
	if sprite and signal_method != "":
		var callable = Callable(self, signal_method)
		if sprite.animation_finished.is_connected(callable):
			sprite.animation_finished.disconnect(callable)

func get_input_direction() -> float:
	return Input.get_axis("move_left", "move_right")

func flip_sprite_by_direction(direction: float) -> void:
	if not character_context:
		return
	
	var sprite: AnimatedSprite2D = character_context.get_node_or_null("AnimatedSprite2D")
	if sprite and direction != 0:
		sprite.flip_h = direction < 0