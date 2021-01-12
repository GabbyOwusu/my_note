import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_note/providers/NotesProvider.dart';
import 'package:my_note/widgets/getImage_button.dart';
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.help,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Scan images with your camera or pick from gallery \nand extract thetext from them',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.help,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Copy and paste the extracted text anywhere\nin your notes',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
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
      bottomSheet: Container(
        height: 120,
        child: Column(
          children: [
            ImageButton(
              ontapped: () {
                provider.processImage(ImageSource.camera).then((_) {
                  setState(() {});
                });
              },
              title: 'Scan',
              icon: Icons.camera,
              textColor: Colors.white,
              color: Colors.blue,
            ),
            ImageButton(
              ontapped: () {
                provider.processImage(ImageSource.gallery).then((_) {
                  setState(() {});
                });
              },
              title: 'Gallery',
              icon: Icons.image,
              textColor: Theme.of(context).primaryColor,
              color: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }
}
