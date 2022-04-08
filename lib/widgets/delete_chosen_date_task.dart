import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../provider/dbProvider.dart';

class DeleteChosenDateTask extends StatelessWidget {
  String id;
  DeleteChosenDateTask({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Provider.of<DBProvider>(context, listen: false).deleteTask(id);
        },
        icon: Icon(
          Icons.delete,
          semanticLabel: AppLocalizations.of(context)!.delete,
          color: const Color.fromARGB(255, 1, 7, 61),
        ));
  }
}
