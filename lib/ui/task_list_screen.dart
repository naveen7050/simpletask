import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpletasks/models/task.dart';
import 'package:simpletasks/ui/add_edit_task_screen.dart';
import 'package:simpletasks/ui/widgets/task_tile.dart';
import 'package:simpletasks/viewmodels/task_viewmodel.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("SimpleTasks")),
      body:
          viewModel.tasks.isEmpty
              ? const Center(child: Text("No tasks yet"))
              : ListView.builder(
                itemCount: viewModel.tasks.length,
                itemBuilder: (context, index) {
                  final task = viewModel.tasks[index];
                  return Dismissible(
                    key: ValueKey(task.id),
                    background: Container(color: Colors.red),
                    onDismissed: (_) => viewModel.deleteTask(task.id!),
                    child: TaskTile(
                      task: task,
                      leading: Checkbox(
                        value: task.isDone,
                        onChanged: (_) => viewModel.toggleDone(task),
                      ),
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddEditTaskScreen(task: task),
                            ),
                          ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddEditTaskScreen()),
            ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
