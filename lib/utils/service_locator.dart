import 'package:get_it/get_it.dart';
import 'package:testproject/data/models/Saved.dart';
import 'package:testproject/data/models/User.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => User.instance());
}
