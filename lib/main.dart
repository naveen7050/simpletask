import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpletasks/repository/task_repository.dart';
import 'package:simpletasks/viewmodels/task_viewmodel.dart';
import 'package:simpletasks/ui/task_list_screen.dart';

void main() {
  runApp(const SimpleTasksApp());
}

class SimpleTasksApp extends StatelessWidget {
  const SimpleTasksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TaskViewModel(TaskRepository())..loadTasks(),
        ),
      ],
      child: MaterialApp(
        title: 'SimpleTasks',
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: ThemeMode.system,
        home: const TaskListScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
