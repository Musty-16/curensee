import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../routes/app_routes.dart';

class QuickActionGrid extends StatelessWidget {
  const QuickActionGrid({super.key});

  final List<Map<String, dynamic>> actions = const [
    {'icon': Icons.currency_exchange, 'title': 'Convert', 'route': AppRoutes.conversion},
    {'icon': Icons.history, 'title': 'History', 'route': AppRoutes.history},
    {'icon': Icons.notifications, 'title': 'Alerts', 'route': AppRoutes.alerts},
    {'icon': Icons.article, 'title': 'News', 'route': AppRoutes.news},
    {'icon': Icons.show_chart, 'title': 'Markets', 'route': AppRoutes.news},
    {'icon': Icons.support_agent, 'title': 'Support', 'route': AppRoutes.support},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.9,
        crossAxisSpacing: size.width * 0.02,
        mainAxisSpacing: size.height * 0.015,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final action = actions[index];
        return _buildActionItem(
          context,
          icon: action['icon'],
          title: action['title'],
          onTap: () {
            Navigator.pushNamed(context, action['route']);
          },
        );
      },
    );
  }

  Widget _buildActionItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.1), // Fixed
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppTheme.primaryColor,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: MediaQuery.of(context).size.width * 0.03, // Responsive font
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}