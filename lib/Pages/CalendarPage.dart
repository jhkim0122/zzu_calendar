import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../Models/ExerciseDataSource.dart';
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
            IconButton(icon: Icon(Icons.settings), onPressed:(){})
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child:SfCalendar(
            view: CalendarView.month,
            dataSource: ExerciseDataSource([
              Running(DateTime(2022, 2, 6), 5.07, Pace(5, 53), memo: "아 존잼으로 뛰었땅 ㅋㅋㅋㅋㅋㅋㅋㅋㅋ껄껄 아 쓸 말 없엉 ;; "),
              Running(DateTime(2022, 1, 24), 3.07, Pace(5, 53)),
              Workout(DateTime(2022, 1, 24), "등", 65),
              Running(DateTime(2022, 1, 22), 1.22, Pace(5, 12)),
              Running(DateTime(2022, 1, 17), 3.43, Pace(5, 33)),
              Running(DateTime(2022, 1, 2), 5.05, Pace(5, 34)),
              Workout(DateTime(2022, 2, 5), "어깨", 65),
              Workout(DateTime(2022, 2, 4), "가슴", 65),
              Workout(DateTime(2022, 2, 3), "등", 65),
              Workout(DateTime(2022, 1, 31), "하체", 65),
            ]),
            monthViewSettings: MonthViewSettings(appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
            onTap: (CalendarTapDetails calendarTapDetails) async {
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
                              mainAxisSize: MainAxisSize.min,
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
                                  setState((){});
                                }
                            ),
                          ),

                        ],
                      );
              });
            },
            appointmentBuilder: (BuildContext context, CalendarAppointmentDetails details) {
              if(details.appointments.first.eventName == "Running") {
                Running running = details.appointments.first;
                return Container(
                  margin: EdgeInsets.only(left:5),
                  padding: EdgeInsets.only(left:2),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Text(running.distance.toString()+"km", style: TextStyle(fontWeight: FontWeight.w500)),
                );
              }
              else if(details.appointments.first.eventName == "Workout"){
                Workout workout = details.appointments.first;
                return Container(
                  margin: EdgeInsets.only(left:5),
                  padding: EdgeInsets.only(left:2, top:2),
                  decoration: BoxDecoration(
                      color: Colors.deepOrangeAccent.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Text(workout.part, style: TextStyle(fontWeight: FontWeight.w400)),
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
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.5),
                borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
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
                          child:Text(appointment.pace.min.toString()+"' "+appointment.pace.micro.toString()+"''", style: TextStyle(fontWeight: FontWeight.w600)),
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
        );
      }
      else if(appointment.eventName == "Workout") {
        ret.add(
            Container(
                width: 300,
                margin: EdgeInsets.only(left:5, bottom:15),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Text("Workout", style:TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
                      SizedBox(height:10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[
                      Padding(
                        padding: EdgeInsets.only(left:20),
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
                    ] : <Widget>[SizedBox()]))
            )
        );
      }
    });
    return Column(children:ret);
  }

}