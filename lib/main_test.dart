import 'package:ielts_tev/presentation/home/home_test.dart';
import 'package:ielts_tev/presentation/login/login_sceen.dart';
import 'package:ielts_tev/presentation/pass_recovery/step1_pass_recovery.dart';
import 'package:ielts_tev/presentation/register/register_screen.dart';
import 'package:ielts_tev/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: AppTheme.theme,
    home: Scaffold(
      body: PhotoGalleryPage(),
    ),

  ));
}