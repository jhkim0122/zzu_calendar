import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SideDrawer extends StatefulWidget {
  final int selectedIndex;
  const SideDrawer(this.selectedIndex, {Key? key}) : super(key: key);

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer>{

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                ),
                child: Center(child:Text("ZZU\nEXERCIZE\nCALENDAR",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.abrilFatface(textStyle:TextStyle(fontSize: 25))
                ),),
              ),
              ListTile(
                leading: Icon(Icons.calendar_today_outlined),
                title: Text('Calendar', style:TextStyle(fontWeight: FontWeight.w600)),
                onTap: () {
                  if(widget.selectedIndex != 0) Navigator.of(context).popAndPushNamed("/calendar");
                  else Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings', style:TextStyle(fontWeight: FontWeight.w600)),
                onTap: () {
                  if(widget.selectedIndex != 1) Navigator.of(context).popAndPushNamed("/setting");
                  else Navigator.pop(context);
                },
              ),
            ],
          ),
        ));
  }
}