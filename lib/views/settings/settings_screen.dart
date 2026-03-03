import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../routes/app_routes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _biometricEnabled = false;
  String _selectedLanguage = 'English';
  String _defaultCurrency = 'USD';
  
  final List<String> _languages = ['English', 'Spanish', 'French', 'German', 'Japanese'];
  final List<String> _currencies = ['USD', 'EUR', 'GBP', 'JPY', 'CAD', 'AUD'];

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
            // Header
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(size.width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Settings',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: size.width * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: size.height * 0.005),
                    Text(
                      'Customize your app experience',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: size.width * 0.035,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Profile Section
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                padding: EdgeInsets.all(size.width * 0.04),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.borderColor),
                ),
                child: Row(
                  children: [
                    Container(
                      width: size.width * 0.15,
                      height: size.width * 0.15,
                      decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          'JD',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.04),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'John Doe',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: size.width * 0.045,
                            ),
                          ),
                          Text(
                            'john.doe@email.com',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: size.width * 0.03,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: AppTheme.primaryColor,
                        size: size.width * 0.05,
                      ),
                      onPressed: () {
                        // Navigate to edit profile
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            SliverPadding(
              padding: EdgeInsets.all(size.width * 0.05),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Preferences Section
                  _buildSectionTitle(context, 'Preferences'),
                  SizedBox(height: size.height * 0.015),
                  
                  // Default Currency
                  _buildSettingsTile(
                    context,
                    icon: Icons.currency_exchange,
                    title: 'Default Currency',
                    value: _defaultCurrency,
                    trailing: DropdownButton<String>(
                      value: _defaultCurrency,
                      underline: const SizedBox(),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: AppTheme.primaryColor,
                        size: size.width * 0.05,
                      ),
                      style: TextStyle(
                        fontSize: size.width * 0.035,
                        color: AppTheme.textPrimary,
                      ),
                      items: _currencies.map((String currency) {
                        return DropdownMenuItem<String>(
                          value: currency,
                          child: Text(currency),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _defaultCurrency = value!;
                        });
                      },
                    ),
                  ),
                  
                  // Language
                  _buildSettingsTile(
                    context,
                    icon: Icons.language,
                    title: 'Language',
                    value: _selectedLanguage,
                    trailing: DropdownButton<String>(
                      value: _selectedLanguage,
                      underline: const SizedBox(),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: AppTheme.primaryColor,
                        size: size.width * 0.05,
                      ),
                      style: TextStyle(
                        fontSize: size.width * 0.035,
                        color: AppTheme.textPrimary,
                      ),
                      items: _languages.map((String language) {
                        return DropdownMenuItem<String>(
                          value: language,
                          child: Text(language),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedLanguage = value!;
                        });
                      },
                    ),
                  ),
                  
                  SizedBox(height: size.height * 0.03),
                  
                  // Notifications Section
                  _buildSectionTitle(context, 'Notifications'),
                  SizedBox(height: size.height * 0.015),
                  
                  // Push Notifications
                  _buildSwitchTile(
                    context,
                    icon: Icons.notifications,
                    title: 'Push Notifications',
                    subtitle: 'Receive alerts and updates',
                    value: _notificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                  ),
                  
                  // Rate Alerts
                  if (_notificationsEnabled)
                    _buildSwitchTile(
                      context,
                      icon: Icons.trending_up,
                      title: 'Rate Alerts',
                      subtitle: 'Get notified when rates hit your target',
                      value: true,
                      onChanged: (value) {},
                      indent: true,
                    ),
                  
                  // Market News
                  if (_notificationsEnabled)
                    _buildSwitchTile(
                      context,
                      icon: Icons.article,
                      title: 'Market News',
                      subtitle: 'Daily market updates and analysis',
                      value: true,
                      onChanged: (value) {},
                      indent: true,
                    ),
                  
                  SizedBox(height: size.height * 0.03),
                  
                  // Security Section
                  _buildSectionTitle(context, 'Security'),
                  SizedBox(height: size.height * 0.015),
                  
                  // Biometric Login
                  _buildSwitchTile(
                    context,
                    icon: Icons.fingerprint,
                    title: 'Biometric Login',
                    subtitle: 'Use fingerprint or face ID',
                    value: _biometricEnabled,
                    onChanged: (value) {
                      setState(() {
                        _biometricEnabled = value;
                      });
                    },
                  ),
                  
                  // Change Password
                  _buildSettingsTile(
                    context,
                    icon: Icons.lock,
                    title: 'Change Password',
                    onTap: () {
                      // Navigate to change password
                    },
                  ),
                  
                  // Two-Factor Authentication
                  _buildSettingsTile(
                    context,
                    icon: Icons.security,
                    title: 'Two-Factor Authentication',
                    subtitle: 'Enhance account security',
                    onTap: () {
                      // Navigate to 2FA setup
                    },
                  ),
                  
                  SizedBox(height: size.height * 0.03),
                  
                  // App Settings Section
                  _buildSectionTitle(context, 'App Settings'),
                  SizedBox(height: size.height * 0.015),
                  
                  // Dark Mode
                  _buildSwitchTile(
                    context,
                    icon: Icons.dark_mode,
                    title: 'Dark Mode',
                    subtitle: 'Switch to dark theme',
                    value: _darkModeEnabled,
                    onChanged: (value) {
                      setState(() {
                        _darkModeEnabled = value;
                      });
                    },
                  ),
                  
                  // Clear Cache
                  _buildSettingsTile(
                    context,
                    icon: Icons.cleaning_services,
                    title: 'Clear Cache',
                    subtitle: 'Free up storage space',
                    onTap: () {
                      _showClearCacheDialog(context);
                    },
                  ),
                  
                  // Export Data
                  _buildSettingsTile(
                    context,
                    icon: Icons.download,
                    title: 'Export Data',
                    subtitle: 'Download your conversion history',
                    onTap: () {
                      // Export data
                    },
                  ),
                  
                  SizedBox(height: size.height * 0.03),
                  
                  // Support Section
                  _buildSectionTitle(context, 'Support'),
                  SizedBox(height: size.height * 0.015),
                  
                  // Help Center
                  _buildSettingsTile(
                    context,
                    icon: Icons.help,
                    title: 'Help Center',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.support);
                    },
                  ),
                  
                  // Terms of Service
                  _buildSettingsTile(
                    context,
                    icon: Icons.description,
                    title: 'Terms of Service',
                    onTap: () {
                      // Show terms
                    },
                  ),
                  
                  // Privacy Policy
                  _buildSettingsTile(
                    context,
                    icon: Icons.privacy_tip,
                    title: 'Privacy Policy',
                    onTap: () {
                      // Show privacy policy
                    },
                  ),
                  
                  // About
                  _buildSettingsTile(
                    context,
                    icon: Icons.info,
                    title: 'About',
                    subtitle: 'Version 1.0.0',
                    onTap: () {
                      // Show about
                    },
                  ),
                  
                  SizedBox(height: size.height * 0.02),
                  
                  // Logout Button
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.02),
                    child: OutlinedButton(
                      onPressed: () {
                        _showLogoutDialog(context);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.errorColor,
                        side: BorderSide(color: AppTheme.errorColor),
                        minimumSize: Size(double.infinity, size.height * 0.06),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Log Out',
                        style: TextStyle(
                          fontSize: size.width * 0.04,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: size.height * 0.02),
                ]),
              ),
            ),
          ],
        ),
      );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final size = MediaQuery.of(context).size;
    
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontSize: size.width * 0.045,
        fontWeight: FontWeight.w600,
        color: AppTheme.primaryColor,
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    String? value,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    final size = MediaQuery.of(context).size;
    
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: EdgeInsets.all(size.width * 0.02),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: AppTheme.primaryColor,
          size: size.width * 0.05,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontSize: size.width * 0.04,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: size.width * 0.03,
              ),
            )
          : null,
      trailing: trailing ?? (value != null 
          ? Text(
              value,
              style: TextStyle(
                fontSize: size.width * 0.035,
                color: AppTheme.textSecondary,
              ),
            )
          : Icon(
              Icons.arrow_forward_ios,
              size: size.width * 0.04,
              color: AppTheme.textTertiary,
            )),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
    bool indent = false,
  }) {
    final size = MediaQuery.of(context).size;
    
    return Padding(
      padding: EdgeInsets.only(left: indent ? size.width * 0.1 : 0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          padding: EdgeInsets.all(size.width * 0.02),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: AppTheme.primaryColor,
            size: size.width * 0.05,
          ),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: size.width * 0.04,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: size.width * 0.03,
          ),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: AppTheme.primaryColor,
          activeTrackColor: AppTheme.primaryColor.withValues(alpha: 0.3),
        ),
      ),
    );
  }

  void _showClearCacheDialog(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Icon(
          Icons.cleaning_services,
          size: 50,
          color: AppTheme.primaryColor,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Clear Cache?',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: size.height * 0.01),
            const Text(
              'This will clear all temporary data. Your settings and saved data will not be affected.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cache cleared successfully'),
                  backgroundColor: AppTheme.successColor,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
            ),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Icon(
          Icons.logout,
          size: 50,
          color: AppTheme.errorColor,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Log Out?',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: size.height * 0.01),
            const Text(
              'Are you sure you want to log out?',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorColor,
            ),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }
}