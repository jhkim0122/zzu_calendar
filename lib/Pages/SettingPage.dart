import 'package:flutter/material.dart';

import '../main.dart';
import '../utils/SideDrawer.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>{

  @override
  void initState() {
    super.initState();
    gExerciseOptions.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(1),
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Settings")
      ),
      body: Center(child: Text("ZZU SETTING ~~~", style: TextStyle(fontWeight: FontWeight.bold))
      ),
    );
  }

}