<script>
	import TailwindCss from "./TailwindCSS.svelte";
</script>

<TailwindCss />
<section class="text-gray-600 body-font">
	<div class="container px-5 py-24 mx-auto">
        <div class="py-10">
            <h1 class="text-center text-red-800 opacity-25 text-8xl">todos</h1>
            <form action="/" method="post" class="flex justify-center">
                <input type="text" id="todo" placeholder="What needs to be done?" class="py-7 px-10 drop-shadow-lg rounded-lg text-center mt-5">
            </form>
        </div>
        <div class="flex justify-around">
            <!-- todo -->
            <div class="">
                <h1>To Do</h1>
            </div>
            <!-- doing -->
            <div>
                <h1>Doing</h1>
            </div>
            <!-- done -->
            <div>
                <h1>Done</h1>
            </div>
        </div>
	</div>
</section> 