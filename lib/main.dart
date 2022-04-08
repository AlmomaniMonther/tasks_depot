import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/dbProvider.dart';
import 'package:todo_app/screens/tabs_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'screens/about_us_screen.dart';
import 'screens/feedback_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => DBProvider()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English, no country code
          Locale('ar', ''), // Spanish, no country code
        ],
        title: 'Tasks Depot',
        theme: ThemeData(
            primarySwatch: Colors.indigo,
            scaffoldBackgroundColor: const Color.fromARGB(255, 233, 233, 233)),
        home: TabsScreen(),
        routes: {
          '/feedbackScreen': (context) => FeedbackScreen(),
          '/aboutUsScreen': (context) => AboutUsScreen(),
        },
      ),
    );
  }
}
