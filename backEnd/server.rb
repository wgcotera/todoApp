require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/json'
require 'json'

require './models/todo'
require_relative './repository/todo_repository'
require_relative 'exceptions/todo_exceptions'

set :database, {adapter: 'sqlite3', database: 'todos.db'}

todo_repository = TodoRepository.new

get '/' do
    @todos = Todo.all
    json @todos
end

post '/todos' do
    request_data = JSON.parse(request.body.read, symbolize_names: true)    
    result = todo_repository.create(request_data)
    status 201
    json result
    rescue TodoNotSaved => e
        status 400
        json e.message
end

put '/todos/:id' do
    request_data = JSON.parse(request.body.read, symbolize_names: true)
    result = todo_repository.update(params[:id], request_data)
    status 200
    json result
    rescue TodoNotFound => e
        status 404
        json e.message
    rescue TodoNotUpdated => e
        status 400
        json e.message
end

delete '/todos/:id' do
    result = todo_repository.delete(params[:id])
    status 200
    json result
    rescue TodoNotFound => e
        status 404
        json e.message
    rescue TodoNotDeleted => e
        status 400
        json e.message
end