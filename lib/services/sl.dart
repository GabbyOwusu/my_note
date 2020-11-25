import 'package:get_it/get_it.dart';
import 'package:my_note/services/FileContract.dart';
import 'package:my_note/services/FileService.dart';

GetIt sl = GetIt.instance;

setupServiceLocator() {
  sl.registerLazySingleton<FileContract>(() => FileService());
}
