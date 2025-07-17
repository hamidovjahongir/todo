import 'package:hive/hive.dart';

part 'todo_mode.g.dart';

@HiveType(typeId: 0)
class TodoMode extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int degree;

  @HiveField(3)
  bool? isDone;

  TodoMode({
    required this.id,
    required this.name,
    required this.degree,
    this.isDone = false,
  });

  TodoMode copywith({int? id, String? name, int? degree, bool? isDone}) {
    return TodoMode(
      id: id ?? this.id,
      name: name ?? this.name,
      degree: degree ?? this.degree,
      isDone: isDone ?? this.isDone,
    );
  }
}
