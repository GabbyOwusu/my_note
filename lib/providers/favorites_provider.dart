import 'dart:convert';

import 'package:my_note/models/Note.dart';
import 'package:my_note/providers/base_provider.dart';
import 'package:my_note/services/file_contract.dart';
import 'package:my_note/services/sl.dart';

class FavoritesProvider extends BaseProvider {
  List<Note> _favorites = [];
  List<Note> get favs => _favorites.reversed.toList();

  final _storage = sl.get<FileContract>();

  void favorite(Note n) {
    if ((n.title ?? '').isEmpty && (n.text ?? '').isEmpty) return;
    _favorites.add(n);
    n.isFavorite = true;
    saveToStorage();
    print('added to favorites');
    notifyListeners();
  }

  void deleteFavorite(Note n) {
    _favorites.remove(n);
    n.isFavorite = false;
    saveToStorage();
    print('remove from favorites');
    notifyListeners();
  }

  void clearFavorites() {
    _favorites.clear();
    saveToStorage();
    notifyListeners();
  }

  Future saveToStorage() async {
    try {
      final list = Note.toJSONList(_favorites);
      // print(jsonEncode(list));
      return _storage.writeFile(jsonEncode(list), '/myfavorites.txt');
    } catch (e) {
      print('Failed to save $e');
    }
  }

  Future<void> readFromStorage() async {
    try {
      final json = await _storage.readFile('/myfavorites.txt');
      if (json != null) {
        final list = await jsonDecode(json).cast<Map<String, dynamic>>();
        _favorites = Note.fromJSONList(list);
        print('favoritenotelist here $_favorites');
        notifyListeners();
      }
    } catch (e) {
      print('Error here $e');
    }
  }
}
