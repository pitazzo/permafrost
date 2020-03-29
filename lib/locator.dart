import 'package:get_it/get_it.dart';
import 'package:permafrost/core/services/firestore.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<FirestoreService>(() => FirestoreService());
}
