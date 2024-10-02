abstract class TodoEvent {}

class AddTask extends TodoEvent {
  final String title;

  AddTask(this.title);
}

class RemoveTask extends TodoEvent {
  final int index;

  RemoveTask(this.index);
}

class ToggleTaskStatus extends TodoEvent {
  final int index;

  ToggleTaskStatus(this.index);
}
