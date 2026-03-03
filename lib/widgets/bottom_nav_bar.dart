import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap, // Simplified - just pass the tap to parent
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppTheme.surfaceColor,
          selectedItemColor: AppTheme.primaryColor,
          unselectedItemColor: AppTheme.textTertiary,
          selectedLabelStyle: TextStyle(
            fontSize: size.width * 0.025,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: size.width * 0.025,
          ),
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.all(currentIndex == 0 ? size.width * 0.02 : 0),
                decoration: BoxDecoration(
                  color: currentIndex == 0 
                      ? AppTheme.primaryColor.withValues(alpha: 0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.home_rounded,
                  size: size.width * 0.06,
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.all(currentIndex == 1 ? size.width * 0.02 : 0),
                decoration: BoxDecoration(
                  color: currentIndex == 1 
                      ? AppTheme.primaryColor.withValues(alpha: 0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.currency_exchange,
                  size: size.width * 0.06,
                ),
              ),
              label: 'Convert',
            ),
            BottomNavigationBarItem(
              icon: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.all(currentIndex == 2 ? size.width * 0.02 : 0),
                decoration: BoxDecoration(
                  color: currentIndex == 2 
                      ? AppTheme.primaryColor.withValues(alpha: 0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.history_rounded,
                  size: size.width * 0.06,
                ),
              ),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.all(currentIndex == 3 ? size.width * 0.02 : 0),
                decoration: BoxDecoration(
                  color: currentIndex == 3 
                      ? AppTheme.primaryColor.withValues(alpha: 0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.notifications_rounded,
                  size: size.width * 0.06,
                ),
              ),
              label: 'Alerts',
            ),
            BottomNavigationBarItem(
              icon: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.all(currentIndex == 4 ? size.width * 0.02 : 0),
                decoration: BoxDecoration(
                  color: currentIndex == 4 
                      ? AppTheme.primaryColor.withValues(alpha: 0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.person_rounded,
                  size: size.width * 0.06,
                ),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}