import 'package:my_note/models/Category.dart';
import 'package:my_note/models/Note.dart';
import 'package:my_note/providers/BaseProvider.dart';

class CategoryProvider extends BaseProvider {
  Category category = Category();

  void addCategory(Category category, Note n) {
    category.categoryNotes.add(n);
    notifyListeners();
  }
}
