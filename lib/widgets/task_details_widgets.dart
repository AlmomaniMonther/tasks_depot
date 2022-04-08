import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//task status
class Status extends StatelessWidget {
  const Status({
    Key? key,
    required this.isDone,
  }) : super(key: key);

  final bool isDone;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${AppLocalizations.of(context)!.status}   ${isDone == true ? AppLocalizations.of(context)!.completed : AppLocalizations.of(context)!.waiting}',
    );
  }
}

//task description
class Description extends StatelessWidget {
  const Description({
    Key? key,
    required this.description,
  }) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.description2 + description,
      style: const TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

//task date
class Date extends StatelessWidget {
  const Date({
    Key? key,
    required this.dateTime,
  }) : super(key: key);

  final int dateTime;

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.date +
          DateFormat('EEE, dd/MM/yyyy, HH:mm').format(
            DateTime.fromMillisecondsSinceEpoch(dateTime),
          ),
      style: const TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 14,
        color: Colors.grey,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

//task title
class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.title + title,
      style: const TextStyle(
        fontSize: 22,
        fontFamily: 'gideonRoman',
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
