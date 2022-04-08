import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/provider/dbProvider.dart';
import 'task_details.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  int date;
  HomePage({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [];

  bool isDone = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
        future: Provider.of<DBProvider>(context, listen: true)
            .fetchData(widget.date),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              //show something when no tasks in the database

              : Center(
                  child: snapshot.data!.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/no_tasks.png',
                                width:
                                    MediaQuery.of(context).size.width * 2 / 3),
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
                                        Color.fromARGB(255, 1, 15, 61)),
                                    value: snapshot.data![index].isDone,
                                    onChanged: (value) async {
                                      setState(() {
                                        isDone = value!;
                                      });
                                      Provider.of<DBProvider>(context,
                                              listen: false)
                                          .updateTask(snapshot.data![index].id!,
                                              isDone);
                                    },
                                  ),
                                  //delete task icon
                                  trailing: IconButton(
                                      onPressed: () {
                                        Provider.of<DBProvider>(context,
                                                listen: false)
                                            .deleteTask(
                                                snapshot.data![index].id!);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        semanticLabel:
                                            AppLocalizations.of(context)!
                                                .delete,
                                        color:
                                            const Color.fromARGB(255, 1, 7, 61),
                                      )),
                                  //Navigate to the task details
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => TaskDetails(
                                            title: snapshot.data![index].title!,
                                            description: snapshot
                                                .data![index].description!,
                                            dateTime:
                                                snapshot.data![index].dateTime!,
                                            imagePath:
                                                snapshot.data![index].image!,
                                            isDone:
                                                snapshot.data![index].isDone!),
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
                        ));
        });
  }
}
