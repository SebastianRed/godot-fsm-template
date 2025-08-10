<div align="center">
  <img src="https://img.shields.io/badge/Godot_Engine-4.x-478CBF?style=for-the-badge&logo=godot-engine&logoColor=white" alt="Godot Engine 4.x">
  <img src="https://img.shields.io/badge/GDScript-4.x-478CBF?style=for-the-badge&logo=gdscript&logoColor=white" alt="GDScript 4.x">
  <img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" alt="License: MIT">
</div>
<h1 align="center">🚀 Godot State Machine Template</h1>

<p>
  Este repositorio es una plantilla lista para usar en proyectos de Godot, con una máquina de estados finitos (FSM) modular y robusta. 
  Ideal para gestionar el comportamiento de personajes y entidades de forma organizada y escalable.
</p>

<h3>💡 ¿Cómo usar esta plantilla?</h3>
<p>
Hacer clic en el botón <strong>"Use this template"</strong> para crear un nuevo proyecto basado en esta estructura.
</p>

<h2>⚙️ Estructura de la Máquina de Estados</h2>
<p>
La FSM se compone de dos scripts principales, diseñados para ser flexibles y fáciles de extender.
</p>

<h3><code>state.gd</code> - El Estado Base</h3>
<p>
  Este script define la funcionalidad básica para cualquier estado. Cada nuevo estado que se cree deberá heredar de <code>State</code>.
  <span class="warning">No modificar este archivo base.</span> En su lugar, crear nuevos scripts que hereden de él para definir estados específicos.
</p>

<pre><code>class_name State extends Node
  func enter() -> void: ...
  func process(_delta: float) -> void: ...
  func physics_process(_delta: float) -> void: ...
  func exit() -> void: ...
</code></pre>

<h3><code>state_machine.gd</code> - El Contenedor de Estados</h3>
<p>
  Este script es el corazón de la FSM. Actúa como un contenedor que gestiona las transiciones entre los estados.
  Basta con arrastrar los nodos de los estados (que heredan de <code>State</code>) como hijos de este nodo en una escena.
</p>

<pre><code>class_name StateMachine extends Node
  @export var initial_state_name: String = ""
  func transition_to(state_name: String) -> void: ...
</code></pre>
</div>

<h2>🎬 Ejemplo de Uso</h2>
<p>
Para usar la FSM, se necesita lo siguiente en una escena:
</p>
<ol>
  <li>Un nodo principal (por ejemplo, un <code>CharacterBody2D</code>).</li>
  <li>Un nodo <code>StateMachine</code> como hijo del nodo principal.</li>
  <li>Nodos que hereden de <code>State</code> como hijos del <code>StateMachine</code>.</li>
</ol>
<p>
Se configura el <code>initial_state_name</code> en el inspector del nodo <code>StateMachine</code> para indicar el estado inicial.
</p>

<pre><code>func _ready():
  var state_machine_node = $StateMachine
  if state_machine_node:
        state_machine_node.set_character_context(self)
</code></pre>

<h2>🤝 Notas</h2>

<p>Este es un proyecto personal de aprendizaje. </p>
