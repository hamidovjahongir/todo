import 'package:todo/features/home/data/model/todo_mode.dart';
import 'package:todo/features/home/data/repository/local_db.dart';

class TodoRepository {
  final LocalDb localDb = LocalDb();

  Future<TodoMode> addToDo(TodoMode todo) async {
    await localDb.saveDb(todo);
    return todo;
  }

  Future<List<TodoMode>> getToDo() async {
    return await localDb.getDb();
  }

  Future<void> removeToDo(int id) async {
    await localDb.removeTodo(id);
  }

  Future<void> updateTodo(TodoMode todo) async {
    await localDb.updateTodo(todo);
  }

  Future<void> isDone(int todoId, bool done) async {
    await localDb.done(done, todoId);
  }

  Future<void> clearAll() async {
    await localDb.clearAll();
  }

  Future<List<TodoMode>> getCompleted() async {
    return await localDb.getCompletedTodos();
  }

  Future<void> addToCompleted(TodoMode todo) async {
    await localDb.addToCompleted(todo);
  }
}