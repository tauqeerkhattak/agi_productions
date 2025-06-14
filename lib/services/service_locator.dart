import 'package:agi_productions/services/db_service.dart';
import 'package:get_it/get_it.dart';

import 'auth_service.dart';

final GetIt locator = GetIt.instance;

Future<void> initServices() async {
  await locator.reset();
  locator.registerLazySingleton(() => DbService());
  locator.registerLazySingleton(() => AuthService());
}
