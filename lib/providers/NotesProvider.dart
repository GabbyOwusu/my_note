import 'dart:convert';
import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_note/models/Note.dart';
import 'package:my_note/providers/BaseProvider.dart';
import 'package:my_note/services/FileContract.dart';
import 'package:my_note/services/sl.dart';

class NotesProvider extends BaseProvider {
  NotesProvider() {
    (_notesList == []) ?? readFromStorage();
  }

  TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
  Note note = Note();
  List<Note> _notesList = [];
  List<Note> _favorites = [];
  String _extractedText = '';
  File _image;

  List<Note> get favs => _favorites;
  List<Note> get notes => _notesList;
  String get extracted => _extractedText;

  final _storage = sl.get<FileContract>();

  void addNote(Note n) {
    _notesList.add(n);
    notifyListeners();
    saveToStorage();
  }

  void favorite(Note n) {
    _favorites.add(n);
    print('added to favorites');
    notifyListeners();
  }

  void deleteFavorite(Note n) {
    _favorites.remove(n);
    print('remove from favorites');
    notifyListeners();
  }

  void deleteNote(Note n) {
    _notesList.remove(n);
    notifyListeners();
    saveToStorage();
  }

  void update(Note newNote, Note oldNote) {
    final index = _notesList.indexWhere((o) => o == oldNote);
    _notesList[index] = newNote;
    notifyListeners();
    saveToStorage();
  }

  Future saveToStorage() async {
    try {
      final list = Note.toJSONList(_notesList);
      print(jsonEncode(list));
      return _storage.writeFile(jsonEncode(list));
    } catch (e) {
      print('Failed to save $e');
    }
  }

  Future<void> readFromStorage() async {
    try {
      final json = await _storage.readFile();
      if (json == null || json.isEmpty) return '';
      final list = await jsonDecode(json).cast<Map<String, dynamic>>();
      _notesList = Note.fromJSONList(list);
      print('notelist here $_notesList');
      notifyListeners();
    } catch (e) {
      print('Error here $e');
    }
  }

  Future<File> imageFromDevice(ImageSource imagesorce) async {
    PickedFile picture = await _storage.getImage(imagesorce);
    if (picture != null) {
      _image = File(picture.path);
    } else {
      print('No image selected');
    }
    return _image;
  }

  Future processImage(ImageSource source) async {
    File visionimage = await imageFromDevice(source);
    if (visionimage != null) {
      FirebaseVisionImage image = FirebaseVisionImage.fromFile(visionimage);
      VisionText result = await textRecognizer.processImage(image);
      _extractedText = result.text;
      print(_extractedText);
    } else {
      return;
    }

    notifyListeners();
  }
}
