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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children:[
            Center(
                child: Container(
                  width: 250,
                  height: 90,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Application Version"),
                          Text("v0.0.1", style: TextStyle(color: Colors.grey.shade700))
                      ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Release Date"),
                          Text("2022.04.30", style: TextStyle(color: Colors.grey.shade700))
                        ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Developer Contact"),
                          Text("@zzu_run", style: TextStyle(color: Colors.grey.shade700))
                        ]),
                    ])
                )
            )
          ]
        )
      )
    );
  }

}