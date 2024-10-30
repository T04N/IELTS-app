import 'package:get_it/get_it.dart';
import 'package:ielts_tev/repository/input_repository.dart';
import 'package:ielts_tev/repository/output_repository.dart';
import 'package:ielts_tev/service/storage_service.dart';

final locator = GetIt.instance;

void setupLocators() {
  locator.registerLazySingleton<InputRepository>(() => InputRepository());
  locator.registerLazySingleton<OutputRepository>(() => OutputRepository());
  locator.registerLazySingleton<StorageService>(() => StorageService());
}