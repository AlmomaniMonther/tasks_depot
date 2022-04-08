import 'package:flutter/cupertino.dart';
import 'package:todo_app/helper/dbhelper.dart';
import 'package:todo_app/models/task.dart';

class DBProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> get tasks {
    return [..._tasks];
  }

//this method is to add tasks to the database
  void addTask(Task task) async {
    await DBHelper.insert({
      'id': task.id!,
      'title': task.title!,
      'description': task.description!,
      'dateTime': task.dateTime!,
      'isDone': task.isDone == true ? 1 : 0,
      'date': task.date!,
      'image': task.image!
    });
    notifyListeners();
  }

//this method is to change task status in the database
  Future<void> updateTask(
    String taskID,
    bool? newValue,
  ) async {
    await DBHelper.updateData(taskID, newValue!);

    notifyListeners();
  }

//this method is to fetch tasks from the database
  Future<List<Task>> fetchData(int date) async {
    final dataList = await DBHelper.getData(date);
    return dataList
        .map((item) => Task(
              id: item['id'],
              title: item['title'],
              description: item['description'],
              dateTime: item['dateTime'],
              isDone: item['isDone'] == 1 ? true : false,
              date: item['date'],
              image: item['image'],
            ))
        .toList();

    // notifyListeners();
  }

//this method is to delete tasks from the database
  Future<void> deleteTask(String id) async {
    await DBHelper.deleteData(id);
    notifyListeners();
  }
}
