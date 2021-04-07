import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_note/models/Note.dart';
import 'package:my_note/providers/notes_provider.dart';

class Recording extends StatefulWidget {
  final Note note;
  const Recording({
    Key key,
    @required this.note,
  }) : super(key: key);

  @override
  _RecordingState createState() => _RecordingState();
}

class _RecordingState extends State<Recording> {
  bool record = false;

  NotesProvider get provider {
    return Provider.of<NotesProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AvatarGlow(
                repeatPauseDuration: Duration(milliseconds: 20),
                glowColor: Colors.purple,
                repeat: record,
                animate: record,
                endRadius: 150,
                child: GestureDetector(
                  onTap: () {
                    setState(() => record = !record);
                    if (record) {
                      provider.addRecording(widget.note);
                    } else {
                      provider.stopRecording();
                      Future.delayed(Duration(milliseconds: 400), () {
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: Center(
                      child: Icon(
                        record ? Icons.stop : Icons.mic,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                record ? 'Recording...' : 'Record',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                record
                    ? 'Tap on the mic to end recording!'
                    : 'Tap the mic to begin recording!',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
