import 'dart:io';

import 'package:my_note/services/FileContract.dart';
import 'package:path_provider/path_provider.dart';

class FileService implements FileContract {
  var _path;

  FileService() {
    getPath();
  }

  @override
  Future<String> getPath() async {
    final directory = await getApplicationDocumentsDirectory();
    _path = directory.path + '/usernotes.txt';
    print('This is the path..............$_path');
    readFile();
    return _path;
  }

  @override
  Future<bool> writeFile(String data) async {
    try {
      File file = File(await _path);
      if (!(await file.exists())) {
        await file.create();
      }
      await file.writeAsString(data);
      print('saved succesfully to .....$_path');
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  @override
  Future<String> readFile() async {
    try {
      final file = File(await _path);
      if (await file?.exists()) {
        await file.writeAsString('');
      } else {
        file.createSync();
      }
      return file?.readAsString();
    } catch (e) {
      print(e.toString());
      return 'Failed to read';
    }
  }
}
