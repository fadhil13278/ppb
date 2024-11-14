// services/todo_service.dart
import 'package:fluttertodolistsqfliteapp/models/todo.dart';
import 'package:fluttertodolistsqfliteapp/repositories/repository.dart';

class TodoService {
  Repository _repository;

  TodoService() {
    _repository = Repository();
  }

  // Create todos
  saveTodo(Todo todo) async {
    return await _repository.insertData('todos', todo.todoMap());
  }

  // Read all todos
  readTodos() async {
    return await _repository.readData('todos');
  }

  // Read todos by category
  readTodosByCategory(category) async {
    return await _repository.readDataByColumnName('todos', 'category', category);
  }

  // Update todo
  updateTodo(Todo todo) async {
    return await _repository.updateData('todos', todo.todoMap());
  }

  // Delete todo
  deleteTodo(int id) async {
    return await _repository.deleteData('todos', id);
  }
}
