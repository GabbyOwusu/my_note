import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_note/models/Note.dart';

class SetLock extends StatefulWidget {
  final Note note;
  const SetLock({Key key, @required this.note}) : super(key: key);

  @override
  _SetLockState createState() => _SetLockState();
}

class _SetLockState extends State<SetLock> {
  TextEditingController pin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Lock Note',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Set a pin to lock this note'),
              SizedBox(height: 30),
              TextFormField(
                controller: pin,
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  setState(() {});
                },
                maxLength: 4,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(4),
                ],
                maxLines: 1,
                maxLengthEnforced: true,
                buildCounter: (context, {currentLength, maxLength, isFocused}) {
                  return Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      currentLength.toString() + "/" + maxLength.toString(),
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  );
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(15),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1, color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Pin',
                  hintStyle: TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          if (pin.text.length == 4) {
            setState(() {
              widget.note.pin = pin.text;
            });
            print(widget.note.pin);
            Navigator.pop(context);
          } else {
            return;
          }
        },
        child: Container(
          height: 80,
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            decoration: BoxDecoration(
              color: pin.text.length == 4 ? Colors.black : Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Lock Note',
                style: TextStyle(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
