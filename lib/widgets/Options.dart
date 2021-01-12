import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_note/models/Note.dart';
import 'package:share/share.dart';

class Options extends StatelessWidget {
  final Note note;

  Options({this.note});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border.all(
            color: Theme.of(context).disabledColor,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 5,
              width: 50,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).unselectedWidgetColor,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                share(context, note);
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Theme.of(context).unselectedWidgetColor,
                        border: Border.all(
                          width: 2,
                          color: Theme.of(context).disabledColor,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.share,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                    Text(
                      'Share',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                final data = ClipboardData(
                  text: '${note.title.toString()}\n ${note.text.toString()}',
                );
                Clipboard.setData(data);
              },
              child: Padding(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Theme.of(context).unselectedWidgetColor,
                        border: Border.all(
                          color: Theme.of(context).disabledColor,
                          width: 2,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.content_copy,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                    Text(
                      'Copy To ClipBoard',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

void share(BuildContext context, Note note) {
  String text = '${note.title}\n ${note.text}';
  Share.share(text, subject: note.text);
}
