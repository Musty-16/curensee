import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class CurrencyCard extends StatelessWidget {
  final String code;
  final String name;
  final String flag;
  final double rate;
  final double change;

  const CurrencyCard({
    super.key,
    required this.code,
    required this.name,
    required this.flag,
    required this.rate,
    required this.change,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = change >= 0;
    
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                flag,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  code,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            rate.toStringAsFixed(4),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                isPositive ? Icons.trending_up : Icons.trending_down,
                color: isPositive ? AppTheme.successColor : AppTheme.errorColor,
                size: 14,
              ),
              const SizedBox(width: 4),
              Text(
                '${isPositive ? '+' : ''}${change.toStringAsFixed(2)}%',
                style: TextStyle(
                  color: isPositive ? AppTheme.successColor : AppTheme.errorColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}