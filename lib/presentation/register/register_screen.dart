import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:ielts_tev/utils/route/app_router.dart';
import 'package:flutter/material.dart';
import '../../gen/assets.gen.dart';
import '../../theme/app_colors.dart';
@RoutePage()
class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double horizontalPadding = screenWidth > 600 ? 100 : 30;
    double verticalSpacing = screenWidth > 600 ? 16 : 8;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image(
                    image: Assets.images.logo.provider(), height: 200,
                  ),
                ),
                SizedBox(height: verticalSpacing * 3),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: screenWidth > 600 ? 53 : 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: verticalSpacing),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Create your account to get started',
                    style: TextStyle(
                      fontSize: screenWidth > 600 ? 24 : 18,
                    ),
                  ),
                ),
                SizedBox(height: verticalSpacing * 2),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: Icon(Icons.person),
                          contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                        ),
                        validator: validateName,
                      ),
                      SizedBox(height: verticalSpacing),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: Icon(Icons.email),
                          contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                        ),
                        validator: validateEmail,
                      ),
                      SizedBox(height: verticalSpacing),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: Icon(Icons.lock),
                          contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                        ),
                        validator: validatePassword,
                      ),
                      SizedBox(height: verticalSpacing),
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: Icon(Icons.phone),
                          contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                        ),
                        validator: validatePhone,
                      ),
                      SizedBox(height: verticalSpacing),
                    ],
                  ),
                ),
                SizedBox(height: verticalSpacing * 2),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print('Name: ${_nameController.text}');
                        print('Email: ${_emailController.text}');
                        print('Password: ${_passwordController.text}');
                        print('Phone: ${_phoneController.text}');
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
                          'Signup',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: verticalSpacing * 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?", style: TextStyle(fontSize: 18)),
                    TextButton(
                      onPressed: () {
                        context.router.push(LoginRoute());
                      },
                      child: Text('Login', style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
