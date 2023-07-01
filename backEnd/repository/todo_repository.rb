class TodoRepository

    def create(request_data)
        @todo = Todo.new(request_data[:todo])
        raise TodoNotSaved unless @todo.save
        @todo
    end

    def update(id, request_data)
        @todo = Todo.find_by(id: id)
        raise TodoNotFound unless @todo
        @todo.content = request_data[:content] if request_data.key?[:content]
        @todo.status = request_data[:status] if request_data.key?[:status]
        raise TodoNotUpdated unless @todo.save
        @todo
    end

    def delete(id)
        @todo = Todo.find_by(id: id)
        raise TodoNotFound unless @todo
        raise TodoNotDeleted unless @todo.destroy
    end
end