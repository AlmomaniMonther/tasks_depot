import 'package:flutter/material.dart';

import '../screens/chosen_date_tasks.dart';

class ChooseDate extends StatelessWidget {
  const ChooseDate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          final date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(
              const Duration(days: 365),
            ),
          );
          if (date != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ChosenDateTasks(
                  date: date.day,
                  appBarDate: date,
                ),
              ),
            );
          }
        },
        icon: const Icon(Icons.calendar_month_outlined));
  }
}
