import 'package:flutter/material.dart';

class Note {
  String title;
  String text;
  DateTime date;
  bool locked;
  bool isFavorite;
  Color indicator;
  String imagePath;
  String audioPath;

  Note({
    this.title = '',
    this.text = '',
    this.date,
    this.locked = false,
    this.isFavorite = false,
    this.indicator = Colors.purple,
    this.imagePath,
    this.audioPath,
  });

  factory Note.fromJSON(Map<String, dynamic> json) {
    return new Note(
      title: json["title"],
      text: json["text"],
      date: DateTime.tryParse(json["date"]),
      locked: json["locked"],
      indicator: json["indicator"],
      imagePath: json["imagePath"],
      isFavorite: json["isFavorite"],
      audioPath: json["audioPath"],
    );
  }

  static List<Note> fromJSONList(List<Map<String, dynamic>> json) {
    final list = <Note>[];
    json.forEach((note) => list.add(Note.fromJSON(note)));
    return list;
  }

  Map<String, dynamic> toJSON() {
    return {
      "title": title,
      "text": text,
      "date": date?.toString(),
      "locked": locked,
      "indiator": indicator.toString(),
      "imagePath": imagePath,
      "isFavorite": isFavorite,
      "audioPath": audioPath,
    };
  }

  static List<Map<String, dynamic>> toJSONList(List<Note> notes) {
    final list = <Map<String, dynamic>>[];
    notes.forEach((note) => list.add(note.toJSON()));
    return list;
  }
}
