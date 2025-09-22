import 'package:simpletasks/database/task_db.dart';
import 'package:simpletasks/models/task.dart';

class TaskRepository {
  Future<List<Task>> getTasks() async {
    final db = await TaskDB.instance.database;
    final result = await db.query('tasks', orderBy: 'createdAt DESC');
    return result.map((e) => Task.fromMap(e)).toList();
  }

  Future<int> insertTask(Task task) async {
    final db = await TaskDB.instance.database;
    return await db.insert('tasks', task.toMap());
  }

  Future<int> updateTask(Task task) async {
    final db = await TaskDB.instance.database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int id) async {
    final db = await TaskDB.instance.database;
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
