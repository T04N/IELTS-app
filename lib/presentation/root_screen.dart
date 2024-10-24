import 'package:auto_route/auto_route.dart';
import 'package:ielts_tev/utils/route/app_router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: [
        HomeRoute(),
        HistoryRoute(),
      ], 
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

      return Scaffold(
        body: child,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.deepOrange,
          currentIndex: tabsRouter.activeIndex,
          onTap: (index){
            tabsRouter.setActiveIndex(index);
          },
          items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ]),
      );
    },);
  }
}