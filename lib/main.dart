import 'package:ielts_tev/locator.dart';
import 'package:ielts_tev/presentation/history/bloc/history_bloc.dart';
import 'package:ielts_tev/presentation/home/bloc/home_bloc.dart';
import 'package:ielts_tev/repository/input_repository.dart';
import 'package:ielts_tev/repository/output_repository.dart';
import 'package:ielts_tev/service/storage_service.dart';
import 'package:ielts_tev/utils/route/app_router.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocators();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<HomeBloc>(
          create: (context) => HomeBloc(
            inputRepository: locator<InputRepository>(),
            storageService: locator<StorageService>(),
            outputRepository: locator<OutputRepository>(),
          ),
        ),
        Provider<HistoryBloc>(
          create: (context) => HistoryBloc(
            locator<
                StorageService>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'EyeApp',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        debugShowCheckedModeBanner: false,
        routerConfig:
            _appRouter.config(), // Make sure _appRouter is defined correctly
      ),
    );
  }
}
