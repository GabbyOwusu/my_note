import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_note/models/Note.dart';
import 'package:my_note/providers/NotesProvider.dart';
import 'package:my_note/widgets/HomeNoteItem.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  NotesProvider get provider {
    return Provider.of<NotesProvider>(context, listen: false);
  }

  final controller = TextEditingController();

  List<Note> result = [];

  Note note = Note();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Search',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 30, top: 25, bottom: 20),
              child: TextField(
                controller: controller,
                onChanged: (text) async {
                  if (text.isNotEmpty)
                    setState(() {
                      result = provider.notes
                          .where(
                            (n) =>
                                n.text.toLowerCase().contains(text) ||
                                n.title.toLowerCase().contains(text),
                          )
                          .toList();
                    });
                  else
                    result = [];
                  print(result);
                },
                autofocus: true,
                decoration: InputDecoration(
                  disabledBorder: InputBorder.none,
                  filled: true,
                  fillColor: Theme.of(context).unselectedWidgetColor,
                  contentPadding: EdgeInsets.only(left: 20),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(Icons.search, color: Colors.grey, size: 15),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Search notes',
                  hintStyle: TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            result.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 100),
                        Image.asset(
                          'images/Search1.png',
                          width: 100,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'No results',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: result.length,
                      itemBuilder: (context, index) {
                        return HomeNoteItem(
                          note: result[index],
                        );
                      },
                      staggeredTileBuilder: (int index) {
                        return StaggeredTile.fit(1);
                      },
                    ),
                  ),
          ],
        ),
      )),
    );
  }
}
