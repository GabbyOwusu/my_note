import 'package:flutter/material.dart';
import 'package:my_note/screens/CategoryListScreen.dart';
import 'package:my_note/widgets/CategoryItem.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
          ),
          iconSize: 20,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Categories',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        actions: [
          Icon(
            Icons.filter_alt_outlined,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(width: 30),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 100,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return CategoryListScreen();
                        }),
                      );
                    },
                    child: CategoryItem(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
