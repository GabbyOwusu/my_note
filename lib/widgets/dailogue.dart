import 'package:flutter/material.dart';

class MyDialogue {
  Future open(
    BuildContext context,
    Function onpressedYes,
    Function onpressedNO,
    String title,
  ) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete'),
          content: Text(
            title, // 'Do you really want to delete this image?',
            style: TextStyle(color: Colors.grey),
          ),
          actions: [
            TextButton(
              onPressed: () {
                onpressedNO();
                // Navigator.pop(context);
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                onpressedNO();
                // provider.deleteImage(note);
                // Navigator.pop(context);
                // Navigator.pop(context);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
