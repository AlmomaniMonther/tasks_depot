import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 0, 217, 255),
              Color.fromARGB(255, 155, 218, 243),
            ],
            begin: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            //logo
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image.asset('assets/logos/app/logo_title_hor.png'),
            ),
            //go to aboutUsScreen
            ListTile(
              leading: const Icon(Icons.info, size: 30, color: Colors.black87),
              title: Text(
                AppLocalizations.of(context)!.aboutus,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/aboutUsScreen');
              },
            ),
            //go to feedback screen
            ListTile(
              leading:
                  const Icon(Icons.feedback, size: 30, color: Colors.black87),
              title: Text(
                AppLocalizations.of(context)!.feedback,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/feedbackScreen');
              },
            ),
          ],
        ),
      ),
    );
  }
}
