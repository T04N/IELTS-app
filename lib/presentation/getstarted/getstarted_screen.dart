import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theme/app_colors.dart';
import '../../utils/route/app_router.dart';
@RoutePage()
class GetStartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sử dụng MediaQuery để lấy kích thước màn hình và làm cho UI "responsive"
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Hình nền
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/images/bg_image.png',  // Đường dẫn tới hình ảnh của bạn
              fit: BoxFit.cover,
            ),
          ),
          // Nút "Get started"
          Positioned(
            bottom: screenSize.height * 0.05,  // Cách đáy màn hình 5%
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('hasSeenOnboarding', true);
                  context.router.push(const WelcomeRoute());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,  // Màu nền cho nút từ AppColors
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),  // Bo tròn góc nút
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.0),  // Khoảng cách trên/dưới
                ),
                child: Text(
                  'Get started',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
