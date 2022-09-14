import 'package:flutter/material.dart';
import 'package:my_note/models/Note.dart';
import 'package:my_note/ui/note_editor.dart';
import 'package:my_note/services/local_auth_service.dart';

class LockScreen extends StatefulWidget {
  final Note note;

  const LockScreen({Key? key, required this.note}) : super(key: key);
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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NoteEditor(existingNote: widget.note),
            ),
          );
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
