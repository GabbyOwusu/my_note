import 'package:image_picker/image_picker.dart';

abstract class FileContract {
  Future<String> getPath();

  Future<bool> writeFile(String data);

  Future<String> readFile();

  Future getImage(ImageSource source);
}
