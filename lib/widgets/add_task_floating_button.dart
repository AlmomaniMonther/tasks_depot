import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';

import 'add_task_widget.dart';

class AddTaskFloatingButton extends StatelessWidget {
  const AddTaskFloatingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableFab(
      child: FloatingActionButton(
        isExtended: true,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddTaskWidget(),
            ),
          );
        },
        child: Container(
          height: 70,
          width: 70,
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 0, 38, 255),
              Color.fromARGB(255, 0, 183, 255),
            ], begin: Alignment.topLeft),
          ),
          child: const Icon(
            Icons.add,
            size: 25,
          ),
        ),
      ),
    );
  }
}
