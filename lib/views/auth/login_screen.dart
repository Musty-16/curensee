import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pushReplacementNamed(context, AppRoutes.main);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewInsets = MediaQuery.of(context).viewInsets;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.primaryColor.withValues(alpha: 0.1),
              AppTheme.backgroundColor,
            ],
          ),
        ),
        child: SafeArea(
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
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.03),
                  
                  // Logo and Title with Animation
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        children: [
                          Container(
                            width: size.width * 0.2, // Reduced from 0.25
                            height: size.width * 0.2, // Reduced from 0.25
                            decoration: BoxDecoration(
                              gradient: AppTheme.primaryGradient,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: AppTheme.elevatedShadow,
                            ),
                            child: Icon(
                              Icons.currency_exchange,
                              color: Colors.white,
                              size: size.width * 0.08, // Responsive icon size
                            ),
                          ),
                          SizedBox(height: size.height * 0.015),
                          Text(
                            'Welcome Back!',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith( // Changed from displaySmall
                              color: AppTheme.textPrimary,
                              fontSize: size.width * 0.06, // Responsive font
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: size.height * 0.005),
                          Text(
                            'Sign in to continue',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.textSecondary,
                              fontSize: size.width * 0.035, // Responsive font
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(height: size.height * 0.03),
                  
                  // Form Fields with Animation
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _emailController,
                            label: 'Email',
                            hint: 'Enter your email',
                            prefixIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
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
                          SizedBox(height: size.height * 0.015),
                          CustomTextField(
                            controller: _passwordController,
                            label: 'Password',
                            hint: 'Enter your password',
                            prefixIcon: Icons.lock_outline,
                            obscureText: !_isPasswordVisible,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: AppTheme.textTertiary,
                                size: size.width * 0.05, // Responsive icon
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(height: size.height * 0.015),
                  
                  // Remember Me & Forgot Password
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value ?? false;
                                });
                              },
                              activeColor: AppTheme.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce tap area
                            ),
                            Flexible(
                              child: Text(
                                'Remember me',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontSize: size.width * 0.03, // Responsive font
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Flexible(
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Forgot?',
                              style: TextStyle(
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: size.width * 0.03, // Responsive font
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: size.height * 0.02),
                  
                  // Login Button
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: ElevatedButton(
                      onPressed: _handleLogin,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, size.height * 0.06), // Responsive height
                      ),
                      child: Text(
                        'Sign In',
                        style: TextStyle(fontSize: size.width * 0.04), // Responsive font
                      ),
                    ),
                  ),
                  
                  SizedBox(height: size.height * 0.02),
                  
                  // Social Login
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: AppTheme.borderColor,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                              child: Text(
                                'OR',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontSize: size.width * 0.03,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: AppTheme.borderColor,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.015),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildCompactSocialButton(Icons.g_mobiledata, 'Google'),
                            _buildCompactSocialButton(Icons.facebook, 'Facebook'),
                            _buildCompactSocialButton(Icons.apple, 'Apple'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: size.height * 0.02),
                  
                  // Register Link
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            "Don't have an account? ",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: size.width * 0.03,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.register);
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: size.width * 0.035,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: size.height * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompactSocialButton(IconData icon, String label) {
    final size = MediaQuery.of(context).size;
    
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.02,
          vertical: size.height * 0.01,
        ),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon, 
              color: AppTheme.textPrimary, 
              size: size.width * 0.04,
            ),
            SizedBox(width: size.width * 0.01),
            Text(
              label,
              style: TextStyle(
                fontSize: size.width * 0.025,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}