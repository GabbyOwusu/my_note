import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:my_note/models/Note.dart';

class Category {
  List<Note>? categoryNotes;
  String? title;
  Category({this.categoryNotes, this.title});

  Category copyWith({List<Note>? categoryNotes, String? title}) {
    return Category(
      categoryNotes: categoryNotes ?? this.categoryNotes,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categoryNotes': categoryNotes?.map((x) => x.toJSON()).toList(),
      'title': title,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      categoryNotes: List<Note>.from(
        map['categoryNotes']?.map(
          (x) => Note.fromJSON(x),
        ),
      ),
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) => Category.fromMap(
        json.decode(source),
      );

  @override
  String toString() => 'Category(categoryNotes: $categoryNotes, title: $title)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Category &&
        listEquals(o.categoryNotes, categoryNotes) &&
        o.title == title;
  }

  @override
  int get hashCode => categoryNotes.hashCode ^ title.hashCode;
}
