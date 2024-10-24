import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/route/app_router.dart';


@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // _checkIfFirstLaunch();
    context.router.replace(GetStartedRoute());
  }
  Future<void> _checkIfFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? hasSeenOnboarding = prefs.getBool('hasSeenOnboarding');
    if (hasSeenOnboarding == null || !hasSeenOnboarding) {
      context.router.replace(GetStartedRoute());
    } else {
      context.router.replace(WelcomeRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Hiệu ứng xoay tròn
      ),
    );
  }
}