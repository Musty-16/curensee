import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class PageIndicator extends StatelessWidget {
  final int currentIndex;
  final int pageCount;

  const PageIndicator({
    super.key,
    required this.currentIndex,
    required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: currentIndex == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            gradient: currentIndex == index
                ? const LinearGradient(
                    colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
                  )
                : null,
            color: currentIndex == index ? null : AppTheme.borderColor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}