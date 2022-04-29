import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

abstract class Options{
  var map = new Map();

  loadCommon(filename){
    getApplicationDocumentsDirectory().then((directory){
      final path = directory.path + '/' + filename;
      var file = File(path);
      file.exists().then((isExist){
        if(isExist){
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
      });

    });
  }

  loadAsync(filename) async {
    var directory = await getApplicationDocumentsDirectory();
    final path = directory.path + '/' + filename;
    var file = File(path);
    var isExist = await file.exists();
    if(isExist){
      try{
        map = jsonDecode(file.readAsStringSync());
      }catch(_){}
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

  saveAsync(filename) async{
    var directory = await getApplicationDocumentsDirectory();
    final path = directory.path + '/' + filename;
    var file = File(path);
    if(await file.exists()) {
      await file.delete();
      await file.create();
    }
    file.writeAsStringSync(jsonEncode(map));
  }


  getDefaultOptions();
  needUpdate(){
    return false;
  }
  needReset(){
    return false;
  }
}