import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'Models/ExerciseDataSource.dart';
import 'Models/options/ExerciseOptions.dart';
import 'Models/options/SettingOptions.dart';
import 'Pages/CalendarPage.dart';
import 'Pages/InputDataPage.dart';
import 'Pages/SettingPage.dart';
import 'Pages/StartPage.dart';

var gExerciseOptions = new SettingOptions();
var gDataSources = [];
var gSelectedDateTime;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await gExerciseOptions.load();
  await getExerciseLogs();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZZU Calendar',
      theme: ThemeData(
        textTheme: GoogleFonts.firaSansTextTheme(
          Theme.of(context).textTheme, // If this is not set, then ThemeData.light().textTheme is used.
        ),
        primarySwatch: Colors.grey,
      ),
      routes: {
        '/': (context) => StartPage(),
        '/start': (context) => StartPage(),
        '/setting': (context) => SettingPage(),
        '/calendar': (context) => CalendarPage(),
        '/input': (context) => InputDataPage(),
      },

    );
  }
}