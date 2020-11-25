import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_note/models/Note.dart';
import 'package:my_note/providers/NotesProvider.dart';
import 'package:my_note/screens/Search.dart';
import 'package:my_note/screens/Workspace.dart';
import 'package:my_note/widgets/HomeNoteItem.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Note note;
  bool isActive = true;

  @override
  void initState() {
    super.initState();
  }

  NotesProvider get provider {
    return Provider.of<NotesProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text.rich(
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
            ],
          ),
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 20),
            child: Text(
              '${provider.notes?.length ?? 0} notes',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          )
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
          child: provider.notes.isNotEmpty
              ? FutureBuilder(
                  future: provider.readFromStorage(),
                  builder: (context, snapshot) {
                    print(snapshot.data);
                    return SingleChildScrollView(
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
                                      height: 45,
                                      padding:
                                          EdgeInsets.only(left: 20, right: 30),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .unselectedWidgetColor,
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
                                    height: 45,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .unselectedWidgetColor,
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
                          SizedBox(height: 10),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 20, right: 20, top: 10),
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
                    );
                  })
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
