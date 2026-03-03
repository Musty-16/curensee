import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../home/home_screen.dart';
import '../currency/conversion_screen.dart';
import '../history/history_screen.dart';  
import '../alerts/alert_screen.dart';      
import '../settings/settings_screen.dart'; 

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ConversionScreen(),
    const HistoryScreen(),   
    const AlertScreen(),       
    const SettingsScreen(),    
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    if (_currentIndex != index) {
      _animationController.reset();
      setState(() {
        _currentIndex = index;
      });
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
      
      floatingActionButton: _currentIndex == 0 ? _buildQuickConvertFAB(context) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildQuickConvertFAB(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.07,
      width: size.height * 0.07,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
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
            if (_currentIndex != 1) {
              _onTabTapped(1);
            }
          },
          borderRadius: BorderRadius.circular(20),
          child: const Icon(
            Icons.currency_exchange,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import '../../core/theme/app_theme.dart';
// import '../../widgets/bottom_nav_bar.dart';
// import '../home/home_screen.dart';
// import '../currency/conversion_screen.dart';
// import '../history/history_screen.dart';  // You'll need to create these
// import '../alerts/alert_screen.dart';      // or comment them out for now
// import '../settings/settings_screen.dart'; // until your teammates create them

// class MainNavigationScreen extends StatefulWidget {
//   const MainNavigationScreen({super.key});

//   @override
//   State<MainNavigationScreen> createState() => _MainNavigationScreenState();
// }

// class _MainNavigationScreenState extends State<MainNavigationScreen>
//     with TickerProviderStateMixin {
//   int _currentIndex = 0;
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;

//   // Temporary placeholder screens until teammates create the real ones
//   final List<Widget> _screens = [
//     const HomeScreen(),
//     const ConversionScreen(),
//     const HistoryScreen(),
//     const AlertScreen(),
//     const SettingsScreen(),
//   ];

//   static Widget _buildPlaceholderScreen(String title, IconData icon) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 80, color: AppTheme.primaryColor.withValues(alpha: 0.3)),
//             const SizedBox(height: 16),
//             Text(
//               title,
//               style: const TextStyle(fontSize: 18, color: AppTheme.textSecondary),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Coming soon from other team members',
//               style: const TextStyle(fontSize: 14, color: AppTheme.textTertiary),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     );

//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
//     );

//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   void _onTabTapped(int index) {
//     if (_currentIndex != index) {
//       _animationController.reset();
//       setState(() {
//         _currentIndex = index;
//       });
//       _animationController.forward();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: FadeTransition(
//         opacity: _fadeAnimation,
//         child: IndexedStack(
//           index: _currentIndex,
//           children: _screens,
//         ),
//       ),
//       bottomNavigationBar: BottomNavBar(
//         currentIndex: _currentIndex,
//         onTap: _onTabTapped,
//       ),
      
//       // Only show FAB on home screen (index 0)
//       floatingActionButton: _currentIndex == 0 ? _buildQuickConvertFAB(context) : null,
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }

//   Widget _buildQuickConvertFAB(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Container(
//       height: size.height * 0.07,
//       width: size.height * 0.07,
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: AppTheme.primaryColor.withValues(alpha: 0.3),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: () {
//             // Navigate to convert screen (index 1)
//             if (_currentIndex != 1) {
//               _onTabTapped(1);
//             }
//           },
//           borderRadius: BorderRadius.circular(20),
//           child: const Icon(
//             Icons.currency_exchange,
//             color: Colors.white,
//             size: 30,
//           ),
//         ),
//       ),
//     );
//   }
// }