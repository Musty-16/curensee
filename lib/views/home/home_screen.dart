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
    
    return Container(
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
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Header Section (not a SliverAppBar, just a header)
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(size.width * 0.05),
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                ),
                child: SafeArea(
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
                                'Welcome back,',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Colors.white70,
                                  fontSize: size.width * 0.035,
                                ),
                              ),
                              Text(
                                'John Doe 👋',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.06,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.notifications_outlined,
                                size: size.width * 0.06,
                              ),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.pushNamed(context, AppRoutes.alerts, arguments: 0);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),
                      
                      // Quick Balance Card
                      Container(
                        padding: EdgeInsets.all(size.width * 0.05),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
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
                                    fontSize: size.width * 0.035,
                                  ),
                                ),
                                SizedBox(height: size.height * 0.005),
                                Text(
                                  '\$12,345.67',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 0.07,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(size.width * 0.03),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.trending_up,
                                color: Colors.white,
                                size: size.width * 0.06,
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
            
            // Main Content
            SliverPadding(
              padding: EdgeInsets.all(size.width * 0.05),
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
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontSize: size.width * 0.05,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'View All',
                                style: TextStyle(
                                  fontSize: size.width * 0.035,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),
                        const QuickActionGrid(),
                        
                        SizedBox(height: size.height * 0.03),
                        
                        // Popular Currencies
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Popular Currencies',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontSize: size.width * 0.05,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, AppRoutes.currencyList, arguments: 0);
                              },
                              child: Text(
                                'See All',
                                style: TextStyle(
                                  fontSize: size.width * 0.035,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),
                        SizedBox(
                          height: size.height * 0.12,
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
                        
                        SizedBox(height: size.height * 0.03),
                        
                        // Market Trends
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Market Trends',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontSize: size.width * 0.05,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, AppRoutes.news, arguments: 0);
                              },
                              child: Text(
                                'More News',
                                style: TextStyle(
                                  fontSize: size.width * 0.035,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),
                        
                        const MarketTrendCard(
                          title: 'USD/EUR',
                          change: -0.15,
                          news: 'Euro strengthens amid economic data',
                        ),
                        SizedBox(height: size.height * 0.01),
                        const MarketTrendCard(
                          title: 'GBP/USD',
                          change: 0.23,
                          news: 'Pound rises on positive Brexit talks',
                        ),
                        SizedBox(height: size.height * 0.01),
                        const MarketTrendCard(
                          title: 'USD/JPY',
                          change: 0.45,
                          news: 'Yen weakens as BoJ maintains policy',
                        ),
                        
                        SizedBox(height: size.height * 0.03),
                        
                        // Recent Conversions
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Recent Conversions',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontSize: size.width * 0.05,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, AppRoutes.history);
                              },
                              child: Text(
                                'View History',
                                style: TextStyle(
                                  fontSize: size.width * 0.035,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),
                        
                        ...List.generate(3, (index) => Container(
                          margin: EdgeInsets.only(bottom: size.height * 0.01),
                          padding: EdgeInsets.all(size.width * 0.04),
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppTheme.borderColor),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(size.width * 0.025),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.swap_horiz,
                                  color: AppTheme.primaryColor,
                                  size: size.width * 0.05,
                                ),
                              ),
                              SizedBox(width: size.width * 0.03),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'USD → EUR',
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontSize: size.width * 0.04,
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
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: AppTheme.primaryColor,
                                      fontSize: size.width * 0.04,
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
                        )),
                        
                        SizedBox(height: size.height * 0.02),
                        
                        // Convert Button
                        SizedBox(
                          width: double.infinity,
                          height: size.height * 0.06,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.conversion);
                            },
                            icon: Icon(Icons.currency_exchange, size: size.width * 0.05),
                            label: Text(
                              'Start New Conversion',
                              style: TextStyle(fontSize: size.width * 0.04),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.secondaryColor,
                            ),
                          ),
                        ),
                        
                        SizedBox(height: size.height * 0.02),
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
}