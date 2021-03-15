import 'package:flutter/material.dart';
import 'package:my_note/models/Note.dart';
import 'package:my_note/providers/NotesProvider.dart';
import 'package:my_note/screens/LockScreen.dart';
import 'package:my_note/screens/Editor.dart';
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
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => widget.note.locked == false
                ? WorkSpace(existingNote: widget.note)
                : LockScreen(note: widget.note),
          ),
        );
        // setState(() {});
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 1500),
        padding: EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: Theme.of(context).unselectedWidgetColor.withOpacity(0.4),
          border: Border.all(color: Theme.of(context).disabledColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    color: widget.note.indicator ?? Colors.purple,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.note.title ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            widget.note.locked == false
                ? Text(
                    widget.note.text ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 10,
                    style: TextStyle(
                      color: Colors.grey[600],
                      height: 1.3,
                      fontSize: 14,
                    ),
                  )
                : Icon(Icons.lock),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                widget.note.date == now
                    ? 'Created at ${now.day}-${now.month}-${now.year}'
                    : 'Last Edited : ${widget.note.date.day}/${widget.note.date.month}/${widget.note.date.year}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
