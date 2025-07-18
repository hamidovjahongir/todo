import 'package:hive/hive.dart';
import 'package:telegram_logger/telegram_logger.dart';
import 'package:todo/features/home/data/model/todo_mode.dart';

class LocalDb {
  Future<void> saveDb(TodoMode todo) async {
    final box = Hive.box<TodoMode>('todos');
    await box.add(todo);
  }

  Future<List<TodoMode>> getDb() async {
    final box = Hive.box<TodoMode>('todos');
    return box.values.toList();
  }

  Future<void> removeTodo(int id) async {
    final box = Hive.box<TodoMode>('todos');
    final index = box.values.toList().indexWhere((e) => e.id == id);
    if (index != -1) {
      await box.deleteAt(index);
    }
  }

  Future<void> updateTodo(TodoMode task) async {
    final box = Hive.box<TodoMode>('todos');
    final index = box.values.toList().indexWhere((e) => e.id == task.id);
    
    if (index != -1) {
      await box.putAt(index, task);
    }
  }

  Future<void> done(bool done, int todoId) async {
    try {
      final box = Hive.box<TodoMode>('todos');
      final completedBox = Hive.box<TodoMode>('completed');
      
      final todoIndex = box.values.toList().indexWhere((e) => e.id == todoId);
      
      if (todoIndex != -1) {
        final todo = box.getAt(todoIndex);
        
        if (todo != null && done) {
          final completedTodo = TodoMode(
            id: todo.id,
            name: todo.name,
            degree: todo.degree,
            isDone: true,
          );
          
          await completedBox.add(completedTodo);
          
          await box.deleteAt(todoIndex);
        }
      }
    } catch (e) {
      TelegramLogger.sendError(
        errorMessage: e.toString(),
        includeScreenshot: true,
      );
      throw Exception("Ma'lumot saqlashda xatolik: ${e.toString()}");
    }
  }

  Future<void> clearAll() async {
    final box = Hive.box<TodoMode>('completed');
    await box.clear();
  }

  Future<List<TodoMode>> getCompletedTodos() async {
    final box = Hive.box<TodoMode>('completed');
    return box.values.toList();
  }

  Future<void> addToCompleted(TodoMode todo) async {
    final box = Hive.box<TodoMode>('completed');
    await box.add(todo);
  }
}