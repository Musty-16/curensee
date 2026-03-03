import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      // Handle support message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Message sent successfully!'),
          backgroundColor: AppTheme.successColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      
      // Clear form
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewInsets = MediaQuery.of(context).viewInsets;
    
    // Remove MainScaffold - just return the Scaffold directly
    return Scaffold(
      appBar: AppBar(
        title: const Text("Support"),
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            left: size.width * 0.05,
            right: size.width * 0.05,
            top: size.height * 0.02,
            bottom: viewInsets.bottom + size.height * 0.02,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Icon
                Center(
                  child: Container(
                    width: size.width * 0.2,
                    height: size.width * 0.2,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.support_agent,
                      size: size.width * 0.1,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                
                Text(
                  "How can we help you?",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppTheme.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: size.height * 0.01),
                
                Text(
                  "We're here to assist you with any questions or issues.",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                
                SizedBox(height: size.height * 0.03),
                
                // Quick Help Options
                Row(
                  children: [
                    Expanded(
                      child: _buildQuickHelp(
                        icon: Icons.chat,
                        label: 'Live Chat',
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    SizedBox(width: size.width * 0.03),
                    Expanded(
                      child: _buildQuickHelp(
                        icon: Icons.email,
                        label: 'Email',
                        color: AppTheme.secondaryColor,
                      ),
                    ),
                    SizedBox(width: size.width * 0.03),
                    Expanded(
                      child: _buildQuickHelp(
                        icon: Icons.phone,
                        label: 'Call',
                        color: AppTheme.successColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: size.height * 0.03),
                
                // FAQ Section
                Container(
                  padding: EdgeInsets.all(size.width * 0.04),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.borderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Frequently Asked Questions",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: size.height * 0.02),
                      ...List.generate(3, (index) => _buildFaqItem(index)),
                    ],
                  ),
                ),
                
                SizedBox(height: size.height * 0.03),
                
                // Contact Form
                Text(
                  "Send us a message",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: size.height * 0.02),
                
                // Name Field
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Your Name",
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: AppTheme.surfaceColor,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.02),
                
                // Email Field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email Address",
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: AppTheme.surfaceColor,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.02),
                
                // Message Field
                TextFormField(
                  controller: _messageController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: "Message",
                    prefixIcon: const Icon(Icons.message),
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: AppTheme.surfaceColor,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your message';
                    }
                    if (value.length < 10) {
                      return 'Message must be at least 10 characters';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: size.height * 0.04),
                
                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Send Message",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                
                // Extra bottom padding for small screens
                SizedBox(height: size.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickHelp({required IconData icon, required String label, required Color color}) {
    return InkWell(
      onTap: () {
        // Handle quick help action
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem(int index) {
    List<Map<String, String>> faqs = [
      {
        'question': 'How do I reset my password?',
        'answer': 'Go to login screen and click "Forgot Password" to reset your password via email.',
      },
      {
        'question': 'Are exchange rates real-time?',
        'answer': 'Yes, our exchange rates are updated every 60 seconds from trusted financial data providers.',
      },
      {
        'question': 'How do I set rate alerts?',
        'answer': 'Go to Alerts section, select currency pair, set target rate, and enable notifications.',
      },
    ];
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(
          faqs[index]['question']!,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              faqs[index]['answer']!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}