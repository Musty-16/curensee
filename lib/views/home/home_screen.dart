import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/quick_action_grid.dart';
import '../../widgets/currency_card.dart';
import '../../widgets/market_trend_card.dart';
import '../../routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    
    // Adjust expanded height for small screens
    final expandedHeight = size.height < 600 ? size.height * 0.35 : size.height * 0.28;
    
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Enhanced App Bar
          SliverAppBar(
            expandedHeight: expandedHeight,
            floating: false,
            pinned: true,
            backgroundColor: AppTheme.primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(size.width * 0.04), // Reduced padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome back,',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.white70,
                                      fontSize: size.width * 0.03,
                                    ),
                                  ),
                                  Text(
                                    'John Doe 👋',
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.045,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.notifications_outlined,
                                  size: size.width * 0.05,
                                ),
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.pushNamed(context, AppRoutes.alerts);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.015),
                        
                        // Quick Balance Card
                        Container(
                          padding: EdgeInsets.all(size.width * 0.04),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Balance',
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.8),
                                      fontSize: size.width * 0.03,
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.002),
                                  Text(
                                    '\$12,345.67',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.05,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.all(size.width * 0.025),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.trending_up,
                                  color: Colors.white,
                                  size: size.width * 0.04,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Main Content
          SliverPadding(
            padding: EdgeInsets.all(size.width * 0.04),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Quick Actions
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Quick Actions',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontSize: size.width * 0.045,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'View All',
                              style: TextStyle(fontSize: size.width * 0.03),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.015),
                      const QuickActionGrid(),
                      
                      SizedBox(height: size.height * 0.02),
                      
                      // Popular Currencies
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Popular Currencies',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontSize: size.width * 0.045,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.currencyList);
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'See All',
                              style: TextStyle(fontSize: size.width * 0.03),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.015),
                      SizedBox(
                        height: size.height * 0.1, // Reduced height
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            CurrencyCard(
                              code: 'USD',
                              name: 'US Dollar',
                              flag: '🇺🇸',
                              rate: 1.00,
                              change: 0.00,
                            ),
                            CurrencyCard(
                              code: 'EUR',
                              name: 'Euro',
                              flag: '🇪🇺',
                              rate: 0.92,
                              change: -0.15,
                            ),
                            CurrencyCard(
                              code: 'GBP',
                              name: 'British Pound',
                              flag: '🇬🇧',
                              rate: 0.79,
                              change: 0.23,
                            ),
                            CurrencyCard(
                              code: 'JPY',
                              name: 'Japanese Yen',
                              flag: '🇯🇵',
                              rate: 148.50,
                              change: 0.45,
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: size.height * 0.02),
                      
                      // Market Trends (Show only 2 items on small screens)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Market Trends',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontSize: size.width * 0.045,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.news);
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'More News',
                              style: TextStyle(fontSize: size.width * 0.03),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.01),
                      
                      // Conditionally show number of items based on screen height
                      if (size.height > 600) ...[
                        const MarketTrendCard(
                          title: 'USD/EUR',
                          change: -0.15,
                          news: 'Euro strengthens amid economic data',
                        ),
                        SizedBox(height: size.height * 0.008),
                        const MarketTrendCard(
                          title: 'GBP/USD',
                          change: 0.23,
                          news: 'Pound rises on positive Brexit talks',
                        ),
                        SizedBox(height: size.height * 0.008),
                        const MarketTrendCard(
                          title: 'USD/JPY',
                          change: 0.45,
                          news: 'Yen weakens as BoJ maintains policy',
                        ),
                      ] else ...[
                        const MarketTrendCard(
                          title: 'USD/EUR',
                          change: -0.15,
                          news: 'Euro strengthens',
                        ),
                        SizedBox(height: size.height * 0.008),
                        const MarketTrendCard(
                          title: 'GBP/USD',
                          change: 0.23,
                          news: 'Pound rises',
                        ),
                      ],
                      
                      SizedBox(height: size.height * 0.02),
                      
                      // Recent Conversions (Show only 2 items on small screens)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recent Conversions',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontSize: size.width * 0.045,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.history);
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'View History',
                              style: TextStyle(fontSize: size.width * 0.03),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.01),
                      
                      // Conditionally show number of recent conversions
                      ...List.generate(
                        size.height > 600 ? 3 : 2, 
                        (index) => _buildRecentConversionItem(index, size),
                      ),
                      
                      SizedBox(height: size.height * 0.015),
                      
                      // Convert Button
                      SizedBox(
                        width: double.infinity,
                        height: size.height * 0.055,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.conversion);
                          },
                          icon: Icon(Icons.currency_exchange, size: size.width * 0.04),
                          label: Text(
                            'Start New Conversion',
                            style: TextStyle(fontSize: size.width * 0.035),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.secondaryColor,
                          ),
                        ),
                      ),
                      
                      // Add bottom padding
                      SizedBox(height: bottomPadding + size.height * 0.02),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentConversionItem(int index, Size size) {
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.008),
      padding: EdgeInsets.all(size.width * 0.03),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(size.width * 0.02),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.swap_horiz,
              color: AppTheme.primaryColor,
              size: size.width * 0.04,
            ),
          ),
          SizedBox(width: size.width * 0.02),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'USD → EUR',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: size.width * 0.035,
                  ),
                ),
                Text(
                  'Amount: \$1,000.00',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: size.width * 0.03,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '€920.50',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.primaryColor,
                  fontSize: size.width * 0.035,
                ),
              ),
              Text(
                '2 hours ago',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: size.width * 0.025,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}