import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../main.dart';
import 'options/ExerciseOptions.dart';

class ExerciseDataSource extends CalendarDataSource {
  ExerciseDataSource(source){
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].startTime;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].startTime;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }
}

class Running {
  String eventName = "Running";
  DateTime startTime;
  double distance;
  int paceMin;
  int paceSecond;
  String memo;
  String filePath;

  Running(this.startTime, this.distance, this.paceMin, this.paceSecond, {this.memo = "", this.filePath = "", this.eventName = "Running"});
}

class Workout {
  String eventName = "Workout";
  DateTime startTime;
  String part;
  int time;
  String memo;
  String filePath;

  Workout(this.startTime, this.part, this.time, {this.memo = "", this.filePath = "", this.eventName = "Workout"});
}

class Shooting {
  String eventName = "Shooting";
  DateTime startTime;
  String type;
  String memo;
  String filePath;

  Shooting(this.startTime, this.type, {this.memo = "", this.filePath = "", this.eventName = "Shooting"});
}

getExerciseLogs() async{
  gDataSources = [];
  var directory = await getApplicationDocumentsDirectory();
  for(var entity in directory.listSync()) {
    if(entity.path.contains("zzuex")){
      var exerciseOptions = ExerciseOptions();
      exerciseOptions.loadExercise(entity.path);
      if(exerciseOptions.map["event name"] == "Running"){
        DateTime dateTime = DateTime.parse(exerciseOptions.map["start time"]);
        double distance = exerciseOptions.map["distance"];
        int paceMin = exerciseOptions.map["pace min"];
        int paceSecond = exerciseOptions.map["pace second"];
        String memo = exerciseOptions.map["memo"]?? "";
        gDataSources.add(Running(dateTime, distance, paceMin, paceSecond, memo: memo, filePath: entity.path));
      } else if(exerciseOptions.map["event name"] == "Workout"){
        DateTime dateTime = DateTime.parse(exerciseOptions.map["start time"]);
        String part = exerciseOptions.map["part"];
        int time = exerciseOptions.map["time"];
        String memo = exerciseOptions.map["memo"]?? "";
        gDataSources.add(Workout(dateTime, part, time, memo: memo, filePath: entity.path));
      } else if(exerciseOptions.map["event name"] == "Shooting"){
        DateTime dateTime = DateTime.parse(exerciseOptions.map["start time"]);
        String type = exerciseOptions.map["type"];
        String memo = exerciseOptions.map["memo"]?? "";
        gDataSources.add(Shooting(dateTime, type, memo: memo, filePath: entity.path));
      }
    }
  }
}