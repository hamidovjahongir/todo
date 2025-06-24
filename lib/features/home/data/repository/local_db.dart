import 'package:hive/hive.dart';
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
}
