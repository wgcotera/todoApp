<script>
	import Add from "carbon-icons-svelte/lib/Add.svelte";
	import TailwindCss from "./TailwindCSS.svelte";
	import Todo from "./components/Todo.svelte";
	import { writable } from "svelte/store";
	import { getTodos, postTodo } from "./api";

	const todos = writable([]);
	const doings = writable([]);
	const dones = writable([]);
	const status = writable(null);

	const updateTodos = () => {
		getTodos().then((response) => {
			todos.set(response.filter((todo) => todo.status === "todo"));
			doings.set(response.filter((todo) => todo.status === "doing"));
			dones.set(response.filter((todo) => todo.status === "done"));
		});
	};

	getTodos().then((response) => {
		todos.set(response.filter((todo) => todo.status === "todo"));
		doings.set(response.filter((todo) => todo.status === "doing"));
		dones.set(response.filter((todo) => todo.status === "done"));
	});

	const createTodo = (event) => {
		event.preventDefault();
		var input_content = event.target.todo.value;
		const todo = {
			content: input_content,
			status: $status ?? "todo",
		};
		postTodo(todo).then((response) => {
			console.log(response);
			status.set(null);
			updateTodos();
			event.target.todo.value = "";
		});
	};

	const setStateForNewTodo = (state) => {
		status.set(state);
		document.getElementById("todo").focus();
	};
</script>

<TailwindCss />
<section class="body-font">
	<div class="container px-5 py-24 mx-auto">
		<div class="py-10">
			<h1 class="text-center text-red-800 opacity-25 text-8xl">todos</h1>
			<form on:submit={createTodo} method="post" class="flex justify-center">
				<input
					type="text"
					id="todo"
					placeholder="What needs to be done?"
					class="py-7 px-10 drop-shadow-lg rounded-lg text-center mt-5 w-1/2 hover:bg-gray-100"
				/>
			</form>
		</div>
		<div class="flex justify-around w-3/4 m-auto text-center">
			<!-- todo -->
			<div class="w-full mx-2">
				<div class="bg-red-200">
					<h1>To Do</h1>
				</div>
				{#each $todos as todo}
					<Todo {todo} {updateTodos} />
				{/each}
				<button
					class="w-full pt-3 pb-2 px-2 my-5 flex align-middle drop-shadow-md text-gray-500 hover:bg-gray-100"
					on:click={() => setStateForNewTodo("todo")}
				>
					<Add size={26} />
					<span>New</span>
				</button>
			</div>
			<!-- doing -->
			<div class="w-full mx-2">
				<div class="bg-orange-200">
					<h1>Doing</h1>
				</div>
				{#each $doings as todo}
					<Todo {todo} {updateTodos} />
				{/each}
				<button
					class="w-full pt-3 pb-2 px-2 my-5 flex align-middle drop-shadow-md text-gray-500 hover:bg-gray-100"
					on:click={() => setStateForNewTodo("doing")}
				>
					<Add size={26} />
					<span>New</span>
				</button>
			</div>
			<!-- done -->
			<div class="w-full mx-2">
				<div class="bg-green-200">
					<h1>Done</h1>
				</div>
				{#each $dones as todo}
					<Todo {todo} {updateTodos} />
				{/each}
				<button
					class="w-full pt-3 pb-2 px-2 my-5 flex align-middle drop-shadow-md text-gray-500 hover:bg-gray-100"
					on:click={() => setStateForNewTodo("done")}
				>
					<Add size={26} />
					<span>New</span>
				</button>
			</div>
		</div>
	</div>
</section>
