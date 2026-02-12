import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../currency/conversion_screen.dart';
import '../history/history_screen.dart';
import '../alerts/alert_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            // ⭐ Top Welcome Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 70, bottom: 30),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primaryColor,
                    Color(0xFF357ABD),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.currency_exchange,
                    size: 50,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Welcome Back 👋",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Ready to convert currencies?",
                    style: TextStyle(color: Colors.white70),
                  )
                ],
              ),
            ),

            const SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [

                  // ⭐ Quick Actions Section
                  _sectionTitle("Quick Actions"),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(
                        child: _actionCard(
                          icon: Icons.currency_exchange,
                          title: "Convert",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const ConversionScreen()),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _actionCard(
                          icon: Icons.history,
                          title: "History",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const HistoryScreen()),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _actionCard(
                          icon: Icons.notifications,
                          title: "Alerts",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const AlertScreen()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // ⭐ Market Trends Section
                  _sectionTitle("Market Trends"),

                  const SizedBox(height: 15),

                  _trendCard(
                    "USD → NGN",
                    "₦1500.45",
                    "+2.3%",
                    true,
                  ),

                  const SizedBox(height: 15),

                  _trendCard(
                    "EUR → NGN",
                    "₦1620.12",
                    "-1.2%",
                    false,
                  ),

                  const SizedBox(height: 30),

                  // ⭐ Main Convert Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ConversionScreen()),
                        );
                      },
                      child: const Text("Start Currency Conversion"),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // ⭐ Section Title Widget
  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ⭐ Action Card Widget
  Widget _actionCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            children: [
              Icon(icon, size: 35, color: AppTheme.primaryColor),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }

  // ⭐ Trend Card Widget
  Widget _trendCard(
      String pair, String rate, String change, bool isPositive) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: const Icon(Icons.show_chart),
        title: Text(pair),
        subtitle: Text(rate),
        trailing: Text(
          change,
          style: TextStyle(
            color: isPositive ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
