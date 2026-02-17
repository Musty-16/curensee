import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_routes.dart';

// Screens
import 'views/splash/splash_screen.dart'; // Add this import
import 'views/auth/login_screen.dart';
import 'views/auth/register_screen.dart';
import 'views/home/home_screen.dart';
import 'views/currency/conversion_screen.dart';
import 'views/currency/currency_list_screen.dart';
import 'views/news/news_screen.dart';
import 'views/support/support_screen.dart';

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
      
      initialRoute: AppRoutes.splash, // Changed from login to splash
      
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(), // Add this
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.register: (context) => const RegisterScreen(),
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.conversion: (context) => const ConversionScreen(),
        AppRoutes.currencyList: (context) => const CurrencyListScreen(),
        AppRoutes.news: (context) => const NewsScreen(),
        AppRoutes.support: (context) => const SupportScreen(),
      },
      
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: AppTheme.errorColor,
                ),
                const SizedBox(height: 16),
                Text(
                  'Page not found',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}