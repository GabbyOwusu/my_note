import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  stt.SpeechToText _speech;
  bool isRecording = false;
  String recordedText;

  @override
  void initState() {
    _speech = stt.SpeechToText();
    super.initState();
  }

  prompt(bool isSaved) {
    if (isSaved == null)
      return;
    else
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Exit without saving?'),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('No'),
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                onPressed: () {},
                child: Text('Yes'),
              ),
            ],
          );
        },
      );
  }

  Future<void> record() async {
    if (!isRecording) {
      bool available = await _speech.initialize(
        onError: (val) {
          print('Sorry : $val');
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'Sorry you need an active internet connection for speech_to_text functionality',
                ),
                actions: [
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        isRecording = false;
                      });
                    },
                    child: Text('Cancel'),
                  ),
                ],
              );
            },
          );
        },
        onStatus: (val) => print('onstatus : $val'),
      );
      if (available) {
        setState(() => isRecording = true);
        _speech.listen(onResult: (val) {
          setState(() {
            recordedText = val.recognizedWords;
          });
        });
      }
    } else {
      _speech.stop();
      setState(() {
        isRecording = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Speech to text',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 50),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.help,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(width: 20),
                Text(
                  'Press the botton on the bottom right corner \nto begin recording',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 50),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.help),
                SizedBox(width: 20),
                Text(
                  'Longpress on recorded text once you\'re  done to copy\nand add to your note',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 150),
            child: SelectableText(
              recordedText ?? 'Your recorded text will appear here....',
              style: TextStyle(
                fontSize: 25,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          tooltip: 'Record',
          onPressed: record,
          child: isRecording
              ? Image.asset(
                  'images/record.gif',
                  color: Colors.white,
                  width: 30,
                )
              : Image.asset(
                  'images/microphone.png',
                  color: Colors.white,
                  width: 20,
                )),
    );
  }
}
