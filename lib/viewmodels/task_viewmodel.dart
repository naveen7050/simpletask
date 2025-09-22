import 'package:flutter/material.dart';
import 'package:simpletasks/models/task.dart';
import 'package:simpletasks/repository/task_repository.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskRepository repository;
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  TaskViewModel(this.repository);

  Future<void> loadTasks() async {
    _tasks = await repository.getTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await repository.insertTask(task);
    await loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await repository.updateTask(task);
    await loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await repository.deleteTask(id);
    await loadTasks();
  }

  Future<void> toggleDone(Task task) async {
    final updated = task.copyWith(
      isDone: !task.isDone,
      updatedAt: DateTime.now(),
    );
    await updateTask(updated);
  }
}
