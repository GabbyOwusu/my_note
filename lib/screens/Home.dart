import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_note/models/Note.dart';
import 'package:my_note/providers/NotesProvider.dart';
import 'package:my_note/screens/Favorites.dart';
import 'package:my_note/screens/Search.dart';
import 'package:my_note/screens/Editor.dart';
import 'package:my_note/widgets/HomeNoteItem.dart';
import 'package:my_note/widgets/logo.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Note note;
  bool isActive = true;

  NotesProvider get provider {
    return Provider.of<NotesProvider>(context);
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('Username'),
            ),
            ListTile(
              leading: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onTap: () {},
            ),
            Divider(),
            Container(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                leading: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Icon(
                  Icons.link,
                  color: Colors.black,
                ),
                onTap: () {},
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: false,
        // leading: IconButton(
        //   onPressed: () {
        //     _key.currentState.openDrawer();
        //   },
        //   icon: Icon(
        //     Icons.menu,
        //     color: Theme.of(context).primaryColor,
        //   ),
        // ),
        title: Logo(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
                icon: Icon(
                  Icons.bookmark,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return Favorites();
                  }));
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: Image.asset('images/grid.png'),
              onPressed: () {},
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
          child: provider.notes.isNotEmpty
              ? SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 30,
                          top: 20,
                        ),
                        child: Row(
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
                                    color:
                                        Theme.of(context).unselectedWidgetColor,
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
                                  color:
                                      Theme.of(context).unselectedWidgetColor,
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Center(
                                  child: Icon(
                                    isActive ? Icons.menu : Icons.grid_on,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: StaggeredGridView.countBuilder(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: provider.notes?.length,
                            itemBuilder: (context, index) {
                              return HomeNoteItem(
                                note: provider.notes[index],
                              );
                            },
                            staggeredTileBuilder: (int index) {
                              return StaggeredTile.fit(isActive ? 1 : 2);
                            }),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/notes_icon.png',
                        color: Theme.of(context).primaryColor,
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
        backgroundColor: Theme.of(context).buttonColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return WorkSpace();
            }),
          );
        },
        child: Center(
          child: Image.asset(
            'images/edit.png',
            width: 20,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      ),
    );
  }
}
