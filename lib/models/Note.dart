import 'dart:convert';

class Note {
  String title;
  String text;
  DateTime date;
  String pin;

  Note({
    this.title = '',
    this.text = '',
    this.date,
    this.pin = '',
  });

  factory Note.fromJSON(Map<String, dynamic> json) {
    return new Note(
      title: json["title"],
      text: json["text"],
      date: DateTime.tryParse(json["date"]),
      pin: json["pin"],
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
      "pin": pin,
    };
  }

  static List<Map<String, dynamic>> toJSONList(List<Note> notes) {
    final list = <Map<String, dynamic>>[];
    notes.forEach((note) => list.add(note.toJSON()));
    return list;
  }

  Note copyWith({
    String title,
    String text,
    DateTime date,
    String pin,
  }) {
    return Note(
      title: title ?? this.title,
      text: text ?? this.text,
      date: date ?? this.date,
      pin: pin ?? this.pin,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'text': text,
      'date': date?.millisecondsSinceEpoch,
      'pin': pin,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Note(
      title: map['title'],
      text: map['text'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      pin: map['pin'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Note(title: $title, text: $text, date: $date, pin: $pin)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Note &&
        o.title == title &&
        o.text == text &&
        o.date == date &&
        o.pin == pin;
  }

  @override
  int get hashCode {
    return title.hashCode ^ text.hashCode ^ date.hashCode ^ pin.hashCode;
  }
}
