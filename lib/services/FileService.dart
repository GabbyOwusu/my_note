import 'dart:io';
import 'dart:math';

import 'package:image_picker/image_picker.dart';
import 'package:my_note/models/Note.dart';
import 'package:my_note/services/FileContract.dart';
import 'package:path_provider/path_provider.dart';

class FileService implements FileContract {
  @override
  Future<String> getPath(String pathName) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + pathName;
    return path;
  }

  @override
  Future<bool> writeFile(String data, String uri) async {
    try {
      String filepath = await getPath(uri);
      File file = File(filepath);
      await file.writeAsString(data);
      return true;
    } catch (e) {
      print('Failed to save...$e');
      return false;
    }
  }

  @override
  Future<String> readFile(String uri) async {
    try {
      final path = await getPath(uri);
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

  @override
  Future<String> getImagePath(int index) async {
    Directory dir = await getApplicationDocumentsDirectory();
    ImagePicker picker = ImagePicker();
    PickedFile pic = await picker.getImage(source: ImageSource.gallery);
    File picture = File(pic.path);
    File imagePath = await picture.copy(dir.path + 'image$index.png');
    return imagePath.path;
  }
}
