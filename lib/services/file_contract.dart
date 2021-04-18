import 'package:image_picker/image_picker.dart';

abstract class FileContract {
  Future<String> getPath(String pathName);

  Future<bool> writeFile(String data, String uri);

  Future<String> readFile(String uri);

  Future getImage(ImageSource source);

  Future<String> getImagePath();

  Future deleteFile(String path);
}
