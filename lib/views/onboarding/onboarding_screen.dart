import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import 'onboarding_content.dart';
import 'page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingContent> _onboardingData = [
    OnboardingContent(
      title: 'Track Live Exchange Rates',
      description: 'Get real-time currency exchange rates from around the world. Stay updated with the latest market movements.',
      icon: Icons.currency_exchange,
      color: AppTheme.primaryColor,
    ),
    OnboardingContent(
      title: 'Set Rate Alerts',
      description: 'Never miss the perfect exchange rate. Set custom alerts and get notified when your target rate is reached.',
      icon: Icons.notifications_active,
      color: AppTheme.secondaryColor,
    ),
    OnboardingContent(
      title: 'Historical Data & Trends',
      description: 'View historical exchange rate data and analyze market trends to make informed currency decisions.',
      icon: Icons.show_chart,
      color: AppTheme.accentColor,
    ),
    OnboardingContent(
      title: 'Secure & Easy to Use',
      description: 'Your data is safe with us. Enjoy a seamless experience with our intuitive and user-friendly interface.',
      icon: Icons.security,
      color: AppTheme.successColor,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      // Navigate to login screen
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void _skipOnboarding() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Padding(
              padding: EdgeInsets.all(size.width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _skipOnboarding,
                    style: TextButton.styleFrom(
                      foregroundColor: AppTheme.textSecondary,
                    ),
                    child: Text(
                      'Skip',
                      style: GoogleFonts.poppins(
                        fontSize: size.width * 0.035,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    content: _onboardingData[index],
                    isLastPage: index == _onboardingData.length - 1,
                  );
                },
              ),
            ),
            
            // Page Indicator
            Padding(
              padding: EdgeInsets.all(size.width * 0.05),
              child: Column(
                children: [
                  PageIndicator(
                    currentIndex: _currentPage,
                    pageCount: _onboardingData.length,
                  ),
                  
                  SizedBox(height: size.height * 0.03),
                  
                  // Next/Get Started button (only show if not last page)
                  if (_currentPage < _onboardingData.length - 1)
                    _buildNextButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Container(
      width: double.infinity,
      height: size.height * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppTheme.primaryColor, width: 1.5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _nextPage,
          borderRadius: BorderRadius.circular(30),
          child: Center(
            child: Text(
              'Next',
              style: GoogleFonts.poppins(
                fontSize: size.width * 0.04,
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}