<script>
	import ArrowRight from "carbon-icons-svelte/lib/ArrowRight.svelte";
	import ArrowLeft from "carbon-icons-svelte/lib/ArrowLeft.svelte";
	import TrashCan from "carbon-icons-svelte/lib/TrashCan.svelte";
	import Save from "carbon-icons-svelte/lib/Save.svelte";
	import Edit from "carbon-icons-svelte/lib/Edit.svelte";
	import { writable } from "svelte/store";
	import { deleteTodo, getTodos, putTodo } from "../api";

	export var todo;
	export var updateTodos;
	const disabled = writable(true);
	let editedTodo = todo.content;

	function enableInput() {
		editedTodo = todo.content;
		disabled.set(false);
	}

	const updateTodo = (todo) => {
		todo.content = editedTodo;
		putTodo(todo).then((response) => {
			todo = response;
			editedTodo = todo.content;
			getTodos;
			disabled.set(true);
			updateTodos();
		});
	};

	const removeTodo = (todo) => {
		deleteTodo(todo).then((response) => {
			todo = response;
			updateTodos();
		});
	};
</script>

<div
	class="py-3 px-2 w-full bg-white drop-shadow-md rounded-md my-3 hover:bg-gray-100 flex"
>
	{#if todo.status === "doing" || todo.status === "done"}
		<button
			class="align-middle rounded-md p-1 mx-1 hover:text-red-500 flex"
			on:click={() => {
				if (todo.status === "doing") {
					todo.status = "todo";
				} else {
					todo.status = "doing";
				}
				updateTodo(todo);
			}}
		>
			<ArrowLeft />
		</button>
	{/if}
	<input
		type="text"
		id="todo"
		class="align-middle w-full text-left bg-transparent text-gray-500 outline-none"
		class:text-gray-900={!$disabled}
		value={editedTodo}
		disabled={$disabled}
		on:input={(event) => (editedTodo = event.target.value)}
	/>
	{#if $disabled}
		<button
			class="align-middle rounded-md p-1 mx-1 hover:text-orange-500 flex"
			on:click={enableInput}
		>
			<Edit />
		</button>
	{:else}
		<button
			class="align-middle rounded-md p-1 mx-1 hover:text-sky-500 flex"
			on:click={() => updateTodo(todo)}
		>
			<Save />
		</button>
	{/if}
	<button
		class="align-middle rounded-md p-1 mx-1 hover:text-red-500 flex"
		on:click={() => removeTodo(todo)}
	>
		<TrashCan />
	</button>
	{#if todo.status === "todo" || todo.status === "doing"}
		<button
			class="align-middle rounded-md p-1 mx-1 hover:text-green-500 flex"
			on:click={() => {
				if (todo.status === "todo") {
					todo.status = "doing";
				} else {
					todo.status = "done";
				}
				updateTodo(todo);
			}}
		>
			<ArrowRight />
		</button>
	{/if}
</div>
