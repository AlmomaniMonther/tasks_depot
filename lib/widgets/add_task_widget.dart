import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/dbProvider.dart';
import 'package:todo_app/widgets/picked_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/task.dart';

class AddTaskWidget extends StatefulWidget {
  const AddTaskWidget({Key? key}) : super(key: key);

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  String? _title;
  String? _description;
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  DateTime _dateTime = DateTime.now();
  int _day = DateTime.now().day;
  String _imagePath = '';

//set date and time from the date and time pickers
  Future<void> _setDateAndTime() async {
    var date = await showDatePicker(
      initialDatePickerMode: DatePickerMode.day,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    var time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 00, minute: 00),
    );
    _date = date ?? _date;
    _time = time ?? _time;
    setState(() {
      _dateTime = DateTime(
        _date.year,
        _date.month,
        _date.day,
        _time.hour,
        _time.minute,
      );
    });
    _day = _date.day;
  }

  @override
  void didChangeDependencies() {
    _title = AppLocalizations.of(context)!.notitle;
    _description = AppLocalizations.of(context)!.nodescription;
    super.didChangeDependencies();
  }

  void getImagePath(String imagePath) {
    setState(() {
      _imagePath = imagePath;
    });
  }

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
            title: Text(AppLocalizations.of(context)!.newtask),
            centerTitle: true,
            actions: [
              //add task
              IconButton(
                  onPressed: () {
                    Provider.of<DBProvider>(context, listen: false).addTask(
                      Task(
                          id: DateTime.now().toString(),
                          title: _title,
                          description: _description,
                          dateTime: _dateTime.millisecondsSinceEpoch,
                          isDone: false,
                          date: _day,
                          image: _imagePath),
                    );

                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.send))
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
              //input task title
              TextFormField(
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.title,
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    hintStyle: const TextStyle(color: Colors.grey),
                    hintText: AppLocalizations.of(context)!.titlehint),
                onChanged: (value) {
                  _title = value;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              //input task description
              TextFormField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    labelText: AppLocalizations.of(context)!.description1,
                    hintStyle: const TextStyle(color: Colors.grey),
                    hintText: AppLocalizations.of(context)!.descriptionhint,
                  ),
                  onChanged: (value) {
                    _description = value;
                  }),
              const SizedBox(
                height: 12,
              ),
              //add date to the task
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    DateFormat('EEE, dd/MM/yyyy, HH:mm')
                        .format(_dateTime)
                        .toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await _setDateAndTime();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.changetime,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              //add image to the task
              PickedImage(onImagePicked: getImagePath),
            ],
          ),
        ),
      ),
    );
  }
}
