import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ielts_tev/domains/authentication_repository/authentication_repository.dart';
import 'package:ielts_tev/domains/data_sources/firebase_auth_service.dart';
import 'package:ielts_tev/presentation/history/bloc/history_bloc.dart';
import 'package:ielts_tev/presentation/home/bloc/home_bloc.dart';
import 'package:ielts_tev/presentation/register/bloc/register_cubit.dart';
import 'package:ielts_tev/repository/input_repository.dart';
import 'package:ielts_tev/repository/output_repository.dart';
import 'package:ielts_tev/service/storage_service.dart';
import 'package:ielts_tev/utils/route/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseAuthService = FirebaseAuthService();
    final authenticationRepository = AuthenticationRepositoryIML(firebaseAuthService: firebaseAuthService);
    final inputRepository = InputRepository();
    final outputRepository = OutputRepository();
    final storageService = StorageService();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => authenticationRepository,
        ),
        RepositoryProvider<InputRepository>(
          create: (context) => inputRepository,
        ),
        RepositoryProvider<OutputRepository>(
          create: (context) => outputRepository,
        ),
        RepositoryProvider<StorageService>(
          create: (context) => storageService,
        ),
      ],
      child: MyApp(),
    );
  }
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
            inputRepository: context.read<InputRepository>(),
            storageService: context.read<StorageService>(),
            outputRepository: context.read<OutputRepository>(),
          ),
        ),
        Provider<HistoryBloc>(
          create: (context) => HistoryBloc(
            context.read<StorageService>(),
          ),
        ),
        BlocProvider<RegisterCubit>(
          create: (context) => RegisterCubit(
            authenticationRepository: context.read<AuthenticationRepository>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'EyeApp',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
