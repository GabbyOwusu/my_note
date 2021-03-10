import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_note/models/Note.dart';
import 'package:my_note/providers/NotesProvider.dart';
import 'package:my_note/screens/SetLock.dart';
import 'package:my_note/screens/OCRScreen.dart';
import 'package:my_note/screens/Speech_to_text.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

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
  bool isBold = false;
  bool isItalic = false;
  bool isUnderlined = false;
  bool isRecording = false;

  @override
  void initState() {
    if (widget.existingNote != null) note = widget.existingNote;
    super.initState();
  }

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
                setState(() => note.locked = false);
                Navigator.pop(context);
              },
              child: Text('Remove lock'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go back'),
            ),
          ],
        );
      },
    );
  }

  void share(BuildContext context, Note note) {
    String text = '${note.title}\n ${note.text}';
    Share.share(text, subject: note.text);
  }

  void snackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(
          note.isFavorite ? 'Added to favorites' : 'Removed to Favorites',
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
            if (widget.existingNote != null) {
              provider.update(widget.existingNote, note);
            } else {
              provider.addNote(note);
            }
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          note.isFavorite == false
              ? Padding(
                  padding: EdgeInsets.all(8),
                  child: IconButton(
                    onPressed: () {
                      provider.favorite(note);
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
          IconButton(
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
            },
          ),
          IconButton(
            icon: Icon(Icons.share, size: 25),
            color: Theme.of(context).primaryColor,
            onPressed: () => share(context, note),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (val) {
                      isChanged = !isChanged;
                      note.title = val;
                      note.date = DateTime.now();
                    },
                    controller: TextEditingController(text: note.title.trim()),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
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
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(right: 20),
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      color: note.indicator ?? Colors.purple,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            TextField(
              onChanged: (val) {
                note.text = val;
                isChanged = !isChanged;
                note.date = DateTime.now();
              },
              controller: TextEditingController(text: note.text),
              style: TextStyle(
                fontSize: 15,
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
            if (note.locked == false)
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  onPressed: () async {
                    setState(() {
                      note.locked = true;
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
                  onPressed: resetLock,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
