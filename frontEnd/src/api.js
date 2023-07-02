const baseURL = 'http://localhost:4567';

export const getTodos = async () => {
    const response = await fetch(`${baseURL}/`);
    const todos = await response.json();
    console.log(todos);
    return todos;
}

export const postTodo = async (todo) => {
    const response = await fetch(`${baseURL}/todos`, {
        method: 'POST',
        mode: 'cors',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(todo)
    });
    const todos = await response.json();
    return todos;
}

export const putTodo = async (todo) => {
    const response = await fetch(`${baseURL}/todos/${todo.id}`, {
        method: 'PUT',
        mode: 'cors',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(todo)
    });
    const todos = await response.json();
    console.log(todos);
    return todos;
}

export const deleteTodo = async (todo) => {
    console.log(todo);
    const response = await fetch(`${baseURL}/todos/${todo.id}`, {
        method: 'DELETE',
        mode: 'cors',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(todo)
    });
    const todos = await response.json();
    console.log(todos);
    return todos;
}
