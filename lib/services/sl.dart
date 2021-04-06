import 'package:get_it/get_it.dart';
import 'package:my_note/services/file_contract.dart';
import 'package:my_note/services/file_service.dart';

GetIt sl = GetIt.instance;

setupServiceLocator() {
  sl.registerLazySingleton<FileContract>(() => FileService());
}
