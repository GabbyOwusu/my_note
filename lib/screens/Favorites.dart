import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_note/providers/FavoritesProvider.dart';
import 'package:my_note/providers/NotesProvider.dart';
import 'package:my_note/widgets/HomeNoteItem.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  bool isActive = false;

  FavoritesProvider get provider {
    return Provider.of<FavoritesProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FavoritesProvider>().favs;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Favorites',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
          ),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
                icon: Icon(
                  isActive ? Icons.grid_on : Icons.menu,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  setState(() {
                    isActive = !isActive;
                  });
                }),
          )
        ],
      ),
      body: provider.favs.length == 0
          ? Center(
              child: Text('Your favorite notes will appear here'),
            )
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: provider.favs?.length,
                    itemBuilder: (context, index) {
                      return HomeNoteItem(
                        note: provider.favs[index],
                      );
                    },
                    staggeredTileBuilder: (int index) {
                      return StaggeredTile.fit(isActive ? 1 : 2);
                    }),
              ),
            ),
    );
  }
}
