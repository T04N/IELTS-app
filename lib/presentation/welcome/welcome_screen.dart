import 'package:auto_route/auto_route.dart';
import 'package:ielts_tev/utils/route/app_router.dart';
import 'package:flutter/material.dart';
import '../../gen/assets.gen.dart'; // Đảm bảo đường dẫn tệp này chính xác
import '../../theme/app_theme.dart'; // Đảm bảo đường dẫn tệp này chính xác

@RoutePage()
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Stack(
        children: [
          // Background image
          Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Assets.images.rectangle.provider(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Icon at top left
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              width: 35,
              height: 35,
              child: Image(
                image: Assets.images.iconLeft.provider(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Padding to push the content up
          Padding(
            padding: EdgeInsets.only(bottom: size.height * 0.3),
            // Adjust the top padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image(
                    image: Assets.images.logo.provider(),
                    width: size.width * 0.5,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Image(
                    image: Assets.images.yolotext.provider(),
                    width: size.width * 0.6,
                  ),
                ),
              ],
            ),
          ),
          // Positioned buttons at the bottom
          Positioned(
            bottom: size.height * 0.05,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: "LOG IN",
                      backgroundColor: Colors.white,
                      borderColor: Colors.black,
                      onPressed: () {
                        context.router.push(LoginRoute());
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomButton(
                      text: "REGISTER",
                      backgroundColor: Colors.black,
                      borderColor: Colors.black,
                      onPressed: () {
                        context.router.push(RegisterRoute());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
