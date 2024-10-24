import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

@RoutePage()
class ChangePasswordScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double horizontalPadding = screenWidth * 0.08; // 8% chiều rộng
    double verticalSpacing = screenHeight * 0.02;  // 2% chiều cao

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
                    'Change Password',
                    style: TextStyle(
                      fontSize: screenWidth * 0.08, // 8% của chiều rộng
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: verticalSpacing),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Please enter a new password to sign in',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045, // 4.5% của chiều rộng
                    ),
                  ),
                ),
                SizedBox(height: verticalSpacing * 2),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: Icon(Icons.lock),
                          contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.02), // 2% của chiều cao
                        ),
                        validator: validatePassword,
                      ),
                      SizedBox(height: verticalSpacing),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: Icon(Icons.lock_outline),
                          contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.02), // 2% của chiều cao
                        ),
                        validator: validateConfirmPassword,
                      ),
                      SizedBox(height: verticalSpacing * 2),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: screenHeight * 0.03),
        child: SizedBox(
          height: screenHeight * 0.08, // 8% chiều cao
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                print('Password: ${_passwordController.text}');
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
                  'Save & Login',
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
