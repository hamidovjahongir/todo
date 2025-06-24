part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

class AddToDoEvent extends TodoEvent {
  final TodoMode todo;
  AddToDoEvent(this.todo);
}

class GetToDoEvent extends TodoEvent {}

class GetOneToDoEvent extends TodoEvent {
  final int id;
  GetOneToDoEvent(this.id);
}

class RemoveToDoEvent extends TodoEvent {
  final int id;
  RemoveToDoEvent(this.id);
}
