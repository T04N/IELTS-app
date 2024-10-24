import 'package:auto_route/auto_route.dart';
import 'package:ielts_tev/presentation/home/home_screen.dart';
import 'package:ielts_tev/presentation/history/history_screen.dart';
import 'package:ielts_tev/presentation/root_screen.dart';

import '../../presentation/getstarted/getstarted_screen.dart';
import '../../presentation/login/login_sceen.dart';
import '../../presentation/pass_recovery/PasswordRecoveryWrapper.dart';
import '../../presentation/pass_recovery/step1_pass_recovery.dart';
import '../../presentation/pass_recovery/step2_verify_code.dart';
import '../../presentation/pass_recovery/step3_change_pass.dart';
import '../../presentation/register/register_screen.dart';
import '../../presentation/splash/splash_screen.dart';
import '../../presentation/welcome/welcome_screen.dart';
// Import SplashScreen

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, path: '/', initial: true),
        // SplashScreen là trang khởi động
        AutoRoute(page: GetStartedRoute.page, path: '/get-started'),
        AutoRoute(page: WelcomeRoute.page, path: '/welcome'),
        AutoRoute(page: LoginRoute.page, path: '/login'),
        AutoRoute(page: RegisterRoute.page, path: '/register'),
        AutoRoute(
            page: PasswordRecoveryRoute.page,
            path: '/password-recovery',
            children: [
              AutoRoute(
                  page: PasswordRecoveryRoute.page,
                  path: 'step1',
                  initial: true
                 ),
              AutoRoute(page: VerifyCodeRoute.page, path: 'step2'),
              AutoRoute(page: ChangePasswordRoute.page, path: 'step3'),
            ]),
        AutoRoute(page: RootRoute.page, path: '/root', children: [
          AutoRoute(page: HomeRoute.page, path: 'home'),
          AutoRoute(page: HistoryRoute.page, path: 'history'),
        ]),
      ];
}
