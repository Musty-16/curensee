import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class CurrencySelector extends StatelessWidget {
  final String label;
  final String selectedCurrency;
  final VoidCallback onTap;

  const CurrencySelector({
    super.key,
    required this.label,
    required this.selectedCurrency,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedCurrency,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: AppTheme.textTertiary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}