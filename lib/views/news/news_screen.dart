import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  final List<String> _categories = ['All', 'Market News', 'Analysis', 'Economic', 'Forex'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
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
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    // Remove MainScaffold - just return the Scaffold directly
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Enhanced App Bar with Gradient
          SliverAppBar(
            expandedHeight: size.height * 0.2,
            floating: true,
            pinned: true,
            backgroundColor: AppTheme.primaryColor,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
              ),
              child: FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(
                  left: size.width * 0.05,
                  bottom: 16,
                ),
                title: Text(
                  'Market News',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                background: Stack(
                  children: [
                    Positioned(
                      right: -20,
                      top: -20,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      left: -30,
                      bottom: -30,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Market Overview Section
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                margin: EdgeInsets.all(size.width * 0.04),
                padding: EdgeInsets.all(size.width * 0.04),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryColor.withValues(alpha: 0.1),
                      AppTheme.secondaryColor.withValues(alpha: 0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.borderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Market Overview',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppTheme.successColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: AppTheme.successColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Live',
                                style: TextStyle(
                                  color: AppTheme.successColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    
                    // Market Stats Grid
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio: 1.6,
                      crossAxisSpacing: size.width * 0.02,
                      mainAxisSpacing: size.height * 0.01,
                      children: [
                        _buildMarketStatCard(
                          'DXY',
                          '104.32',
                          '+0.23%',
                          true,
                          Icons.trending_up,
                        ),
                        _buildMarketStatCard(
                          'VIX',
                          '13.45',
                          '-2.1%',
                          false,
                          Icons.trending_down,
                        ),
                        _buildMarketStatCard(
                          'BTC',
                          '52,145',
                          '+3.4%',
                          true,
                          Icons.trending_up,
                        ),
                        _buildMarketStatCard(
                          'Gold',
                          '2,345',
                          '-0.5%',
                          false,
                          Icons.trending_down,
                        ),
                      ],
                    ),
                    
                    SizedBox(height: size.height * 0.02),
                    
                    // Market Sentiment
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSentimentIndicator('Bullish', 65, AppTheme.successColor),
                        _buildSentimentIndicator('Bearish', 35, AppTheme.errorColor),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Category Tabs
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                color: AppTheme.surfaceColor,
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: AppTheme.primaryColor,
                  unselectedLabelColor: AppTheme.textSecondary,
                  indicatorColor: AppTheme.primaryColor,
                  indicatorWeight: 3,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  unselectedLabelStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                  tabs: _categories.map((category) => Tab(text: category)).toList(),
                ),
              ),
            ),
          ),
          
          // News List
          SliverPadding(
            padding: EdgeInsets.all(size.width * 0.04),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: _buildNewsCard(index),
                  );
                },
                childCount: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketStatCard(String label, String value, String change, bool isPositive, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const Spacer(),
              Icon(
                icon,
                size: 16,
                color: isPositive ? AppTheme.successColor : AppTheme.errorColor,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            change,
            style: TextStyle(
              color: isPositive ? AppTheme.successColor : AppTheme.errorColor,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSentimentIndicator(String label, int percentage, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 4),
        Stack(
          children: [
            Container(
              width: 100,
              height: 6,
              decoration: BoxDecoration(
                color: AppTheme.borderColor,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            Container(
              width: 100 * (percentage / 100),
              height: 6,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          '$percentage%',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildNewsCard(int index) {
    final size = MediaQuery.of(context).size;
    final isBreaking = index % 3 == 0;
    
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.02),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
        boxShadow: AppTheme.cardShadow,
      ),
      child: InkWell(
        onTap: () => _showNewsDetail(context, index),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isBreaking)
              Container(
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  color: AppTheme.primaryColor.withValues(alpha: 0.1),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.7),
                      ],
                    ),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.errorColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'BREAKING NEWS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _getNewsTitle(index),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.all(size.width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isBreaking) ...[
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getCategoryColor(index).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            _getCategory(index),
                            style: TextStyle(
                              color: _getCategoryColor(index),
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          _getTimeAgo(index),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                  Text(
                    _getNewsTitle(index),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getNewsSummary(index),
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.2),
                        child: Text(
                          _getAuthor(index)[0],
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _getAuthor(index),
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${_getSource(index)} • ${_getReadTime(index)} min read',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.bookmark_border, size: 20),
                            onPressed: () {},
                            color: AppTheme.textSecondary,
                          ),
                          IconButton(
                            icon: const Icon(Icons.share, size: 20),
                            onPressed: () {},
                            color: AppTheme.textSecondary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNewsDetail(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppTheme.borderColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      children: [
                        Text(
                          _getNewsTitle(index),
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.2),
                              child: Text(
                                _getAuthor(index)[0],
                                style: TextStyle(
                                  color: AppTheme.primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _getAuthor(index),
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  '${_getSource(index)} • ${_getTimeAgo(index)}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppTheme.primaryColor.withValues(alpha: 0.1),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.image,
                              size: 50,
                              color: AppTheme.textTertiary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'The Federal Reserve signaled it may start cutting interest rates as early as September, marking a significant shift in monetary policy. This decision comes as inflation shows consistent signs of cooling while economic growth remains resilient.',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Market analysts expect this move to weaken the US dollar in the short term while potentially boosting risk assets. The EUR/USD pair has already shown increased volatility, with traders adjusting their positions ahead of the expected policy shift.',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Helper methods for mock data
  String _getNewsTitle(int index) {
    List<String> titles = [
      'Fed Signals Potential Rate Cuts as Inflation Moderates',
      'EUR/USD Surges to 3-Month High on Dovish Fed Comments',
      'Bank of England Holds Rates Steady, Pound Dips',
      'Oil Prices Slide as Demand Concerns Weigh on Market',
      'Tech Stocks Rally as Treasury Yields Fall',
      'Gold Hits Record High on Rate Cut Expectations',
      r'Bitcoin Breaks $50K as Institutional Interest Grows', // Fixed the raw string
      'China Stimulus Boosts Asian Currency Markets',
    ];
    return titles[index % titles.length];
  }

  String _getNewsSummary(int index) {
    return 'Central bank signals shift in monetary policy as economic data suggests cooling inflation and resilient growth...';
  }

  String _getCategory(int index) {
    List<String> categories = ['Market News', 'Analysis', 'Economic', 'Forex', 'Commodities'];
    return categories[index % categories.length];
  }

  Color _getCategoryColor(int index) {
    List<Color> colors = [
      AppTheme.primaryColor,
      AppTheme.secondaryColor,
      AppTheme.successColor,
      AppTheme.accentColor,
      AppTheme.infoColor,
    ];
    return colors[index % colors.length];
  }

  String _getTimeAgo(int index) {
    List<String> times = ['2 hours ago', '5 hours ago', '1 day ago', '3 days ago'];
    return times[index % times.length];
  }

  String _getAuthor(int index) {
    List<String> authors = ['John Smith', 'Sarah Johnson', 'Michael Chen', 'Emma Davis'];
    return authors[index % authors.length];
  }

  String _getSource(int index) {
    List<String> sources = ['Bloomberg', 'Reuters', 'FT', 'WSJ', 'CNBC'];
    return sources[index % sources.length];
  }

  String _getReadTime(int index) {
    return '${3 + (index % 5)}';
  }
}