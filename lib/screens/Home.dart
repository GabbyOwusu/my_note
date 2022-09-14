// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_note/models/Note.dart';
import 'package:my_note/providers/notes_provider.dart';
import 'package:my_note/screens/note_editor.dart';
import 'package:my_note/screens/search.dart';
import 'package:my_note/screens/category_screen.dart';
import 'package:my_note/screens/favroites.dart';
import 'package:my_note/widgets/logo.dart';
import 'package:my_note/widgets/note_tile.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Note note = Note();
  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<NotesProvider>();
    final notes = provider.notes;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: false,
        title: Logo(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
                icon: Icon(
                  Icons.bookmark,
                  color: theme.primaryColor,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Favorites(),
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: Image.asset(
                'images/grid.png',
                color: theme.primaryColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
          child: notes.isNotEmpty
              ? SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 30,
                    top: 20,
                  ),
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return SearchPage();
                                  }),
                                );
                              },
                              child: Container(
                                height: 42,
                                padding: EdgeInsets.only(left: 20, right: 30),
                                decoration: BoxDecoration(
                                  color: theme.unselectedWidgetColor,
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.search,
                                      color: Colors.grey,
                                      size: 15,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Search notes',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isActive = !isActive;
                              });
                            },
                            child: Container(
                              height: 42,
                              width: 42,
                              decoration: BoxDecoration(
                                color: theme.unselectedWidgetColor,
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Center(
                                child: Icon(
                                  isActive ? Icons.menu : Icons.grid_on,
                                  color: theme.primaryColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      StaggeredGridView.countBuilder(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: provider.notes.length,
                          itemBuilder: (context, index) {
                            return NoteTile(note: provider.notes[index]);
                          },
                          staggeredTileBuilder: (int index) {
                            return StaggeredTile.fit(isActive ? 1 : 2);
                          }),
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/notes_icon.png',
                        color: theme.primaryColor,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'No notes yet',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.buttonColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return NoteEditor();
            }),
          );
        },
        child: Center(
          child: Image.asset(
            'images/edit.png',
            width: 20,
            color: theme.scaffoldBackgroundColor,
          ),
        ),
      ),
    );
  }
}
