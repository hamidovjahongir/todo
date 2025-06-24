part of 'todo_bloc.dart';

@immutable
sealed class TodoState {}

final class TodoInitial extends TodoState {}

final class TodoError extends TodoState {
  final String error;
  TodoError(this.error);
}

final class TodoLoading extends TodoState {}

final class TodoSuccsess extends TodoState {
  final List<TodoMode> todos;
  TodoSuccsess(this.todos);
}
