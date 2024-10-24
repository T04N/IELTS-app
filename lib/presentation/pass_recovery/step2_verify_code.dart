import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:ielts_tev/presentation/pass_recovery/step3_change_pass.dart';
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../utils/route/app_router.dart';

@RoutePage()
class VerifyCodeScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();

  String? validateOTP(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the OTP';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double horizontalPadding = screenWidth * 0.08; // 8% của chiều rộng màn hình
    double verticalSpacing = screenHeight * 0.02;  // 2% của chiều cao màn hình

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: verticalSpacing * 3),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Verify Code',
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
                    'An OTP has been sent to your email',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045, // 4.5% của chiều rộng màn hình
                    ),
                  ),
                ),
                SizedBox(height: verticalSpacing * 2),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _otpController,
                    decoration: InputDecoration(
                      labelText: 'OTP',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      prefixIcon: Icon(Icons.lock),
                      contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                    ),
                    validator: validateOTP,
                  ),
                ),
                SizedBox(height: verticalSpacing * 2),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: screenHeight * 0.03),
        child: SizedBox(
          height: screenHeight * 0.08, // 8% chiều cao màn hình
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                print('OTP: ${_otpController.text}');
                context.router.push(ChangePasswordRoute());
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
                  'Verify',
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
