import 'dart:io';

import 'package:flutter/material.dart';
import '../widgets/task_details_widgets.dart';

class TaskDetails extends StatelessWidget {
  String title;
  String description;
  String imagePath;
  int dateTime;
  bool isDone;

  TaskDetails(
      {required this.title,
      required this.description,
      required this.imagePath,
      required this.dateTime,
      required this.isDone,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: false,
        elevation: 5,
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imagePath != ''
              ? Image.file(
                  File(imagePath),
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  'assets/no_image.jpg',
                  width: double.infinity,
                ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleWidget(title: title),
                const SizedBox(
                  height: 4,
                ),
                Date(dateTime: dateTime),
                const SizedBox(
                  height: 4,
                ),
                Description(description: description),
                const SizedBox(
                  height: 4,
                ),
                Status(isDone: isDone)
              ],
            ),
          ),
        ],
      )),
    );
  }
}
