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
    await box.deleteAt(index);
  }

  Future<void> updateTodo(TodoMode task) async {
    final box = Hive.box<TodoMode>('todos');
    final index = box.values.toList().indexWhere((e) => e.id == task.id);

    if (index != -1) {
      await box.putAt(index, task);
    }
  }

  Future<void> done(bool done, int index) async {
    try {
      final box = Hive.box<TodoMode>('todos');
      final todo = box.getAt(index);
      if (todo != null) {
        todo.isDone = done;
        await todo.save();
      }
    } catch (e) {
      TelegramLogger.sendError(
        // ignore: use_build_context_synchronously
        errorMessage: e.toString(),

        includeScreenshot: true,
      );
    }
  }

  Future<void> clearAll() async {
    final box = Hive.box<TodoMode>('todos');
    await box.clear();
  }
}
