import 'package:flutter/material.dart';
import 'package:my_note/models/Note.dart';
import 'package:my_note/providers/NotesProvider.dart';
import 'package:my_note/screens/LockScreen.dart';
import 'package:my_note/screens/Workspace.dart';
import 'package:my_note/widgets/Options.dart';
import 'package:provider/provider.dart';

class HomeNoteItem extends StatefulWidget {
  final Note note;

  HomeNoteItem({@required this.note});

  @override
  _HomeNoteItemState createState() => _HomeNoteItemState();
}

class _HomeNoteItemState extends State<HomeNoteItem> {
  DateTime now = DateTime.now();
  NotesProvider get provider {
    return Provider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return Options(note: widget.note);
            });
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => widget.note.pin == ''
                ? WorkSpace(existingNote: widget.note)
                : LockScreen(note: widget.note),
          ),
        );
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 1500),
        padding: EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: Theme.of(context).unselectedWidgetColor.withOpacity(0.3),
          border: Border.all(color: Theme.of(context).disabledColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.note.title ?? '',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 10),
            widget.note.pin == ''
                ? Text(
                    widget.note.text ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 13,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      height: 1.3,
                      fontSize: 13,
                    ),
                  )
                : Icon(Icons.lock),
            SizedBox(height: 20),
            Text(
              widget.note.date == now
                  ? 'Created at ${now.day}-${now.month}-${now.year} , ${now.hour}:${now.minute}'
                  : 'Last Edited : ${widget.note.date.day}/${widget.note.date.month}/${widget.note.date.year}  ${widget.note.date.hour}:${widget.note.date.minute}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
