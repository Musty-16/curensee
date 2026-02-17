import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';

class OnboardingContent {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  OnboardingContent({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class OnboardingPage extends StatelessWidget {
  final OnboardingContent content;
  final bool isLastPage;

  const OnboardingPage({
    super.key,
    required this.content,
    required this.isLastPage,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Padding(
      padding: EdgeInsets.all(size.width * 0.06),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated Icon Container
          Container(
            width: size.width * 0.4,
            height: size.width * 0.4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  content.color,
                  content.color.withValues(alpha: 0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: content.color.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Icon(
              content.icon,
              size: size.width * 0.15,
              color: Colors.white,
            ),
          ),
          
          SizedBox(height: size.height * 0.05),
          
          // Title
          Text(
            content.title,
            style: GoogleFonts.poppins(
              fontSize: size.width * 0.06,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: size.height * 0.02),
          
          // Description
          Text(
            content.description,
            style: GoogleFonts.poppins(
              fontSize: size.width * 0.035,
              color: AppTheme.textSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: size.height * 0.03),
          
          // "Get Started" button (only on last page)
          if (isLastPage) ...[
            SizedBox(height: size.height * 0.02),
            _buildGetStartedButton(context),
          ],
        ],
      ),
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Container(
      width: double.infinity,
      height: size.height * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Navigate to login screen
            Navigator.pushReplacementNamed(context, '/login');
          },
          borderRadius: BorderRadius.circular(30),
          child: Center(
            child: Text(
              'Get Started',
              style: GoogleFonts.poppins(
                fontSize: size.width * 0.04,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}