import 'package:ielts_tev/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {

  static ThemeData get theme {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.primaryColor,
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color borderColor;
  final VoidCallback onPressed;
  final  Widget? icon; // Đối số tùy chọn cho icon

  const CustomButton({
    Key? key,
    required this.text,
    required this.backgroundColor,
    required this.borderColor,
    required this.onPressed,
    this.icon, // Đối số tùy chọn cho icon, nếu không có icon, chỉ hiển thị text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(fontSize: 40 ),
        backgroundColor: backgroundColor,
        foregroundColor: backgroundColor == Colors.white ? Colors.black : Colors.white,
        side: BorderSide(color: borderColor, width: 2),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Điều chỉnh row để không chiếm hết chiều ngang
        mainAxisAlignment: MainAxisAlignment.center, // Căn giữa text và icon
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (icon != null) // Nếu có icon, hiển thị icon
            Padding(
              padding: const EdgeInsets.only(left: 8.0), // Khoảng cách giữa text và icon
              child: icon,
            ),
        ],
      ),
    );
  }
}
