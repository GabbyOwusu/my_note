import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_note/models/Note.dart';
import 'package:my_note/screens/Workspace.dart';
import 'package:my_note/services/local_auth_service.dart';

class LockScreen extends StatefulWidget {
  final Note note;

  const LockScreen({Key key, this.note}) : super(key: key);
  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  TextEditingController pinCode = TextEditingController();
  LocalAuthService authService = LocalAuthService();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    authService.runBoimetric();
    super.initState();
  }

  void launchSnackbar() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text('Wrong pinCode.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Locked',
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
              Text(
                'Enter pin code to unlock note',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: pinCode,
                keyboardType: TextInputType.number,
                autofocus: true,
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
              SizedBox(height: 50),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Use biometrics',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Tap on fingerprint to unlock',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.fingerprint,
                  size: 70,
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: pinCode.text.length != 4 ? Colors.grey : Colors.purple,
        onPressed: () async {
          if (pinCode.text == widget.note.pin) {
            await Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return WorkSpace(existingNote: widget.note);
            }));
          } else {
            launchSnackbar();
          }
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
