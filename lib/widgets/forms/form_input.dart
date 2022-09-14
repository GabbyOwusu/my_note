import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final Widget? title;
  final Widget child;

  final EdgeInsets? margin;
  const FormInput({
    Key? key,
    required this.child,
    this.title,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            DefaultTextStyle(
              child: title!,
              style: DefaultTextStyle.of(context).style.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
            ),
            SizedBox(height: 5),
          ],
          child,
        ],
      ),
    );
  }
}
