import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class ConversionScreen extends StatefulWidget {
  const ConversionScreen({super.key});

  @override
  State<ConversionScreen> createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  final TextEditingController amountController = TextEditingController();

  String fromCurrency = "USD";
  String toCurrency = "NGN";

  double result = 0.0;

  final List<String> currencies = [
    "USD",
    "NGN",
    "EUR",
    "GBP",
    "JPY",
    "CAD"
  ];

  void convertCurrency() {
    double amount = double.tryParse(amountController.text) ?? 0;

    // ⭐ Dummy conversion rate (replace with API later)
    double rate = 1500.0;

    setState(() {
      result = amount * rate;
    });
  }

  void swapCurrencies() {
    setState(() {
      String temp = fromCurrency;
      fromCurrency = toCurrency;
      toCurrency = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Currency Converter"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [

            // ⭐ Amount Input Card
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Enter Amount",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.money),
                        hintText: "Enter amount",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ⭐ Currency Selection Card
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _currencyDropdown(
                      label: "From",
                      value: fromCurrency,
                      onChanged: (value) {
                        setState(() {
                          fromCurrency = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    IconButton(
                      icon: const Icon(Icons.swap_vert, size: 30),
                      color: AppTheme.primaryColor,
                      onPressed: swapCurrencies,
                    ),
                    const SizedBox(height: 20),
                    _currencyDropdown(
                      label: "To",
                      value: toCurrency,
                      onChanged: (value) {
                        setState(() {
                          toCurrency = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ⭐ Convert Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: convertCurrency,
                child: const Text("Convert Currency"),
              ),
            ),

            const SizedBox(height: 25),

            // ⭐ Result Display Card
            if (result > 0)
              Card(
                color: AppTheme.primaryColor.withOpacity(0.1),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        "Conversion Result",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "$result $toCurrency",
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  // ⭐ Currency Dropdown Widget
  Widget _currencyDropdown({
    required String label,
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField(
          value: value,
          items: currencies
              .map(
                (currency) => DropdownMenuItem(
                  value: currency,
                  child: Text(currency),
                ),
              )
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}
