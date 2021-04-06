import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class Recording extends StatefulWidget {
  const Recording({Key key}) : super(key: key);

  @override
  _RecordingState createState() => _RecordingState();
}

class _RecordingState extends State<Recording> {
  bool record = false;

  // FlutterSound sound = FlutterSound();

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
                      //TODO add recording
                    } else {
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
