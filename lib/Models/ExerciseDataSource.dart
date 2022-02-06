import 'package:syncfusion_flutter_calendar/calendar.dart';

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
  Pace pace;

  Running(this.startTime, this.distance, this.pace, {this.eventName = "Running"});
}

class Workout {
  String eventName = "Workout";
  DateTime startTime;
  String part;

  Workout(this.startTime, this.part, {this.eventName = "Workout"});
}

class Pace {
  int min;
  int micro;

  Pace(this.min, this.micro);
}