import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:my_note/models/Note.dart';
import 'package:my_note/providers/NotesProvider.dart';
import 'package:my_note/screens/OCRScreen.dart';
import 'package:my_note/widgets/Recording.dart';

class BottomControls extends StatefulWidget {
  final Note note;
  final NotesProvider provider;
  final Function reset;

  const BottomControls({
    Key key,
    @required this.note,
    @required this.provider,
    @required this.reset,
  }) : super(key: key);
  @override
  _BottomControlsState createState() => _BottomControlsState();
}

class _BottomControlsState extends State<BottomControls> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        children: [
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(),
              child: Container(
                alignment: Alignment.bottomCenter,
                color: Colors.grey.shade100.withOpacity(0.5),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 30, left: 30, right: 30),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: IconButton(
                    icon: Icon(Icons.camera_enhance),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Ocr(),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: IconButton(
                    icon: Icon(Icons.mic, size: 30),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Recording();
                          });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: IconButton(
                    icon: Icon(Icons.image_outlined),
                    onPressed: () async {
                      widget.provider.addImage(widget.note);
                    },
                  ),
                ),
                if (widget.note.locked == false)
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: IconButton(
                      onPressed: () async {
                        setState(() {
                          widget.provider.lockNote(widget.note);
                        });
                      },
                      icon: Icon(
                        Icons.lock_open,
                        color: Colors.grey,
                      ),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: IconButton(
                      icon: Icon(
                        Icons.lock,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: widget.reset,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
