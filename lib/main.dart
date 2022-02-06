import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Models/ExerciseOptions.dart';
import 'Pages/CalendarPage.dart';
import 'Pages/SettingPage.dart';
import 'Pages/StartPage.dart';

var gExerciseOptions = new ExerciseOptions();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await gExerciseOptions.load();

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
        // const MaterialColor(
        //     0xFFFFC289, <int,Color>{
        //       50: Color(0xFFFCDCCC),
        //       100: Color(0xFFF8C58F),
        //       200: Color(0xFFFFC289),
        //       300: Color(0xFFFFB066),
        //       400: Color(0xFFF88C48),
        //       500: Color(0xFFFF8B1E),
        //       600: Color(0xFFF97900),
        //       700: Color(0xFFF16208),
        //       800: Color(0xFFCE5407),
        //       900: Color(0xFFAC4606),
        //     }
        // ),
      ),
      routes: {
        '/': (context) => StartPage(),
        '/start': (context) => StartPage(),
        '/setting': (context) => SettingPage(),
        '/calendar': (context) => CalendarPage(),
      },

    );
  }
}