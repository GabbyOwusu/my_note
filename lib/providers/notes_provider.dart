import 'dart:convert';
import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_note/models/Note.dart';
import 'package:my_note/providers/base_provider.dart';
import 'package:my_note/services/voice_recorder_service.dart';
import 'package:my_note/services/file_contract.dart';
import 'package:my_note/services/sl.dart';

class NotesProvider extends BaseProvider {
  TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
  VoiceRecordingService audioService = VoiceRecordingService();
  List<Note> _notesList = [];
  String _extractedText = '';
  Note note = Note();
  File _image;

  List<Note> get notes => _notesList.reversed.toList();
  String get extracted => _extractedText;

  final _storage = sl.get<FileContract>();

  void addNote(Note n) {
    if (n.title.isEmpty && n.text.isEmpty) return;
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

  void addImage(Note n) async {
    final image = await _storage.getImagePath();
    n.imagePath = image;
    notifyListeners();
  }

  void deleteImage(Note n) async {
    await _storage.deleteFile(n.imagePath);
    n.imagePath = null;
    notifyListeners();
  }

  void addRecording(Note n) async {
    await audioService.record(n);
    notifyListeners();
  }

  void stopRecording() async {
    await audioService.stopRecording();
  }

  Future saveToStorage() async {
    try {
      final list = Note.toJSONList(_notesList);
      print(jsonEncode(list));
      return _storage.writeFile(jsonEncode(list), '/mynotes.txt');
    } catch (e) {
      print('Failed to save $e');
    }
  }

  Future<void> readFromStorage() async {
    try {
      final json = await _storage.readFile('/mynotes.txt');
      if (json == null || json.isEmpty) return '';
      final list = await jsonDecode(json).cast<Map<String, dynamic>>();
      _notesList = Note.fromJSONList(list).toList();
      print('notelist here ${_notesList.toList()}');
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
