import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/home/data/model/todo_mode.dart';
import 'package:todo/features/home/data/repository/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;

  TodoBloc(this.todoRepository) : super(TodoInitial()) {
    on<AddToDoEvent>(_addToDo);
    on<GetToDoEvent>(_getToDo);
    on<RemoveToDoEvent>(_removeToDo);
  }
  Future<void> _addToDo(AddToDoEvent event, Emitter<TodoState> emit) async {
    try {
      emit(TodoLoading());
      await todoRepository.addToDo(event.todo);
      final data = await todoRepository.getToDo();
      emit(TodoSuccsess(data));
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  Future<void> _getToDo(GetToDoEvent event, Emitter<TodoState> emit) async {
    try {
      emit(TodoLoading());

      final data = await todoRepository.getToDo();
      emit(TodoSuccsess(data));
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  Future<void> _removeToDo(
    RemoveToDoEvent event,
    Emitter<TodoState> emit,
  ) async {
    try {
      emit(TodoLoading());
      await todoRepository.removeToDo(event.id);
      final data = await todoRepository.getToDo();
      emit(TodoSuccsess(data));
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }
}
