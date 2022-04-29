import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Analysis/analysisData.dart';
import '../Models/options/ExerciseOptions.dart';
import '../main.dart';

class InputDataPage extends StatefulWidget {
  const InputDataPage({Key? key}) : super(key: key);

  @override
  State<InputDataPage> createState() => _InputDataPageState();
}

class _InputDataPageState extends State<InputDataPage> {
  int _selectedIndex = 0;
  var exerciseOptions = ExerciseOptions();
  var memoCon = TextEditingController();

  var distanceCon = TextEditingController();
  var paceMinCon = TextEditingController();
  var paceSecondCon = TextEditingController();

  var timeCon = TextEditingController();
  String part = "";
  String type = "";
  var workoutPartFlagList = [];
  var gunTypeFlagList = [];

  @override
  void initState() {
    super.initState();
    for(var work in workoutList) workoutPartFlagList.add(false);
    for(var gun in shootingList) gunTypeFlagList.add(false);
  }
  
  Widget _getInputData() {

    if(_selectedIndex == 0){
      return Container(
        margin: EdgeInsets.only(top:10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text("거리 (km)", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                ),
                Row(
                  children: [
                    Container(
                      width: 100, height: 80,
                      padding: EdgeInsets.only(top:5, left:10, right:10, bottom:15),
                      child: TextField(
                        onChanged : (_) => setState((){}),
                        controller: distanceCon..text,
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: '거리',
                          hintStyle: TextStyle(color:Colors.grey, fontSize:13),
                        ),
                        keyboardType: TextInputType.number,
                        style:TextStyle(fontSize:20),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:5, bottom:15),
                      child:Text("km", style:TextStyle(fontSize:18, fontWeight: FontWeight.bold))
                    ),
                  ]
                ),
                Container(
                  margin: EdgeInsets.only(top:20),
                  padding: EdgeInsets.all(10),
                  child: Text("페이스 (minute/km)", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children:[
                    Container(
                      width: 80, height: 80,
                      padding: EdgeInsets.only(top:5, left:10, right:10, bottom:15),
                      child: TextField(
                        onChanged : (_) => setState((){}),
                        controller: paceMinCon..text,
                        textAlign: TextAlign.end,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'min',
                          hintStyle: TextStyle(color:Colors.grey, fontSize:13),
                        ),
                        keyboardType: TextInputType.number,
                        style:TextStyle(fontSize:18),
                      ),
                    ),
                    Container(
                      padding:EdgeInsets.only(top:5),
                      child:Text("'", style:TextStyle(fontSize:20, fontWeight:FontWeight.w900))
                    ),
                    Container(
                      width: 80, height: 80,
                      padding: EdgeInsets.only(top:5, left:10, right:10, bottom:15),
                      child: TextField(
                        onChanged : (_) => setState((){}),
                        controller: paceSecondCon..text,
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'sec',
                          hintStyle: TextStyle(color:Colors.grey, fontSize:13),
                        ),
                        keyboardType: TextInputType.number,
                        style:TextStyle(fontSize:18),
                      ),
                    ),
                    Container(
                        padding:EdgeInsets.only(top:5),
                        child:Text("''", style:TextStyle(fontSize:25, fontWeight:FontWeight.w900))
                    ),
                  ]
                ),
                Container(
                  margin: EdgeInsets.only(top:20),
                  padding: EdgeInsets.all(10),
                  child: Text("Memo", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                ),
                Container(
                  padding: EdgeInsets.only(top:5, left:10, right:10, bottom:15),
                  child: TextField(
                    onChanged : (_) => setState((){}),
                    maxLines:4,
                    controller: memoCon..text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      labelText: 'Memo',
                      labelStyle: TextStyle(color:Colors.grey, fontSize:15),
                    ),
                    style:TextStyle(fontSize:15),
                  ),
                ),
              ]
        )
      );
    } else if(_selectedIndex == 1){
      return Container(
          margin: EdgeInsets.only(top:10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text("부위 : "+part, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                ),
                Wrap(
                  children:[
                    for(int i=0; i<workoutList.length; i++)
                      Container(
                        width:100,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: workoutPartFlagList[i]? Colors.deepOrangeAccent.withOpacity(0.3) : Colors.deepOrangeAccent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: InkWell(
                          onTap: () {
                            workoutPartFlagList[i] = !workoutPartFlagList[i];

                            if(workoutPartFlagList[i] && !part.contains(workoutList[i])) {
                              if(part!="") part+=", ";
                              part+=workoutList[i];
                            } else if(!workoutPartFlagList[i] && part.contains(workoutList[i])){
                              if(part.contains(", "+workoutList[i])) part = part.replaceAll(", "+workoutList[i],"");
                              else if(part.contains(workoutList[i]+", ")) part = part.replaceAll(workoutList[i]+", ", "");
                              else part = part.replaceAll(workoutList[i], "");
                            }

                            setState((){});
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 1.0),
                            child: Row(
                              children: <Widget>[
                                Checkbox(
                                  value: workoutPartFlagList.elementAt(i),
                                  activeColor: Colors.deepOrangeAccent.shade700,
                                  onChanged: (value) {
                                    workoutPartFlagList[i]= value;

                                    if(workoutPartFlagList[i] && !part.contains(workoutList[i])) {
                                      if(part!="") part+=", ";
                                      part+=workoutList[i];
                                    } else if(!workoutPartFlagList[i] && part.contains(workoutList[i])){
                                      if(part.contains(", "+workoutList[i])) part = part.replaceAll(", "+workoutList[i],"");
                                      else part = part.replaceAll(workoutList[i], "");
                                    }
                                    setState((){});
                                  },
                                ),
                                Text(workoutList.elementAt(i), style: TextStyle(fontSize:15, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ]
                ),
                Container(
                  margin: EdgeInsets.only(top:20),
                  padding: EdgeInsets.all(10),
                  child: Text("시간 (min)", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                ),
                Row(
                  children:[
                    Container(
                      width: 80, height: 80,
                      padding: EdgeInsets.only(top:5, left:10, right:5, bottom:15),
                      child: TextField(
                        onChanged : (_) => setState((){}),
                        controller: timeCon..text,
                        textAlign: TextAlign.end,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'time',
                          hintStyle: TextStyle(color:Colors.grey, fontSize:15),
                        ),
                        keyboardType: TextInputType.number,
                        style:TextStyle(fontSize:18),
                      ),
                    ),
                    const Padding(
                      padding:EdgeInsets.only(top:5, bottom:15),
                      child: Text("분", style:TextStyle(fontSize:18, fontWeight: FontWeight.bold))
                    ),
                  ]
                ),
                Container(
                  margin: const EdgeInsets.only(top:20),
                  padding: const EdgeInsets.all(10),
                  child: const Text("Memo", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                ),
                Container(
                  padding: const EdgeInsets.only(top:5, left:10, right:10, bottom:15),
                  child: TextField(
                    onChanged : (_) => setState((){}),
                    maxLines:4,
                    controller: memoCon..text,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      labelText: 'Memo',
                      labelStyle: TextStyle(color:Colors.grey, fontSize:15),
                    ),
                    style:const TextStyle(fontSize:15),
                  ),
                ),
              ]
          )
      );
    } else if(_selectedIndex == 2){
      return Container(
          margin: EdgeInsets.only(top:10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text("종류 : "+type, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                ),
                Wrap(
                    children:[
                      for(int i=0; i<shootingList.length; i++)
                        Container(
                          width:100,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: gunTypeFlagList[i]? Colors.lime.withOpacity(0.3) : Colors.lime.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: InkWell(
                            onTap: () {
                              gunTypeFlagList[i] = !gunTypeFlagList[i];

                              if(gunTypeFlagList[i] && !type.contains(shootingList[i])) {
                                if(type!="") type+=", ";
                                type+=shootingList[i];
                              } else if(!gunTypeFlagList[i] && type.contains(shootingList[i])){
                                if(type.contains(", "+shootingList[i])) type = type.replaceAll(", "+shootingList[i],"");
                                else if(type.contains(shootingList[i]+", ")) type = type.replaceAll(shootingList[i]+", ", "");
                                else type = type.replaceAll(shootingList[i], "");
                              }

                              setState((){});
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 1.0),
                              child: Row(
                                children: <Widget>[
                                  Checkbox(
                                    value: gunTypeFlagList.elementAt(i),
                                    activeColor: Colors.lime.shade700,
                                    onChanged: (value) {
                                      gunTypeFlagList[i]= value;

                                      if(gunTypeFlagList[i] && !type.contains(shootingList[i])) {
                                        if(type!="") type+=", ";
                                        type+=shootingList[i];
                                      } else if(!gunTypeFlagList[i] && type.contains(shootingList[i])){
                                        if(type.contains(", "+shootingList[i])) type = type.replaceAll(", "+shootingList[i],"");
                                        else type = type.replaceAll(shootingList[i], "");
                                      }
                                      setState((){});
                                    },
                                  ),
                                  Text(shootingList.elementAt(i), style: TextStyle(fontSize:15, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ]
                ),
                Container(
                  margin: const EdgeInsets.only(top:20),
                  padding: const EdgeInsets.all(10),
                  child: const Text("Memo", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                ),
                Container(
                  padding: const EdgeInsets.only(top:5, left:10, right:10, bottom:15),
                  child: TextField(
                    onChanged : (_) => setState((){}),
                    maxLines:4,
                    controller: memoCon..text,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      labelText: 'Memo',
                      labelStyle: TextStyle(color:Colors.grey, fontSize:15),
                    ),
                    style:const TextStyle(fontSize:15),
                  ),
                ),
              ]
          )
      );
    }
    return const SizedBox();
  }


  @override
  Widget build(BuildContext context) {
    bool saveFlag = gSelectedDateTime!=null;
    if(_selectedIndex == 0){
      saveFlag = saveFlag && distanceCon.text!="" && paceMinCon.text!="" && paceSecondCon.text!="";
    } else if(_selectedIndex == 1){
      saveFlag = saveFlag && part!="" && timeCon.text!="";
    } else if(_selectedIndex == 2){
      saveFlag = saveFlag && type!="";
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top:40),
        padding: EdgeInsets.all(15),
        child:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children:[
                  Text(" "+ gSelectedDateTime.month.toString()+"월 ", style: TextStyle(fontSize:35, fontWeight: FontWeight.w600)),
                  Text(gSelectedDateTime.day.toString()+"일 ", style:TextStyle(fontSize:35, fontWeight: FontWeight.w600)),
                  Padding(
                    padding: EdgeInsets.only(left:5, bottom:5),
                    child:Text(weekdayKorList[gSelectedDateTime.weekday-1]+"요일",
                        style:TextStyle(fontSize:25))
                  ),
                ]
              ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child:Divider(thickness: 1, color: Colors.black,),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: _selectedIndex == 0? Colors.amber.withOpacity(0.5) : Colors.amber.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: FlatButton(
                    child:Text("러닝", style: GoogleFonts.nanumGothic(
                        textStyle: TextStyle(color: _selectedIndex == 0? Colors.black : Colors.grey, fontWeight: FontWeight.w700))),
                    onPressed: (){
                      _selectedIndex = 0;
                      setState(() {});
                    }
                  )
                ),
                Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: _selectedIndex == 1? Colors.deepOrangeAccent.withOpacity(0.5) : Colors.deepOrangeAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: FlatButton(
                        child:Text("헬스", style: GoogleFonts.nanumGothic(
                            textStyle: TextStyle(color: _selectedIndex == 1? Colors.black : Colors.grey, fontWeight: FontWeight.w700))),
                        onPressed: (){
                          _selectedIndex = 1;
                          setState(() {});
                        }
                    )
                ),
                Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: _selectedIndex == 2? Colors.lime.withOpacity(0.5) : Colors.lime.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: FlatButton(
                        child:Text("사격", style: GoogleFonts.nanumGothic(
                            textStyle: TextStyle(color: _selectedIndex == 2? Colors.black : Colors.grey, fontWeight: FontWeight.w700))),
                        onPressed: (){
                          _selectedIndex = 2;
                          setState(() {});
                        }
                    )
                ),
              ]
            ),
            _getInputData()
          ]
        ),
      ),),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 1.0,
        selectedFontSize: 0.0, unselectedFontSize: 0.0,
        items: [
          BottomNavigationBarItem(icon: Text("취소", style: TextStyle(fontSize:20, fontWeight: FontWeight.bold)), label: ""),
          BottomNavigationBarItem(icon: Text("저장", style: TextStyle(fontSize:20, fontWeight: FontWeight.bold, color: saveFlag?Colors.black:Colors.grey)), label: "",),
        ],
        onTap: (value) async{
          if(value == 0) Navigator.pop(context);
          else if(saveFlag && value == 1) {
            exerciseOptions.map["event name"] = exerciseMap.keys.toList().elementAt(_selectedIndex);
            exerciseOptions.map["start time"] = gSelectedDateTime.toString(); // string
            exerciseOptions.map["memo"] = memoCon.text; // string

            if(_selectedIndex == 0) { // running
              exerciseOptions.map["distance"] = double.parse(distanceCon.text);
              exerciseOptions.map["pace min"] = int.parse(paceMinCon.text);
              exerciseOptions.map["pace second"] = int.parse(paceSecondCon.text);
            } else if(_selectedIndex == 1){ // workout
              exerciseOptions.map["part"] = part;
              exerciseOptions.map["time"] = int.parse(timeCon.text);
            } else if(_selectedIndex == 2){ // shooting
              exerciseOptions.map["type"] = type;
            }

            await exerciseOptions.save();
            Navigator.pop(context);
            setState((){});
          }
        }
      ),
    );
  }
}