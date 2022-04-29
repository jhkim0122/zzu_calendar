import '../../Analysis/analysisData.dart';
import 'option.dart';

class SettingOptions extends Options {

  save() async {
    await saveAsync("settings.json");
  }

  load() async {
    await loadAsync("settings.json");
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
