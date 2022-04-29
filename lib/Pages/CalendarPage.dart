import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../Models/ExerciseDataSource.dart';
import '../main.dart';
import '../utils/SideDrawer.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(0),
        appBar: AppBar(
          backgroundColor: Colors.white,
            title: Text("Calendar"),
          actions:[
            IconButton(icon: Icon(Icons.replay_rounded), onPressed:(){setState(() {});})
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child:SfCalendar(
            view: CalendarView.month,
            dataSource: ExerciseDataSource(gDataSources),
            monthViewSettings: MonthViewSettings(appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
            onTap: (CalendarTapDetails calendarTapDetails) async {
              await _popupDetails(calendarTapDetails);
            },
            appointmentBuilder: (BuildContext context, CalendarAppointmentDetails details) {
              if(details.appointments.first.eventName == "Running") {
                Running running = details.appointments.first;
                return Container(
                  margin: EdgeInsets.only(left:5),
                  padding: EdgeInsets.only(top:2,left:2),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Text(running.distance.toStringAsFixed(2)+"km",
                      style: TextStyle(fontSize:(running.distance>10? 12:14),fontWeight: FontWeight.w500)),
                );
              }
              else if(details.appointments.first.eventName == "Workout"){
                Workout workout = details.appointments.first;
                return Container(
                  margin: EdgeInsets.only(left:5),
                  padding: EdgeInsets.only(left:5, top:3),
                  decoration: BoxDecoration(
                      color: Colors.deepOrangeAccent.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Text(workout.part, style: TextStyle(overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w400, fontSize:13)),
                );
              }
              else if(details.appointments.first.eventName == "Shooting"){
                Shooting shooting = details.appointments.first;
                return Container(
                  margin: EdgeInsets.only(left:5),
                  padding: EdgeInsets.only(left:5, top:3),
                  decoration: BoxDecoration(
                      color: Colors.lime.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Text(shooting.type, style: TextStyle(overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w400, fontSize:13)),
                );
              }
              else {return Container();}
          }
    )),
      bottomSheet: Container(
        margin: EdgeInsets.all(10),
        child:Row(
          children:[
            Container(
              margin: EdgeInsets.only(right:10),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Text("러닝", style: GoogleFonts.nanumGothic(textStyle: TextStyle(fontWeight: FontWeight.w700))),
            ),
             Container(
                 margin: EdgeInsets.only(right:10),
               padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.deepOrangeAccent.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Text("헬스", style: GoogleFonts.nanumGothic(textStyle: TextStyle(fontWeight: FontWeight.w700)),)
             ),
            Container(
                margin: EdgeInsets.only(right:10),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.lime.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Text("사격", style: GoogleFonts.nanumGothic(textStyle: TextStyle(fontWeight: FontWeight.w700)),)
            )
          ]
        ),)
    );
  }

  Widget _getAppointmentsDetails(CalendarTapDetails calendarTapDetails){
    List<Widget> ret = [];

    calendarTapDetails.appointments?.forEach((appointment){
      if(appointment.eventName == "Running"){
        ret.add(
          Container(
            width: 300,
            margin: EdgeInsets.only(left:5, bottom:15),
            decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.5),
                borderRadius: BorderRadius.circular(5)
            ),
            child: FlatButton(
                padding: EdgeInsets.all(10),
                onPressed: (){},
                onLongPress: (){
                  var deleteData;
                  for(var data in gDataSources){
                    if(data.eventName == appointment.eventName &&
                        data.startTime == appointment.startTime &&
                        data.distance == appointment.distance &&
                        data.paceMin == appointment.paceMin &&
                        data.paceSecond == appointment.paceSecond) deleteData = data;
                  }
                  if(deleteData != null) {
                    gDataSources.remove(deleteData);
                    File(deleteData.filePath).deleteSync();
                  }
                  Navigator.pop(context);
                  setState((){});
                },
                child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Text("Running", style:TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
                  SizedBox(height:10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                      children:[
                        Padding(
                          padding: EdgeInsets.only(left:10),
                          child:Text("Distance", style: TextStyle(color: Colors.grey)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left:5),
                          child:Text(appointment.distance.toString()+"km", style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left:20),
                          child:Text("Pace", style: TextStyle(color: Colors.grey)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left:5),
                          child:Text(appointment.paceMin.toString()+"' "+appointment.paceSecond.toString()+"''", style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                      ]),
                ] + ( appointment.memo != "" ?
                    <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical:5, horizontal:5),
                        child: Divider(color: Colors.black45, thickness: 1,),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left:10),
                        child:Text("Memo", style: TextStyle(color: Colors.grey)),
                      ),
                      Container(
                        margin: EdgeInsets.only(top:5, left:10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white54,
                        ),
                        child:Text(appointment.memo, style: TextStyle(color: Colors.black54, fontSize:15, fontWeight: FontWeight.w500)),
                      ),
                    ] : <Widget>[SizedBox()])
                )
            )
          )
        );
      }
      else if(appointment.eventName == "Workout") {
        ret.add(
            Container(
                width: 300,
                margin: EdgeInsets.only(left:5, bottom:15),
                decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: FlatButton(
                    padding: EdgeInsets.all(10),
                    onPressed: (){},
                    onLongPress: () {
                      var deleteData;
                      for(var data in gDataSources){
                        if(data.eventName == appointment.eventName &&
                            data.startTime == appointment.startTime &&
                            data.part == appointment.part &&
                            data.time == appointment.time) deleteData = data;
                      }
                      if(deleteData != null) {
                        gDataSources.remove(deleteData);
                        File(deleteData.filePath).deleteSync();
                      }
                      Navigator.pop(context);
                      setState((){});
                    },
                    child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Text("Workout", style:TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
                      SizedBox(height:10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[
                      Padding(
                        padding: EdgeInsets.only(left:10),
                        child:Text("Part", style: TextStyle(color: Colors.grey)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left:5),
                        child:Text(appointment.part, style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left:10),
                        child:Text("Time", style: TextStyle(color: Colors.grey)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left:5),
                        child:Text(appointment.time.toString() + "min", style: TextStyle(fontWeight: FontWeight.w600)),
                      ),]),
                    ] + ( appointment.memo != "" ?
                    <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical:5, horizontal:5),
                        child: Divider(color: Colors.black45, thickness: 1,),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left:10),
                        child:Text("Memo", style: TextStyle(color: Colors.grey)),
                      ),
                      Container(
                        margin: EdgeInsets.only(top:5, left:10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white54,
                        ),
                        child:Text(appointment.memo, style: TextStyle(color: Colors.black54, fontSize:15, fontWeight: FontWeight.w500)),
                      ),
                    ] : <Widget>[SizedBox()])))
            )
        );
      }
      else if(appointment.eventName == "Shooting") {
        ret.add(
            Container(
                width: 300,
                margin: EdgeInsets.only(left:5, bottom:15),
                decoration: BoxDecoration(
                    color: Colors.lime.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: FlatButton(
                    padding: EdgeInsets.all(10),
                    onPressed: (){},
                    onLongPress: () {
                      var deleteData;
                      for(var data in gDataSources){
                        if(data.eventName == appointment.eventName &&
                            data.startTime == appointment.startTime &&
                            data.type == appointment.type) deleteData = data;
                      }
                      if(deleteData != null) {
                        gDataSources.remove(deleteData);
                        File(deleteData.filePath).deleteSync();
                      }
                      Navigator.pop(context);
                      setState((){});
                    },
                    child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Text("Shooting", style:TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
                          SizedBox(height:10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children:[
                                Padding(
                                  padding: EdgeInsets.only(left:10),
                                  child:Text("Type", style: TextStyle(color: Colors.grey)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left:5),
                                  child:Text(appointment.type, style: TextStyle(fontWeight: FontWeight.w500)),
                                ),
                                ]),
                        ] + ( appointment.memo != "" ?
                        <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical:5, horizontal:5),
                            child: Divider(color: Colors.black45, thickness: 1,),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left:10),
                            child:Text("Memo", style: TextStyle(color: Colors.grey)),
                          ),
                          SingleChildScrollView(child:
                          Container(
                            margin: EdgeInsets.only(top:5, left:10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white54,
                            ),
                            child:Text(appointment.memo, style: TextStyle(color: Colors.black54, fontSize:15, fontWeight: FontWeight.w500)),
                          )),
                        ] : <Widget>[SizedBox()])))
            )
        );
      }
    });
    return Expanded(
        child: SingleChildScrollView(
        child: Column(children:ret)));
  }

  _popupDetails(calendarTapDetails) async{
    await showDialog(
        context: context, builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Container(
          height: 500,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[
                      Text(calendarTapDetails.date!.day.toString(), style:TextStyle(fontSize: 30, fontWeight: FontWeight.bold,)),
                      SizedBox(width:10),
                      Text(calendarTapDetails.date!.month.toString()+"월"),
                      calendarTapDetails.date!.day == 22 && calendarTapDetails.date!.month == 1 ?
                      Padding(
                          padding: EdgeInsets.only(left:170),
                          child:Text("쮸 생일 🎉", style: GoogleFonts.nanumBrushScript(textStyle: TextStyle(fontSize:18, fontWeight: FontWeight.bold, color: Colors.redAccent.shade100)))
                      ) :
                      calendarTapDetails.date!.day == 25 && calendarTapDetails.date!.month == 6 ?
                      Padding(
                          padding: EdgeInsets.only(left:167),
                          child:Text("붸 생일 🎉", style: GoogleFonts.nanumBrushScript(textStyle: TextStyle(fontSize:18, fontWeight: FontWeight.bold, color: Colors.redAccent.shade100)))
                      ) : SizedBox(height:0)
                    ]),),
              Divider(color: Colors.grey, thickness: 1,),
              calendarTapDetails.appointments!.length != 0 ?
             _getAppointmentsDetails(calendarTapDetails) :
              Padding(
                  padding:EdgeInsets.only(top:20),
                  child:Center(child:Text("운동 기록이 없습니다.", style: TextStyle(color: Colors.grey.withOpacity(0.5))),)
              )
            ],
          ),
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right:5, bottom:5),
            decoration: BoxDecoration(
                color:Colors.grey.withOpacity(0.5),
                borderRadius:BorderRadius.circular(50)
            ),
            child:IconButton(
                icon:Icon(Icons.add),
                onPressed: (){
                  gSelectedDateTime = calendarTapDetails.date;
                  setState((){});
                  Navigator.of(context).pushNamed("/input").then((_) async{
                    await getExerciseLogs();
                    setState((){});
                    Navigator.pop(context);
                  });
                }
            ),
          ),
        ],
      );
    });
  }

}