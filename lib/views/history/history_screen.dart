import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';


class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'All';
  String _selectedTimeRange = 'All Time';
  
  final List<String> _filters = ['All', 'Recent', 'Favorites'];
  final List<String> _timeRanges = ['All Time', 'Today', 'This Week', 'This Month', 'This Year'];
  
  // Mock history data
  final List<Map<String, dynamic>> _historyData = [
    {
      'id': '1',
      'fromCurrency': 'USD',
      'toCurrency': 'EUR',
      'fromAmount': 1000.00,
      'toAmount': 920.50,
      'rate': 0.9205,
      'date': DateTime.now().subtract(const Duration(hours: 2)),
      'isFavorite': true,
      'type': 'conversion',
    },
    {
      'id': '2',
      'fromCurrency': 'GBP',
      'toCurrency': 'USD',
      'fromAmount': 500.00,
      'toAmount': 635.20,
      'rate': 1.2704,
      'date': DateTime.now().subtract(const Duration(hours: 5)),
      'isFavorite': false,
      'type': 'conversion',
    },
    {
      'id': '3',
      'fromCurrency': 'EUR',
      'toCurrency': 'JPY',
      'fromAmount': 2000.00,
      'toAmount': 317000.00,
      'rate': 158.50,
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'isFavorite': true,
      'type': 'conversion',
    },
    {
      'id': '4',
      'fromCurrency': 'USD',
      'toCurrency': 'CAD',
      'fromAmount': 750.00,
      'toAmount': 945.00,
      'rate': 1.2600,
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'isFavorite': false,
      'type': 'conversion',
    },
  ];

  List<Map<String, dynamic>> get _filteredHistory {
    return _historyData.where((item) {
      final matchesSearch = _searchQuery.isEmpty ||
          '${item['fromCurrency']} → ${item['toCurrency']}'
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());
      
      final matchesFilter = _selectedFilter == 'All' ||
          (_selectedFilter == 'Favorites' && item['isFavorite'] == true);
      
      return matchesSearch && matchesFilter;
    }).toList()
      ..sort((a, b) => b['date'].compareTo(a['date']));
  }

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
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _toggleFavorite(String id) {
    setState(() {
      final index = _historyData.indexWhere((item) => item['id'] == id);
      if (index != -1) {
        _historyData[index]['isFavorite'] = !_historyData[index]['isFavorite'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final hasHistory = _filteredHistory.isNotEmpty;
    
    // Return a Scaffold directly - this provides the Material ancestor
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.primaryColor.withValues(alpha: 0.05),
              AppTheme.backgroundColor,
            ],
          ),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'History',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontSize: size.width * 0.06,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: size.height * 0.005),
                          Text(
                            'Your recent conversions',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: size.width * 0.035,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Search Bar - Now wrapped in Material widget via Scaffold
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
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
                  hintText: 'Search conversions...',
                  prefixIcon: Icon(
                    Icons.search,
                    size: size.width * 0.05,
                    color: AppTheme.textTertiary,
                  ),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            size: size.width * 0.05,
                          ),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = '';
                            });
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.04,
                    vertical: size.height * 0.015,
                  ),
                ),
              ),
            ),
            
            SizedBox(height: size.height * 0.02),
            
            // Filter Chips
            Container(
              height: size.height * 0.05,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                itemBuilder: (context, index) {
                  final filter = _filters[index];
                  final isSelected = _selectedFilter == filter;
                  
                  return Padding(
                    padding: EdgeInsets.only(right: size.width * 0.02),
                    child: FilterChip(
                      label: Text(filter),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedFilter = filter;
                        });
                      },
                      backgroundColor: AppTheme.surfaceColor,
                      selectedColor: AppTheme.primaryColor.withValues(alpha: 0.1),
                      checkmarkColor: AppTheme.primaryColor,
                      labelStyle: TextStyle(
                        color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondary,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        fontSize: size.width * 0.03,
                      ),
                    ),
                  );
                },
              ),
            ),
            
            SizedBox(height: size.height * 0.02),
            
            // History List
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: !hasHistory
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.history,
                              size: size.width * 0.2,
                              color: AppTheme.textTertiary.withValues(alpha: 0.3),
                            ),
                            SizedBox(height: size.height * 0.02),
                            Text(
                              'No History Found',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontSize: size.width * 0.05,
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Text(
                              'Start converting currencies to see your history',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: size.width * 0.035,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(size.width * 0.05),
                        itemCount: _filteredHistory.length,
                        itemBuilder: (context, index) {
                          final item = _filteredHistory[index];
                          return _buildHistoryCard(item, size);
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> item, Size size) {
    final date = item['date'] as DateTime;
    final timeString = '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.01),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(
          children: [
            Row(
              children: [
                // Currency Pair Icon
                Container(
                  padding: EdgeInsets.all(size.width * 0.03),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.swap_horiz,
                    color: AppTheme.primaryColor,
                    size: size.width * 0.06,
                  ),
                ),
                
                SizedBox(width: size.width * 0.03),
                
                // Main Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${item['fromCurrency']} → ${item['toCurrency']}',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (item['isFavorite'])
                            Padding(
                              padding: EdgeInsets.only(left: size.width * 0.02),
                              child: Icon(
                                Icons.star,
                                color: AppTheme.accentColor,
                                size: size.width * 0.04,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.002),
                      Text(
                        '${item['fromAmount'].toStringAsFixed(2)} ${item['fromCurrency']} = ${item['toAmount'].toStringAsFixed(2)} ${item['toCurrency']}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: size.width * 0.035,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Time
                Text(
                  timeString,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: size.width * 0.03,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: size.height * 0.01),
            
            // Rate and Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Rate
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02,
                    vertical: size.height * 0.005,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Rate: ${item['rate']}',
                    style: TextStyle(
                      fontSize: size.width * 0.025,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ),
                
                // Action Buttons
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        item['isFavorite'] ? Icons.star : Icons.star_border,
                        color: item['isFavorite'] ? AppTheme.accentColor : AppTheme.textTertiary,
                        size: size.width * 0.045,
                      ),
                      onPressed: () => _toggleFavorite(item['id']),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(
                        minWidth: size.width * 0.08,
                        minHeight: size.width * 0.08,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.refresh,
                        color: AppTheme.primaryColor,
                        size: size.width * 0.045,
                      ),
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(
                        minWidth: size.width * 0.08,
                        minHeight: size.width * 0.08,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}