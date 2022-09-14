import 'dart:convert';

import 'package:my_note/models/Note.dart';
import 'package:my_note/providers/base_provider.dart';
import 'package:my_note/services/hive_service.dart';
import 'package:my_note/services/sl.dart';

class NotesProvider extends BaseProvider {
  List<Note> _notesList = [];
  String _extractedText = '';
  Note note = Note();

  List<Note> get notes => _notesList.reversed.toList();
  String get extracted => _extractedText;

  final _storage = sl.get<HiveService>();

  void addNote(Note n) {
    if ((n.title ?? '').isEmpty && (n.text ?? '').isEmpty) return;
    _notesList.add(n);
    notifyListeners();
    saveToStorage();
  }

  void deleteNote(Note n) {
    _notesList.remove(n);
    notifyListeners();
    saveToStorage();
  }

  void lockNote(Note n) {
    n.locked = true;
    print(n.locked);
    notifyListeners();
  }

  void unlockNote(Note n) {
    n.locked = false;
    print(n.locked);
    notifyListeners();
  }

  void update(Note newNote, Note oldNote) {
    final index = _notesList.indexWhere((o) => o == oldNote);
    _notesList[index] = newNote;
    notifyListeners();
    saveToStorage();
  }

  // void deleteImage(Note n) async {
  //   await _storage.deleteFile(n.imagePath!);
  //   n.imagePath = null;
  //   notifyListeners();
  // }

  Future<void> saveToStorage() async {
    try {
      final list = Note.toJSONList(_notesList);
      await _storage.saveNotes(jsonEncode(list));
    } catch (e) {
      print('Failed to save $e');
      return null;
    }
  }

  Future<void> readFromStorage() async {
    try {
      final data = await _storage.readNotes();
      if (data != null) {
        final decoded = jsonDecode(data);
        final list = List<Map<String, dynamic>>.from(decoded);
        _notesList = Note.fromJSONList(list);
        print('notelist here ${_notesList.toList()}');
        notifyListeners();
      }
    } catch (e) {
      return null;
    }
  }

  // Future<File?> imageFromDevice(ImageSource imagesorce) async {
  //   PickedFile picture = await _storage.getImage(imagesorce);
  //   if (picture != null) {
  //     _image = File(picture.path);
  //     return _image;
  //   } else {
  //     return null;
  //   }
  // }

  // Future processImage(ImageSource source) async {
  //   File? visionimage = await imageFromDevice(source);
  //   if (visionimage != null) {
  //     FirebaseVisionImage image = FirebaseVisionImage.fromFile(visionimage);
  //     VisionText result = await textRecognizer.processImage(image);
  //     _extractedText = result.text;
  //     print(_extractedText);
  //   } else {
  //     return;
  //   }
  //   notifyListeners();
  // }
}
