import 'package:flutter/material.dart';

import '../main.dart';

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
      appBar: AppBar(
          title: Text("Settings")
      ),
      body: Center(child: Text("ZZU SETTING ~~~", style: TextStyle(fontWeight: FontWeight.bold))
      ),
    );
  }

}