import 'dart:convert';
import 'dart:io';

import 'option.dart';

class ExerciseOptions extends Options {

  loadExercise(path) {
    var file = File(path);
    if(file.existsSync()){
      map = jsonDecode(file.readAsStringSync());
      if(needReset()) {
        map.clear();
        getDefaultOptions();
        file.writeAsStringSync(jsonEncode(map));
      }
      if(needUpdate()){
        getDefaultOptions();
        file.writeAsStringSync(jsonEncode(map));
      }
    }
    else{
      getDefaultOptions();
      file.writeAsStringSync(jsonEncode(map));
    }
  }

  save() async {
    await saveAsync("zzuex_${DateTime.now().toString()}.json");
  }

  @override
  getDefaultOptions() {
    // both
    map["event name"] = ""; // string
    map["start time"] = ""; // string
    map["memo"] = ""; // string

    // running
    map["distance"]; // double
    map["pace min"]; // int
    map["pace second"]; // int

    // workout
    map["part"]; // string
    map["time"]; //int

    // shooting
    map["type"]; // string
  }
}