import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  // Dummy conversion history data
  final List<Map<String, String>> history = const [
    {
      "date": "2026-02-10",
      "from": "USD",
      "to": "NGN",
      "amount": "100",
      "result": "₦150000"
    },
    {
      "date": "2026-02-09",
      "from": "EUR",
      "to": "NGN",
      "amount": "50",
      "result": "₦81000"
    },
    {
      "date": "2026-02-08",
      "from": "GBP",
      "to": "NGN",
      "amount": "30",
      "result": "₦57000"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conversion History"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [

            // ⭐ Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  "Your Past Conversions",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ⭐ List of history items
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: history.length,
              itemBuilder: (context, index) {
                final item = history[index];
                return _historyCard(item);
              },
            ),
          ],
        ),
      ),
    );
  }

  // ⭐ Individual history card
  Widget _historyCard(Map<String, String> data) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${data['from']} → ${data['to']}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text("Amount: ${data['amount']}"),
            const SizedBox(height: 4),
            Text("Result: ${data['result']}"),
            const SizedBox(height: 4),
            Text("Date: ${data['date']}"),
          ],
        ),
      ),
    );
  }
}
