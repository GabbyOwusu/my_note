import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "My",
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w900,
          color: Theme.of(context).primaryColor,
        ),
        children: [
          TextSpan(
            text: "Note",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).primaryColor,
            ),
          ),
          TextSpan(
            text: ".",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
        ],
      ),
      style: TextStyle(
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
