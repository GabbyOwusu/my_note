import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_note/models/Note.dart';
import 'package:my_note/providers/FavoritesProvider.dart';
import 'package:my_note/providers/NotesProvider.dart';
import 'package:my_note/screens/OCRScreen.dart';
import 'package:my_note/services/FileContract.dart';
import 'package:my_note/services/sl.dart';
import 'package:my_note/widgets/Recording.dart';
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
  // File noteImage;

  bool isChanged = false;
  bool isBold = false;
  bool isItalic = false;
  bool isUnderlined = false;
  bool isRecording = false;
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  final _storage = sl.get<FileContract>();

  @override
  void initState() {
    if (widget.existingNote != null) note = widget.existingNote;
    super.initState();
  }

  NotesProvider get provider {
    return Provider.of<NotesProvider>(context, listen: false);
  }

  FavoritesProvider get favsprovider {
    return Provider.of<FavoritesProvider>(context, listen: false);
  }

  Future<bool> _showDialog() async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete'),
          content: Text(
            'Do you really want to delete this note?',
            style: TextStyle(color: Colors.grey),
          ),
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
                favsprovider.deleteFavorite(note);
                setState(() {});
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
          title: Text('Remove lock'),
          content: Text(
            'Do you want to remove lock ?',
            style: TextStyle(color: Colors.grey),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() => provider.unlockNote(note));
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
    String text = '${note.title}\n\n${note.text}';
    Share.shareFiles([note.imagePath], text: text);
    // Share.share(text, subject: note.text);
  }

  void snackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(
          note.isFavorite ? 'Added to favorites' : 'Removed to Favorites',
          style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
        ),
      ),
    );
  }

  Future pickColor() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Pick a color!'),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerAreaBorderRadius: BorderRadius.circular(8),
                pickerColor: pickerColor,
                onColorChanged: (color) {
                  setState(() => note.indicator = color);
                },
                showLabel: true,
                pickerAreaHeightPercent: 0.8,
              ),
            ),
            actions: [
              TextButton(
                child: const Text('Done'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    context.watch<NotesProvider>().notes;
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
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
                        setState(() {
                          favsprovider.favorite(note);
                        });
                        snackBar();
                      },
                      icon: Icon(
                        Icons.bookmark_border,
                        size: 25,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          favsprovider.deleteFavorite(note);
                        });
                        snackBar();
                      },
                      icon: Icon(
                        Icons.bookmark,
                        size: 25,
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
              icon: Icon(Icons.share_rounded, size: 25),
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
                  fontWeight: FontWeight.bold,
                ),
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  hintText: 'Title',
                  hintStyle: TextStyle(
                    fontSize: 19,
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Text(
                      'Uncategorized',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () => pickColor(),
                      child: Container(
                        margin: EdgeInsets.only(left: 5),
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                          color: note.indicator ?? Colors.purple,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextField(
                enableInteractiveSelection: true,
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
                cursorColor: Theme.of(context).primaryColor,
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
              SizedBox(height: 20),
              note.imagePath != null
                  ? Container(
                      margin: EdgeInsets.all(20),
                      alignment: Alignment.bottomLeft,
                      child: Image.file(File(note.imagePath)),
                    )
                  : Text(''),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Text(
                    note.date == null
                        ? '${now.day}/${now.month}/${now.year}'
                        : '${note.date.day}/${note.date.month}/${note.date.year}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 100),
            ],
          ),
        ),
        bottomSheet: Container(
          padding: const EdgeInsets.only(left: 20),
          height: 50,
          color: Theme.of(context).scaffoldBackgroundColor,
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
                    provider.addImage(note);
                  },
                ),
              ),
              if (note.locked == false)
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: IconButton(
                    onPressed: () async {
                      setState(() {
                        provider.lockNote(note);
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
      ),
    );
  }
}
