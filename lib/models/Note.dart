import 'package:flutter/material.dart';

class Note {
  String title;
  String text;
  DateTime date;
  bool locked;
  bool isFavorite;
  Color indicator;
  String imagePath;

  Note({
    this.title = '',
    this.text = '',
    this.date,
    this.locked = false,
    this.isFavorite = false,
    this.indicator,
    this.imagePath,
  });

  factory Note.fromJSON(Map<String, dynamic> json) {
    return new Note(
        title: json["title"],
        text: json["text"],
        date: DateTime.tryParse(json["date"]),
        locked: json["locked"],
        indicator: json["indicator"],
        imagePath: json["imagePath"],
        isFavorite: json["isFavorite"]);
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
      "indiator": indicator,
      "imagePath": imagePath,
      "isFavorite": isFavorite,
    };
  }

  static List<Map<String, dynamic>> toJSONList(List<Note> notes) {
    final list = <Map<String, dynamic>>[];
    notes.forEach((note) => list.add(note.toJSON()));
    return list;
  }

  // Note copyWith({
  //   String title,
  //   String text,
  //   DateTime date,
  //   String pin,
  //   bool isFavorite,
  //   Color indicator,
  // }) {
  //   return Note(
  //     title: title ?? this.title,
  //     text: text ?? this.text,
  //     date: date ?? this.date,
  //     pin: pin ?? this.pin,
  //     isFavorite: isFavorite ?? this.isFavorite,
  //     indicator: indicator ?? this.indicator,
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'title': title,
  //     'text': text,
  //     'date': date?.millisecondsSinceEpoch,
  //     'pin': pin,
  //     'isFavorite': isFavorite,
  //     'indicator': indicator?.value,
  //   };
  // }

  // factory Note.fromMap(Map<String, dynamic> map) {
  //   if (map == null) return null;

  //   return Note(
  //     title: map['title'],
  //     text: map['text'],
  //     date: DateTime.fromMillisecondsSinceEpoch(map['date']),
  //     pin: map['pin'],
  //     isFavorite: map['isFavorite'],
  //     indicator: Color(map['indicator']),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory Note.fromJson(String source) => Note.fromMap(json.decode(source));

  // @override
  // String toString() {
  //   return 'Note(title: $title, text: $text, date: $date, pin: $pin, isFavorite: $isFavorite, indicator: $indicator)';
  // }

  // @override
  // bool operator ==(Object o) {
  //   if (identical(this, o)) return true;

  //   return o is Note &&
  //       o.title == title &&
  //       o.text == text &&
  //       o.date == date &&
  //       o.pin == pin &&
  //       o.isFavorite == isFavorite &&
  //       o.indicator == indicator;
  // }

  // @override
  // int get hashCode {
  //   return title.hashCode ^
  //       text.hashCode ^
  //       date.hashCode ^
  //       pin.hashCode ^
  //       isFavorite.hashCode ^
  //       indicator.hashCode;
  // }
}
