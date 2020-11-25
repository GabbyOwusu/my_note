import 'package:flutter/material.dart';
import 'package:my_note/models/Note.dart';
import 'package:my_note/screens/Workspace.dart';
import 'package:my_note/widgets/BottomSheet.dart';
// import 'package:note/widgets/BottomSheet.dart';
// import 'package:note/models/Note.dart';
// import 'package:note/screens/Workspace.dart';

class HomeNoteItem extends StatefulWidget {
  final Note note;

  HomeNoteItem({@required this.note});

  @override
  _HomeNoteItemState createState() => _HomeNoteItemState();
}

class _HomeNoteItemState extends State<HomeNoteItem> {
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
            builder: (context) => WorkSpace(existingNote: widget.note),
          ),
        );
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 1500),
        padding: EdgeInsets.all(10),
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
            Text(
              widget.note.text ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 13,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                height: 1.3,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
