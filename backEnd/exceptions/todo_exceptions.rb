class TodoNotFound < StandardError
    def initialize(msg="Todo not found")
        super(msg)
    end
end

class TodoNotSaved < StandardError
    def initialize(msg="Todo not saved")
        super(msg)
    end
end

class TodoNotUpdated < StandardError
    def initialize(msg="Todo not updated")
        super(msg)
    end
end

class TodoNotDeleted < StandardError
    def initialize(msg="Todo not deleted")
        super(msg)
    end
end