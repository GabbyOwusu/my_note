import 'package:flutter/material.dart';
import 'package:my_note/models/Note.dart';
import 'package:my_note/ui/lock_screen.dart';
import 'package:my_note/ui/note_editor.dart';
import 'package:my_note/utils/utils.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  final void Function()? onTap;

  NoteTile({
    required this.note,
    this.onTap,
  });

  final DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => note.locked == false
                ? NoteEditor(existingNote: note)
                : LockScreen(note: note),
          ),
        );
        onTap?.call();
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
          children: [
            Row(
              children: [
                Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    color: note.indicator ?? Colors.purple,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    note.title ?? '',
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
            note.locked == false
                ? Text(
                    note.text ?? '',
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
                note.date == now
                    ? 'Created at ${formatDate(now)}'
                    : 'Last Edited ${formatDate(note.date)}',
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
