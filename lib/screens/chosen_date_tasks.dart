import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/dbProvider.dart';
import 'package:todo_app/screens/task_details.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/task.dart';
import '../widgets/delete_chosen_date_task.dart';

class ChosenDateTasks extends StatefulWidget {
  int date;
  DateTime appBarDate;

  ChosenDateTasks({Key? key, required this.date, required this.appBarDate})
      : super(key: key);

  @override
  State<ChosenDateTasks> createState() => _ChosenDateTasksState();
}

class _ChosenDateTasksState extends State<ChosenDateTasks> {
  List<Task> tasks = [];

  bool isDone = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: ClipRRect(
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(25)),
          child: AppBar(
            centerTitle: true,
            elevation: 25,
            title: Text(
                '${AppLocalizations.of(context)!.tasksof} ${DateFormat('dd/MM').format(widget.appBarDate)}'),
          ),
        ),
      ),
      body: FutureBuilder<List<Task>>(
          future: Provider.of<DBProvider>(context, listen: true)
              .fetchData(widget.date),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: snapshot.data!.isEmpty
                        //show something when no tasks in the database
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/no_tasks.png',
                                  width: MediaQuery.of(context).size.width *
                                      2 /
                                      3),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                AppLocalizations.of(context)!.notaskstoshow,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'gideonRoman',
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                        //show tasks in the database as a list
                        : ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: ((context, index) => Card(
                                  elevation: 5,
                                  margin:
                                      const EdgeInsets.fromLTRB(12, 12, 12, 0),
                                  color: const Color.fromARGB(74, 3, 41, 209),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: ListTile(
                                    //change status of the task
                                    leading: Checkbox(
                                      fillColor: MaterialStateProperty.all(
                                          const Color.fromARGB(255, 1, 7, 61)),
                                      value: snapshot.data![index].isDone,
                                      onChanged: (value) async {
                                        setState(() {
                                          isDone = value!;
                                        });
                                        Provider.of<DBProvider>(context,
                                                listen: false)
                                            .updateTask(
                                                snapshot.data![index].id!,
                                                isDone);
                                      },
                                    ),
                                    //delete task icon
                                    trailing: DeleteChosenDateTask(
                                        id: snapshot.data![index].id!),
                                    //Navigate to the task details
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => TaskDetails(
                                              title:
                                                  snapshot.data![index].title!,
                                              description: snapshot
                                                  .data![index].description!,
                                              dateTime: snapshot
                                                  .data![index].dateTime!,
                                              imagePath:
                                                  snapshot.data![index].image!,
                                              isDone: snapshot
                                                  .data![index].isDone!),
                                        ),
                                      );
                                    },
                                    title: Text(snapshot.data![index].title!),
                                    subtitle: Text('${DateFormat('yMMMd').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              snapshot.data![index].dateTime!),
                                        ).toString()} at ${DateFormat('HH:mm').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              snapshot.data![index].dateTime!),
                                        ).toString()}'),
                                  ),
                                )),
                          ),
                  );
          }),
    );
  }
}
