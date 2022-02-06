import '../Analysis/analysisData.dart';
import 'option.dart';

class ExerciseOptions extends Options {

  save() async {
    await saveAsync("exercise.json");
  }

  load() async {
    await loadAsync("exercise.json");
    if(needUpdate()){
      getDefaultOptions();
      save();
    }
  }

  @override
  getDefaultOptions() {
    exerciseMap.forEach((k, v) {
      map[k] = false;
    });
  }
}
