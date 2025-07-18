part of 'todo_bloc.dart';

abstract class TodoEvent {}

class AddToDoEvent extends TodoEvent {
  final TodoMode todo;
  AddToDoEvent(this.todo);
}

class GetToDoEvent extends TodoEvent {}

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
  final int id;
  IsDoneEvent(this.isDone, this.id);
}

class ClearAllEvent extends TodoEvent {}

class GetCompletedEvent extends TodoEvent {}