import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class AlertScreen extends StatelessWidget {
  const AlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alerts"),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _sectionTitle("Recent Alerts"),
            const SizedBox(height: 15),
            Expanded(
              child: ListView(
                children: [
                  _alertCard(
                    title: "USD → NGN Alert",
                    message: "Exchange rate dropped by 2%",
                    isCritical: true,
                  ),
                  _alertCard(
                    title: "EUR → NGN Alert",
                    message: "Exchange rate increased by 1.5%",
                    isCritical: false,
                  ),
                  _alertCard(
                    title: "GBP → NGN Alert",
                    message: "Exchange rate dropped by 0.8%",
                    isCritical: false,
                  ),
                  _alertCard(
                    title: "JPY → NGN Alert",
                    message: "Exchange rate increased by 0.5%",
                    isCritical: false,
                  ),
                ],
              ),
            ),
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

  // ⭐ Alert Card Widget
  Widget _alertCard({
    required String title,
    required String message,
    required bool isCritical,
  }) {
    return Card(
      elevation: 3,
      color: isCritical ? Colors.red.shade50 : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(
          Icons.notifications,
          color: isCritical ? Colors.red : AppTheme.primaryColor,
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(message),
        trailing: isCritical
            ? const Icon(Icons.error, color: Colors.red)
            : null,
      ),
    );
  }
}
