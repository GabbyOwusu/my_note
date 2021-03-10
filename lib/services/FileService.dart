import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:my_note/services/FileContract.dart';
import 'package:path_provider/path_provider.dart';

class FileService implements FileContract {
  @override
  Future<String> getPath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + '/mynotes.txt';
    return path;
  }

  @override
  Future<bool> writeFile(String data) async {
    try {
      String filepath = await getPath();
      File file = File(filepath);
      await file.writeAsString(data);
      return true;
    } catch (e) {
      print('Failed to save...$e');
      return false;
    }
  }

  @override
  Future<String> readFile() async {
    try {
      final path = await getPath();
      File file = File(path);
      final result = await file?.readAsString();
      return result;
    } on FileSystemException catch (e) {
      print('Failed to read $e');
      return '';
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
