import 'package:my_note/models/category.dart';
import 'package:my_note/models/Note.dart';
import 'package:my_note/providers/base_provider.dart';

class CategoryProvider extends BaseProvider {
  Category category = Category();

  void addCategory(Category category, Note n) {
    category.categoryNotes?.add(n);
    notifyListeners();
  }
}
