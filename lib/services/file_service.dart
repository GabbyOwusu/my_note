import 'dart:io';

import 'package:my_note/services/file_contract.dart';
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
      return false;
    }
  }

  @override
  Future readFile(String uri) async {
    try {
      final path = await getPath(uri);
      File file = File(path);
      final result = await file.readAsString();
      return result;
    } catch (e) {
      return null;
    }
  }

  // @override
  // Future<PickedFile> getImage(ImageSource source) async {
  // ImagePicker picker = ImagePicker();
  // PickedFile picture = await picker.getImage(
  //   source: source,
  //   preferredCameraDevice: CameraDevice.rear,
  // );
  // return picture;
  // }

  // @override
  // Future<String> getImagePath() async {
  //   Directory dir = await getApplicationDocumentsDirectory();
  //   final diff = DateTime.now();
  //   ImagePicker picker = ImagePicker();
  //   PickedFile pic = await picker.getImage(source: ImageSource.gallery);
  //   File picture = File(pic.path);
  //   File imagePath = await picture.copy(dir.path + 'note-2-$diff.png');
  //   return imagePath.path;
  // }

  @override
  Future deleteFile(String path) async {
    File picture = File(path);
    return picture.delete();
  }

  // Future<String> getAudioPath() async {
  //   Directory directory = await getApplicationDocumentsDirectory();
  //   DateTime diff = DateTime.now();
  //   String audiopath = directory.path + '/note-2-audio-$diff.mp4';
  //   return audiopath;
  // }
}
