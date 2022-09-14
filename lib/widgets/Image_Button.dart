import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Color? color;
  final Color? textColor;
  final void Function()? ontapped;

  const ImageButton({
    this.title,
    this.icon,
    this.color,
    this.textColor,
    this.ontapped,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$title",
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            SizedBox(width: 10),
            Icon(
              icon,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }
}
