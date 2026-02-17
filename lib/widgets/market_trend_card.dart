import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class MarketTrendCard extends StatelessWidget {
  final String title;
  final double change;
  final String news;

  const MarketTrendCard({
    super.key,
    required this.title,
    required this.change,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = change >= 0;
    final size = MediaQuery.of(context).size;
    
    return Container(
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(size.width * 0.025),
            decoration: BoxDecoration(
              color: (isPositive ? AppTheme.successColor : AppTheme.errorColor).withValues(alpha: 0.1), // Fixed
              shape: BoxShape.circle,
            ),
            child: Icon(
              isPositive ? Icons.trending_up : Icons.trending_down,
              color: isPositive ? AppTheme.successColor : AppTheme.errorColor,
              size: size.width * 0.05, // Responsive icon
            ),
          ),
          SizedBox(width: size.width * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(width: size.width * 0.02),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.02,
                        vertical: size.height * 0.002,
                      ),
                      decoration: BoxDecoration(
                        color: (isPositive ? AppTheme.successColor : AppTheme.errorColor).withValues(alpha: 0.1), // Fixed
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${isPositive ? '+' : ''}$change%',
                        style: TextStyle(
                          color: isPositive ? AppTheme.successColor : AppTheme.errorColor,
                          fontSize: size.width * 0.025, // Responsive font
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.005),
                Text(
                  news,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: size.width * 0.03, // Responsive font
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: AppTheme.textTertiary,
            size: size.width * 0.035, // Responsive icon
          ),
        ],
      ),
    );
  }
}