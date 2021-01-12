import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:my_note/services/FileContract.dart';
import 'package:path_provider/path_provider.dart';

class FileService implements FileContract {
  @override
  Future<String> getPath() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path + '/usernotes.txt';
    print('This is the path.......$path');
    return path;
  }

  @override
  Future<bool> writeFile(String data) async {
    try {
      final path = await getPath();
      File file = File(path);
      if (!(await file.exists())) {
        await file.create();
      }
      await file.writeAsString(data);
      print('saved succesfully to .....$path');
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  @override
  Future<String> readFile() async {
    try {
      final path = await getPath();
      File file = File(path);
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

  @override
  Future<PickedFile> getImage(ImageSource source) async {
    ImagePicker picker = ImagePicker();
    PickedFile picture = await picker.getImage(
      source: source,
      preferredCameraDevice: CameraDevice.rear,
    );
    return picture;
  }
}
