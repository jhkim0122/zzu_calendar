import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage>{

  late Timer timer;

  @override
  void initState() {
    super.initState();

    int i=0;

    timer = Timer.periodic(Duration(seconds:3), (_) {
      i++;
      if(i==1) Navigator.of(context).popAndPushNamed("/calendar");
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:Text("ZZU\nEXERCIZE\nCALENDAR",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.abrilFatface(textStyle:TextStyle(fontSize: 30))
                  ),),
      floatingActionButton: Text("@zzu_run", style:TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))
    );
  }

}