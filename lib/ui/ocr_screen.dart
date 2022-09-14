import 'package:flutter/material.dart';
import 'package:my_note/providers/notes_provider.dart';
import 'package:my_note/widgets/image_button.dart';
import 'package:provider/provider.dart';

class Ocr extends StatefulWidget {
  @override
  _OcrState createState() => _OcrState();
}

class _OcrState extends State<Ocr> {
  NotesProvider get provider {
    return Provider.of<NotesProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ocr',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.help,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      'Scan images with your camera or pick from gallery and extract thetext from them',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.help,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      'Copy and paste the extracted text anywhere in your notes',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 100),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 150),
              child: SelectableText(
                provider.extracted == ''
                    ? 'Your extracted text will appear here....'
                    : provider.extracted,
                style: TextStyle(
                  fontSize: 25,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(height: 150)
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ImageButton(
                ontapped: () {
                  // provider.processImage(ImageSource.camera).then((_) {
                  //   setState(() {});
                  // });
                },
                title: 'Scan',
                icon: Icons.camera,
                textColor: Colors.white,
                color: Colors.blue,
              ),
              ImageButton(
                ontapped: () {
                  // provider.processImage(ImageSource.gallery).then((_) {
                  //   setState(() {});
                  // });
                },
                title: 'Gallery',
                icon: Icons.image,
                textColor: Theme.of(context).primaryColor,
                color: Colors.grey[300]!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
