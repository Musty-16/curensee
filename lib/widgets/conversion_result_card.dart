import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class ConversionResultCard extends StatelessWidget {
  final double fromAmount;
  final String fromCurrency;
  final double toAmount;
  final String toCurrency;
  final double rate;

  const ConversionResultCard({
    super.key,
    required this.fromAmount,
    required this.fromCurrency,
    required this.toAmount,
    required this.toCurrency,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Container(
      padding: EdgeInsets.all(size.width * 0.05),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppTheme.elevatedShadow,
      ),
      child: Column(
        children: [
          Text(
            'Converted Amount',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white70,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            '${fromAmount.toStringAsFixed(2)} $fromCurrency =',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontSize: size.width * 0.045, // Responsive font
            ),
          ),
          SizedBox(height: size.height * 0.005),
          Text(
            '${toAmount.toStringAsFixed(2)} $toCurrency',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: size.width * 0.06, // Responsive font
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03,
              vertical: size.height * 0.01,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2), // Fixed
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '1 $fromCurrency = ${rate.toStringAsFixed(4)} $toCurrency',
              style: TextStyle(
                color: Colors.white,
                fontSize: size.width * 0.03, // Responsive font
              ),
            ),
          ),
        ],
      ),
    );
  }
}