import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_note/models/Note.dart';

class ShowImage extends StatelessWidget {
  final Note note;
  final void Function() deleteImage;

  const ShowImage({
    Key? key,
    required this.note,
    required this.deleteImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: deleteImage,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(60),
        child: Hero(
          tag: '${note.imagePath}',
          child: Image.file(File(note.imagePath!)),
        ),
      ),
    );
  }
}
