import 'package:get_it/get_it.dart';

import 'package:my_note/services/hive_service.dart';

GetIt sl = GetIt.instance;

setupServiceLocator() {
  sl.registerLazySingleton<HiveService>(() => HiveService());
}
