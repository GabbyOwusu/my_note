import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Icon(
            Icons.folder,
            size: 100,
            color: Colors.purple,
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(left: 10, top: 3),
            child: Text(
              'Religion',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
