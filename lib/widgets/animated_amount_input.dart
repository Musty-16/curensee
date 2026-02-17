import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class AnimatedAmountInput extends StatefulWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;

  const AnimatedAmountInput({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  State<AnimatedAmountInput> createState() => _AnimatedAmountInputState();
}

class _AnimatedAmountInputState extends State<AnimatedAmountInput> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
          if (hasFocus) {
            _animationController.forward();
          } else {
            _animationController.reverse();
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: _isFocused ? AppTheme.primaryGradient : null,
          borderRadius: BorderRadius.circular(16),
          boxShadow: _isFocused ? AppTheme.elevatedShadow : null,
        ),
        padding: EdgeInsets.all(_isFocused ? 2 : 0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  onChanged: widget.onChanged,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: size.width * 0.08, // Responsive font size
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: '0.00',
                    hintStyle: TextStyle(
                      fontSize: size.width * 0.08, // Responsive font size
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textTertiary.withValues(alpha: 0.3), // Fixed
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Text(
                'USD',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppTheme.textTertiary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}