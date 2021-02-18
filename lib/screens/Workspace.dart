import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_note/models/Note.dart';
import 'package:my_note/providers/NotesProvider.dart';
import 'package:my_note/screens/SetLock.dart';
import 'package:my_note/screens/OCRScreen.dart';
import 'package:my_note/screens/Speech_to_text.dart';
import 'package:provider/provider.dart';

class WorkSpace extends StatefulWidget {
  final Note existingNote;
  WorkSpace({this.existingNote});

  @override
  _WorkSpaceState createState() => _WorkSpaceState();
}

class _WorkSpaceState extends State<WorkSpace> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime now = DateTime.now();
  Note note = Note();
  Note date;

  bool isChanged = false;
  bool favorite = true;
  bool isBold = false;
  bool isItalic = false;
  bool isUnderlined = false;
  bool isRecording = false;

  @override
  void initState() {
    if (widget.existingNote != null) note = widget.existingNote;
    super.initState();
  }

  // prompt() {
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('Exit without saving?'),
  //         actions: [
  //           FlatButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: Text('No'),
  //           ),
  //           FlatButton(
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //             onPressed: () {
  //               Navigator.pushReplacement(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => MyHomePage(),
  //                 ),
  //               );
  //             },
  //             child: Text('Yes'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  NotesProvider get provider {
    return Provider.of<NotesProvider>(context, listen: false);
  }

  Future<bool> _showDialog() async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Do you want to delete this note?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                provider.deleteNote(note);
                Navigator.pop(context, true);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<bool> resetLock() async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Do you want to reset lock?'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() => note.pin = '');
                Navigator.pop(context);
              },
              child: Text('Remove lock'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return SetLock(note: note);
                }));
              },
              child: Text('Change pin'),
            ),
          ],
        );
      },
    );
  }

  void snackBar() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        content: Text(
          favorite ? 'Removed to favorites' : 'Added to Favorites',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<NotesProvider>().notes;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          favorite == true
              ? Padding(
                  padding: EdgeInsets.all(8),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        favorite = false;
                        provider.favorite(note);
                      });

                      snackBar();
                    },
                    icon: Icon(
                      Icons.bookmark_border,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        favorite = true;
                      });
                      provider.deleteFavorite(note);
                      snackBar();
                    },
                    icon: Icon(
                      Icons.bookmark,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
          Tooltip(
            message: 'Delete',
            child: IconButton(
                disabledColor: Colors.grey,
                icon: Icon(
                  CupertinoIcons.delete_solid,
                  size: 25,
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                  if (note.title.isNotEmpty || note.text.isNotEmpty) {
                    final delete = await _showDialog();
                    if (delete ?? false) Navigator.pop(context);
                  }
                }),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: Colors.blue,
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (note.text.isEmpty || note.title.isEmpty) {
                  return showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('You can\'t save an empty note'),
                      actions: [
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                      ],
                    ),
                  );
                } else if (widget.existingNote != null) {
                  provider.update(widget.existingNote, note);
                } else {
                  provider.addNote(note);
                }
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            TextField(
              onChanged: (val) {
                isChanged = !isChanged;
                note.title = val;
                note.date = DateTime.now();
              },
              controller: TextEditingController(text: note.title.trim()),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 23,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                hintText: 'Title',
                hintStyle: TextStyle(
                  fontSize: 19,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
            TextField(
              onChanged: (val) {
                note.text = val;
                isChanged = !isChanged;
                note.date = DateTime.now();
              },
              controller: TextEditingController(text: note.text),
              style: TextStyle(
                fontSize: 17,
                color: Theme.of(context).primaryColor,
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                hintText: 'Type here',
                hintStyle: TextStyle(
                  fontSize: 19,
                  color: Colors.grey,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  note.date == null
                      ? 'Created at ${now.day}-${now.month}-${now.year} , ${now.hour}:${now.minute}'
                      : 'Last Edited : ${note.date.day}/${note.date.month}/${note.date.year}  ${note.date.hour}:${note.date.minute}',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.only(left: 20),
        height: 50,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Row(
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                icon: Image.asset(
                  'images/camera_icon.png',
                  width: 25,
                  color: Theme.of(context).primaryColor,
                ),
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
                icon: Image.asset(
                  'images/mic_icon.png',
                  width: 18,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SpeechScreen();
                      },
                    ),
                  );
                },
              ),
            ),
            if (note.pin == '')
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SetLock(note: note),
                      ),
                    );
                    setState(() {});
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
                  onPressed: resetLock,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
