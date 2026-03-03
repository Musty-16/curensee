import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class AlertScreen extends StatefulWidget {
  const AlertScreen({super.key});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  final List<Map<String, dynamic>> _alerts = [
    {
      'id': '1',
      'fromCurrency': 'USD',
      'toCurrency': 'EUR',
      'targetRate': 0.85,
      'currentRate': 0.92,
      'condition': 'below',
      'status': 'active',
      'createdAt': '2024-01-15',
    },
    {
      'id': '2',
      'fromCurrency': 'GBP',
      'toCurrency': 'USD',
      'targetRate': 1.35,
      'currentRate': 1.28,
      'condition': 'above',
      'status': 'triggered',
      'createdAt': '2024-01-14',
    },
    {
      'id': '3',
      'fromCurrency': 'EUR',
      'toCurrency': 'JPY',
      'targetRate': 160.00,
      'currentRate': 158.50,
      'condition': 'above',
      'status': 'active',
      'createdAt': '2024-01-13',
    },
    {
      'id': '4',
      'fromCurrency': 'USD',
      'toCurrency': 'CAD',
      'targetRate': 1.25,
      'currentRate': 1.26,
      'condition': 'below',
      'status': 'inactive',
      'createdAt': '2024-01-12',
    },
  ];

  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Active', 'Triggered', 'Inactive'];

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
    _animationController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredAlerts {
    if (_selectedFilter == 'All') return _alerts;
    return _alerts.where((alert) => 
      alert['status'].toString().toLowerCase() == _selectedFilter.toLowerCase()
    ).toList();
  }

  void _deleteAlert(String id) {
    setState(() {
      _alerts.removeWhere((alert) => alert['id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
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
                            'Rate Alerts',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontSize: size.width * 0.06,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: size.height * 0.005),
                          Text(
                            'Get notified when rates hit your target',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: size.width * 0.035,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: AppTheme.primaryGradient,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.add_rounded,
                            color: Colors.white,
                            size: size.width * 0.07,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Filter Chips
            Container(
              height: size.height * 0.06,
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
            
            // Alerts List
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: _filteredAlerts.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.notifications_off_rounded,
                              size: size.width * 0.2,
                              color: AppTheme.textTertiary.withValues(alpha: 0.3),
                            ),
                            SizedBox(height: size.height * 0.02),
                            Text(
                              'No Alerts Found',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontSize: size.width * 0.05,
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Text(
                              'Create your first rate alert to get started',
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
                        itemCount: _filteredAlerts.length,
                        itemBuilder: (context, index) {
                          return _buildAlertCard(_filteredAlerts[index], size);
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertCard(Map<String, dynamic> alert, Size size) {
    final isActive = alert['status'] == 'active';
    final isTriggered = alert['status'] == 'triggered';
    
    Color statusColor;
    IconData statusIcon;
    String statusText;
    
    if (isTriggered) {
      statusColor = AppTheme.successColor;
      statusIcon = Icons.check_circle;
      statusText = 'Triggered';
    } else if (isActive) {
      statusColor = AppTheme.primaryColor;
      statusIcon = Icons.notifications_active;
      statusText = 'Active';
    } else {
      statusColor = AppTheme.textTertiary;
      statusIcon = Icons.notifications_off;
      statusText = 'Inactive';
    }
    
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.015),
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Currency Pair
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(size.width * 0.03),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${alert['fromCurrency']}/${alert['toCurrency']}',
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.04,
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.03),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Target: ${alert['targetRate']}',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontSize: size.width * 0.035,
                            ),
                          ),
                          Text(
                            'Current: ${alert['currentRate']}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: size.width * 0.03,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Status
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.02,
                  vertical: size.height * 0.005,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      statusIcon,
                      size: size.width * 0.035,
                      color: statusColor,
                    ),
                    SizedBox(width: size.width * 0.01),
                    Text(
                      statusText,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: size.width * 0.03,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: size.height * 0.015),
          
          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                  size: size.width * 0.04,
                  color: AppTheme.textSecondary,
                ),
                label: Text(
                  'Edit',
                  style: TextStyle(
                    fontSize: size.width * 0.03,
                    color: AppTheme.textSecondary,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02,
                    vertical: size.height * 0.01,
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.02),
              TextButton.icon(
                onPressed: () => _deleteAlert(alert['id']),
                icon: Icon(
                  Icons.delete_outline,
                  size: size.width * 0.04,
                  color: AppTheme.errorColor,
                ),
                label: Text(
                  'Delete',
                  style: TextStyle(
                    fontSize: size.width * 0.03,
                    color: AppTheme.errorColor,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02,
                    vertical: size.height * 0.01,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}