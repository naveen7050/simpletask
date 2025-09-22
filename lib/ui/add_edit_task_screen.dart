import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpletasks/models/task.dart';
import 'package:simpletasks/viewmodels/task_viewmodel.dart';

class AddEditTaskScreen extends StatefulWidget {
  final Task? task;
  const AddEditTaskScreen({super.key, this.task});

  @override
  State<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _detailsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _detailsController.text = widget.task!.details ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.task != null;
    final viewModel = Provider.of<TaskViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit Task" : "Add Task"),
        actions: [
          if (isEditing)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                viewModel.deleteTask(widget.task!.id!);
                Navigator.pop(context);
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Title"),
                validator:
                    (v) =>
                        v == null || v.isEmpty ? "Title cannot be empty" : null,
              ),
              TextFormField(
                controller: _detailsController,
                decoration: const InputDecoration(labelText: "Details"),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final now = DateTime.now();
                    final task =
                        (widget.task == null)
                            ? Task(
                              title: _titleController.text,
                              details: _detailsController.text,
                              createdAt: now,
                              updatedAt: now,
                            )
                            : widget.task!.copyWith(
                              title: _titleController.text,
                              details: _detailsController.text,
                              updatedAt: now,
                            );
                    isEditing
                        ? viewModel.updateTask(task)
                        : viewModel.addTask(task);
                    Navigator.pop(context);
                  }
                },
                child: Text(isEditing ? "Update" : "Add"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
