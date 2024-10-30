import 'dart:math';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ielts_tev/domains/authentication_repository/authentication_repository.dart';
import '../../gen/assets.gen.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../../utils/route/app_router.dart';
import 'bloc/login_cubit.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
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




  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double horizontalPadding = screenWidth > 600 ? 100 : 30;
    double verticalSpacing = screenWidth > 600 ? 16 : 8;


    void login({required String email, required String password}) {
      if (_formKey.currentState!.validate()) {
        print('Name: ${_emailController.text}');
        print('Password: ${_passwordController.text}');
      } else  {
        final loginCubit = context.read<LoginCubit>();
        loginCubit.login(email, password);

      }
    }

    return BlocProvider(
      create: (context) {
        final authenticationRepository =
            context.read<AuthenticationRepository>();
        return LoginCubit(authenticationRepository: authenticationRepository);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image(
                    image: Assets.images.logo.provider(),
                  ),
                ),
                SizedBox(height: verticalSpacing * 3),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Welcome',
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
                    'Please enter your details to continue',
                    style: TextStyle(
                      fontSize: screenWidth > 600 ? 24 : 18,
                    ),
                    textAlign: TextAlign.start,
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
                          labelText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: AppColors.customPurple,
                              width: 2.0,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2.0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2.0,
                            ),
                          ),
                          prefixIcon: Icon(Icons.person),
                          contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                        ),
                        validator: validateName,
                      ),
                      SizedBox(height: verticalSpacing),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: AppColors.customPurple,
                              width: 2.0,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2.0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2.0,
                            ),
                          ),
                          prefixIcon: const Icon(Icons.lock),
                          contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                        ),
                        validator: validatePassword,
                      ),
                      SizedBox(height: verticalSpacing),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(value: true, onChanged: (bool? newValue) {}),
                        const Text('Remember me'),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        context.router.push(PasswordRecoveryRoute());
                      },
                      child: const Text('Forgot Password'),
                    ),
                  ],
                ),
                SizedBox(height: verticalSpacing * 2),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: CustomButton(
                    text: 'Login',
                    backgroundColor: AppColors.customPurple,
                    borderColor: AppColors.customPurple,
                    onPressed: () {
                    login(email: _emailController.text, password: _passwordController.text);
                    },
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ),
                SizedBox(height: verticalSpacing),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don’t have an account?",
                        style: TextStyle(fontSize: 18)),
                    TextButton(
                      onPressed: () {
                        context.router.push(RegisterRoute());
                      },
                      child:
                          const Text('Signup', style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
                SizedBox(height: verticalSpacing * 2),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: 'Log in with Google',
                    backgroundColor: Colors.white,
                    borderColor: Colors.black,
                    onPressed: () {},
                    icon: FaIcon(FontAwesomeIcons.google),
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: 'Login with Facebook',
                    backgroundColor: Colors.white,
                    borderColor: Colors.blue,
                    onPressed: () {},
                    icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
                  ),
                ),
                SizedBox(height: verticalSpacing * 2),
                SizedBox(height: verticalSpacing * 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
