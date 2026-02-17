import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../routes/app_routes.dart'; // Add this import
import '../../widgets/currency_selector.dart';
import '../../widgets/animated_amount_input.dart';
import '../../widgets/conversion_result_card.dart';

class ConversionScreen extends StatefulWidget {
  const ConversionScreen({super.key});

  @override
  State<ConversionScreen> createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> with SingleTickerProviderStateMixin {
  final _amountController = TextEditingController();
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  double _convertedAmount = 0;
  bool _isLoading = false;
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _convertCurrency() async {
    if (_amountController.text.isEmpty) {
      _showErrorSnackBar('Please enter an amount');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      // Mock conversion logic
      double amount = double.tryParse(_amountController.text) ?? 0;
      if (_fromCurrency == 'USD' && _toCurrency == 'EUR') {
        _convertedAmount = amount * 0.92;
      } else if (_fromCurrency == 'EUR' && _toCurrency == 'USD') {
        _convertedAmount = amount * 1.09;
      } else {
        _convertedAmount = amount;
      }
      _isLoading = false;
    });

    // Show success message
    _showSuccessSnackBar('Conversion completed!');
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.errorColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.successColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _swapCurrencies() {
    setState(() {
      String temp = _fromCurrency;
      _fromCurrency = _toCurrency;
      _toCurrency = temp;
      _convertedAmount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.history);
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.primaryColor.withValues(alpha: 0.05), // Fixed: replaced withOpacity
              AppTheme.backgroundColor,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.all(size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Convert Currency',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SizedBox(height: size.height * 0.005),
                      Text(
                        'Real-time exchange rates',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: size.height * 0.03),
                
                // Amount Input with Animation
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation, // Fixed: changed from offset to position
                    child: AnimatedAmountInput(
                      controller: _amountController,
                      onChanged: (value) {
                        if (_convertedAmount > 0) {
                          setState(() {
                            _convertedAmount = 0;
                          });
                        }
                      },
                    ),
                  ),
                ),
                
                SizedBox(height: size.height * 0.02),
                
                // Currency Selectors
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation, // Fixed: changed from offset to position
                    child: Row(
                      children: [
                        // From Currency
                        Expanded(
                          child: CurrencySelector(
                            label: 'From',
                            selectedCurrency: _fromCurrency,
                            onTap: () async {
                              final result = await _showCurrencyPicker();
                              if (result != null) {
                                setState(() {
                                  _fromCurrency = result;
                                  _convertedAmount = 0;
                                });
                              }
                            },
                          ),
                        ),
                        
                        // Swap Button
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                          child: GestureDetector(
                            onTap: _swapCurrencies,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withValues(alpha: 0.1), // Fixed: replaced withOpacity
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.swap_vert_rounded,
                                color: AppTheme.primaryColor,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                        
                        // To Currency
                        Expanded(
                          child: CurrencySelector(
                            label: 'To',
                            selectedCurrency: _toCurrency,
                            onTap: () async {
                              final result = await _showCurrencyPicker();
                              if (result != null) {
                                setState(() {
                                  _toCurrency = result;
                                  _convertedAmount = 0;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: size.height * 0.03),
                
                // Exchange Rate Info
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    padding: EdgeInsets.all(size.width * 0.04),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.borderColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Current Rate',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            SizedBox(height: size.height * 0.005),
                            Text(
                              '1 $_fromCurrency = ${_fromCurrency == 'USD' && _toCurrency == 'EUR' ? '0.92' : '1.09'} $_toCurrency',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppTheme.successColor.withValues(alpha: 0.1), // Fixed: replaced withOpacity
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.trending_up,
                                color: AppTheme.successColor,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '+0.23%',
                                style: TextStyle(
                                  color: AppTheme.successColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: size.height * 0.03),
                
                // Convert Button
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _convertCurrency,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.secondaryColor,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text('Convert Now'),
                  ),
                ),
                
                SizedBox(height: size.height * 0.03),
                
                // Conversion Result
                if (_convertedAmount > 0)
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: ConversionResultCard(
                      fromAmount: double.tryParse(_amountController.text) ?? 0,
                      fromCurrency: _fromCurrency,
                      toAmount: _convertedAmount,
                      toCurrency: _toCurrency,
                      rate: _fromCurrency == 'USD' && _toCurrency == 'EUR' ? 0.92 : 1.09,
                    ),
                  ),
                
                SizedBox(height: size.height * 0.02),
                
                // Quick Conversions
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quick Conversions',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: size.height * 0.02),
                      Wrap(
                        spacing: size.width * 0.02,
                        runSpacing: size.height * 0.01,
                        children: [
                          _buildQuickChip('USD', 'EUR'),
                          _buildQuickChip('EUR', 'GBP'),
                          _buildQuickChip('GBP', 'USD'),
                          _buildQuickChip('USD', 'JPY'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickChip(String from, String to) {
    return ActionChip(
      label: Text('$from → $to'),
      onPressed: () {
        setState(() {
          _fromCurrency = from;
          _toCurrency = to;
          _convertedAmount = 0;
        });
      },
      backgroundColor: AppTheme.surfaceColor,
      labelStyle: TextStyle(
        color: AppTheme.textPrimary,
        fontSize: 12,
      ),
    );
  }

  Future<String?> _showCurrencyPicker() {
    return showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'Select Currency',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: _currencies.length,
                  itemBuilder: (context, index) {
                    final currency = _currencies[index];
                    return ListTile(
                      leading: Text(
                        currency['flag']!,
                        style: const TextStyle(fontSize: 24),
                      ),
                      title: Text(currency['code']!),
                      subtitle: Text(currency['name']!),
                      onTap: () => Navigator.pop(context, currency['code']),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

final List<Map<String, String>> _currencies = [
  {'code': 'USD', 'name': 'US Dollar', 'flag': '🇺🇸'},
  {'code': 'EUR', 'name': 'Euro', 'flag': '🇪🇺'},
  {'code': 'GBP', 'name': 'British Pound', 'flag': '🇬🇧'},
  {'code': 'JPY', 'name': 'Japanese Yen', 'flag': '🇯🇵'},
  {'code': 'AUD', 'name': 'Australian Dollar', 'flag': '🇦🇺'},
  {'code': 'CAD', 'name': 'Canadian Dollar', 'flag': '🇨🇦'},
  {'code': 'CHF', 'name': 'Swiss Franc', 'flag': '🇨🇭'},
  {'code': 'CNY', 'name': 'Chinese Yuan', 'flag': '🇨🇳'},
  {'code': 'INR', 'name': 'Indian Rupee', 'flag': '🇮🇳'},
  {'code': 'BRL', 'name': 'Brazilian Real', 'flag': '🇧🇷'},
];