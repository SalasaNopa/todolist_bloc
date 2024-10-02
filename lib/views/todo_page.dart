import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../bloc/todo_state.dart';

class TodoPage extends StatelessWidget {
  final TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BLoC To-Do List'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: InputDecoration(
                labelText: 'Add a new task',
                labelStyle: TextStyle(color: Colors.deepPurple),
                filled: true,
                fillColor: Colors.deepPurple.shade50,
                prefixIcon: Icon(Icons.task, color: Colors.deepPurple),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.deepPurple),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {
                  return state.todos.isEmpty
                      ? Center(
                          child: Text(
                            'No tasks yet, add some!',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: state.todos.length,
                          itemBuilder: (context, index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 4,
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                leading: Checkbox(
                                  value: state.todos[index].isDone,
                                  onChanged: (bool? value) {
                                    context.read<TodoBloc>().add(ToggleTaskStatus(index));
                                  },
                                ),
                                title: Text(
                                  state.todos[index].title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    decoration: state.todos[index].isDone
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.redAccent),
                                  onPressed: () {
                                    context.read<TodoBloc>().add(RemoveTask(index));
                                  },
                                ),
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          if (taskController.text.isNotEmpty) {
            context.read<TodoBloc>().add(AddTask(taskController.text));
            taskController.clear();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
