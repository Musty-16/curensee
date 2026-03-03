import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class CurrencyListScreen extends StatefulWidget {
  const CurrencyListScreen({super.key});

  @override
  State<CurrencyListScreen> createState() => _CurrencyListScreenState();
}

class _CurrencyListScreenState extends State<CurrencyListScreen> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'All';
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<String> _filters = ['All', 'Major', 'Minor', 'Exotic'];
  
  final List<Map<String, dynamic>> _allCurrencies = [
    {'code': 'USD', 'name': 'US Dollar', 'symbol': '\$', 'flag': '🇺🇸', 'rate': 1.0000, 'change': 0.00, 'type': 'Major'},
    {'code': 'EUR', 'name': 'Euro', 'symbol': '€', 'flag': '🇪🇺', 'rate': 0.9234, 'change': -0.15, 'type': 'Major'},
    {'code': 'GBP', 'name': 'British Pound', 'symbol': '£', 'flag': '🇬🇧', 'rate': 0.7945, 'change': 0.23, 'type': 'Major'},
    {'code': 'JPY', 'name': 'Japanese Yen', 'symbol': '¥', 'flag': '🇯🇵', 'rate': 148.50, 'change': 0.45, 'type': 'Major'},
    {'code': 'AUD', 'name': 'Australian Dollar', 'symbol': 'A\$', 'flag': '🇦🇺', 'rate': 1.5234, 'change': -0.08, 'type': 'Major'},
    {'code': 'CAD', 'name': 'Canadian Dollar', 'symbol': 'C\$', 'flag': '🇨🇦', 'rate': 1.3542, 'change': 0.12, 'type': 'Major'},
    {'code': 'CHF', 'name': 'Swiss Franc', 'symbol': 'CHF', 'flag': '🇨🇭', 'rate': 0.8876, 'change': -0.05, 'type': 'Major'},
    {'code': 'CNY', 'name': 'Chinese Yuan', 'symbol': '¥', 'flag': '🇨🇳', 'rate': 7.1980, 'change': 0.03, 'type': 'Major'},
    {'code': 'INR', 'name': 'Indian Rupee', 'symbol': '₹', 'flag': '🇮🇳', 'rate': 83.12, 'change': 0.18, 'type': 'Minor'},
    {'code': 'BRL', 'name': 'Brazilian Real', 'symbol': 'R\$', 'flag': '🇧🇷', 'rate': 4.98, 'change': -0.22, 'type': 'Minor'},
    {'code': 'ZAR', 'name': 'South African Rand', 'symbol': 'R', 'flag': '🇿🇦', 'rate': 18.76, 'change': 0.31, 'type': 'Minor'},
    {'code': 'SGD', 'name': 'Singapore Dollar', 'symbol': 'S\$', 'flag': '🇸🇬', 'rate': 1.3456, 'change': 0.07, 'type': 'Minor'},
    {'code': 'NZD', 'name': 'New Zealand Dollar', 'symbol': 'NZ\$', 'flag': '🇳🇿', 'rate': 1.6345, 'change': -0.11, 'type': 'Minor'},
    {'code': 'MXN', 'name': 'Mexican Peso', 'symbol': '\$', 'flag': '🇲🇽', 'rate': 17.05, 'change': 0.42, 'type': 'Minor'},
    {'code': 'TRY', 'name': 'Turkish Lira', 'symbol': '₺', 'flag': '🇹🇷', 'rate': 32.15, 'change': 0.89, 'type': 'Exotic'},
  ];

  List<Map<String, dynamic>> get _filteredCurrencies {
    return _allCurrencies.where((currency) {
      final matchesFilter = _selectedFilter == 'All' || currency['type'] == _selectedFilter;
      final matchesSearch = _searchQuery.isEmpty ||
          currency['code'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          currency['name'].toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesFilter && matchesSearch;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Sort By',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              _buildSortOption('Currency Code', Icons.sort_by_alpha),
              _buildSortOption('Exchange Rate', Icons.trending_up),
              _buildSortOption('Daily Change', Icons.show_chart),
              _buildSortOption('Type', Icons.category),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSortOption(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryColor),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        // Implement sorting logic here
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewInsets = MediaQuery.of(context).viewInsets;
    
    // Remove MainScaffold - just return the Scaffold directly
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currencies'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: _showSortOptions,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(size.width * 0.04),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              boxShadow: AppTheme.cardShadow,
            ),
            child: Column(
              children: [
                // Search Field
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.borderColor),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search currencies...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                });
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
                
                SizedBox(height: size.height * 0.02),
                
                // Filter Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _filters.map((filter) {
                      return Padding(
                        padding: EdgeInsets.only(right: size.width * 0.02),
                        child: FilterChip(
                          label: Text(filter),
                          selected: _selectedFilter == filter,
                          onSelected: (selected) {
                            setState(() {
                              _selectedFilter = filter;
                            });
                          },
                          backgroundColor: AppTheme.backgroundColor,
                          selectedColor: AppTheme.primaryColor.withValues(alpha: 0.1),
                          checkmarkColor: AppTheme.primaryColor,
                          labelStyle: TextStyle(
                            color: _selectedFilter == filter
                                ? AppTheme.primaryColor
                                : AppTheme.textSecondary,
                            fontWeight: _selectedFilter == filter
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          
          // Currency List
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: _filteredCurrencies.isEmpty
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: viewInsets.bottom),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 64,
                              color: AppTheme.textTertiary,
                            ),
                            SizedBox(height: size.height * 0.02),
                            Text(
                              'No currencies found',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              'Try adjusting your search',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.only(
                        left: size.width * 0.04,
                        right: size.width * 0.04,
                        top: size.height * 0.02,
                        bottom: viewInsets.bottom + size.height * 0.02,
                      ),
                      itemCount: _filteredCurrencies.length,
                      itemBuilder: (context, index) {
                        final currency = _filteredCurrencies[index];
                        return _buildCurrencyCard(currency, index);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyCard(Map<String, dynamic> currency, int index) {
    final size = MediaQuery.of(context).size;
    final isPositive = currency['change'] >= 0;
    
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 300 + (index * 50)),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: size.height * 0.015),
        padding: EdgeInsets.all(size.width * 0.04),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.borderColor),
          boxShadow: AppTheme.cardShadow,
        ),
        child: InkWell(
          onTap: () {
            // Return the selected currency code to the previous screen
            Navigator.pop(context, currency['code']);
          },
          borderRadius: BorderRadius.circular(16),
          child: Row(
            children: [
              // Flag and Code
              Container(
                width: size.width * 0.15,
                height: size.width * 0.15,
                decoration: BoxDecoration(
                  color: AppTheme.backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    currency['flag'],
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.03),
              
              // Currency Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          currency['code'],
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: size.width * 0.02),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: currency['type'] == 'Major'
                                ? AppTheme.primaryColor.withValues(alpha: 0.1)
                                : currency['type'] == 'Minor'
                                    ? AppTheme.secondaryColor.withValues(alpha: 0.1)
                                    : AppTheme.accentColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            currency['type'],
                            style: TextStyle(
                              fontSize: 10,
                              color: currency['type'] == 'Major'
                                  ? AppTheme.primaryColor
                                  : currency['type'] == 'Minor'
                                      ? AppTheme.secondaryColor
                                      : AppTheme.accentColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.002),
                    Text(
                      currency['name'],
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              
              // Rate and Change
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${currency['symbol']} ${currency['rate'].toStringAsFixed(4)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.002),
                  Row(
                    children: [
                      Icon(
                        isPositive ? Icons.trending_up : Icons.trending_down,
                        color: isPositive ? AppTheme.successColor : AppTheme.errorColor,
                        size: 16,
                      ),
                      SizedBox(width: size.width * 0.01),
                      Text(
                        '${isPositive ? '+' : ''}${currency['change'].toStringAsFixed(2)}%',
                        style: TextStyle(
                          color: isPositive ? AppTheme.successColor : AppTheme.errorColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}