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


class UpdateToDoEvent extends TodoEvent {
  final TodoMode task;
  UpdateToDoEvent(this.task);
}

class IsDoneEvent extends TodoEvent {
  final bool isDone;
  final int index;
  IsDoneEvent(this.isDone, this.index);
}
class ClearAllEvent extends TodoEvent {} 

class GetCompletedEvent extends TodoEvent {}

class RemoveCompletedEvent extends TodoEvent {
  final int id;
  RemoveCompletedEvent(this.id);
}