import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_note/providers/favorites_provider.dart';
import 'package:my_note/widgets/note_tile.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  bool isActive = false;

  FavoritesProvider get provider {
    return Provider.of<FavoritesProvider>(context, listen: false);
  }

  Future<bool> _showDialog() async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete'),
          content: Text(
            'Do you really want to clear this favorites ?',
            style: TextStyle(color: Colors.grey),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                provider.clearFavorites();
                setState(() {});
                Navigator.pop(context, true);
              },
              child: Text('Clear'),
            ),
          ],
        );
      },
    );
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
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
          ),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
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
                  Icons.delete,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  _showDialog();
                }),
          )
        ],
      ),
      body: provider.favs.length == 0
          ? Center(child: Text('Your favorite notes will appear here'))
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  children: [
                    StaggeredGridView.countBuilder(
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
                  ],
                ),
              ),
            ),
    );
  }
}
