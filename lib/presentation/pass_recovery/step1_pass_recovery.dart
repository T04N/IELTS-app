import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:ielts_tev/presentation/getstarted/getstarted_screen.dart';
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../utils/route/app_router.dart';

@RoutePage()
class PasswordRecoveryScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // Sử dụng MediaQuery để lấy chiều rộng và chiều cao màn hình
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Padding và spacing dựa trên phần trăm của chiều rộng và chiều cao màn hình
    double horizontalPadding = screenWidth * 0.08; // 8% của chiều rộng màn hình
    double verticalSpacing = screenHeight * 0.02;  // 2% của chiều cao màn hình

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: verticalSpacing * 3), // Khoảng cách phía trên
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Password Recovery',
                    style: TextStyle(
                      fontSize: screenWidth * 0.08, // 8% của chiều rộng màn hình
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: verticalSpacing),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Please enter your email to receive your OTP',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045, // 4.5% của chiều rộng màn hình
                    ),
                  ),
                ),
                SizedBox(height: verticalSpacing * 2),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: Icon(Icons.email),
                          contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.02), // 2% của chiều cao
                        ),
                        validator: validateEmail,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: verticalSpacing * 2), // Khoảng trống dưới form
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: screenHeight * 0.03),
        child: SizedBox(
          height: screenHeight * 0.08, // 8% của chiều cao màn hình
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                print('Email: ${_emailController.text}');
                context.router.replace(VerifyCodeRoute());
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.customPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Send Code',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                SizedBox(width: 10),
                Icon(Icons.arrow_forward, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
