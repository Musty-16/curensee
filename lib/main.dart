import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'views/auth/login_screen.dart';

void main() {
  runApp(const CurrenSeeApp());
}

class CurrenSeeApp extends StatelessWidget {
  const CurrenSeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CurrenSee',
      theme: AppTheme.lightTheme,
      home: const LoginScreen(),
    );
  }
}
