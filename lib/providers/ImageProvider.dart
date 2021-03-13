import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_note/providers/BaseProvider.dart';
import 'package:my_note/services/FileContract.dart';
import 'package:my_note/services/sl.dart';
import 'package:path_provider/path_provider.dart';

class ImageProvider extends BaseProvider {
  final storage = sl.get<FileContract>();

  Future<String> saveImage() async {
    File file = await storage.getImage(ImageSource.gallery);
    Directory dir = await getApplicationDocumentsDirectory();
  }
}
