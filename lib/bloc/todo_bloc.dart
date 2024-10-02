import 'package:flutter_bloc/flutter_bloc.dart';
import 'todo_event.dart';
import 'todo_state.dart';
import '../models/todo.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState([])) {
    on<AddTask>((event, emit) {
      final updatedTodos = List<Todo>.from(state.todos)
        ..add(Todo(title: event.title));
      emit(TodoState(updatedTodos));
    });

    on<RemoveTask>((event, emit) {
      final updatedTodos = List<Todo>.from(state.todos)
        ..removeAt(event.index);
      emit(TodoState(updatedTodos));
    });

    on<ToggleTaskStatus>((event, emit) {
      final updatedTodos = List<Todo>.from(state.todos);
      updatedTodos[event.index].isDone = !updatedTodos[event.index].isDone;
      emit(TodoState(updatedTodos));
    });
  }
}
