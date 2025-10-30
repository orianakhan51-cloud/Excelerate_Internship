import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/form_validation_widget.dart';
import './widgets/password_strength_widget.dart';
import './widgets/profile_photo_widget.dart';
import './widgets/social_registration_widget.dart';
import './widgets/terms_checkbox_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  // Form controllers
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Form state
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isTermsAccepted = false;
  bool _isLoading = false;
  XFile? _selectedProfilePhoto;

  // Validation state
  bool _showFullNameValidation = false;
  bool _showEmailValidation = false;
  bool _showPasswordValidation = false;
  bool _showConfirmPasswordValidation = false;

  // Focus nodes
  final _fullNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _setupFocusListeners();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _scrollController.dispose();
    _fullNameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  void _setupFocusListeners() {
    _fullNameFocus.addListener(() {
      if (!_fullNameFocus.hasFocus && _fullNameController.text.isNotEmpty) {
        setState(() => _showFullNameValidation = true);
      }
    });

    _emailFocus.addListener(() {
      if (!_emailFocus.hasFocus && _emailController.text.isNotEmpty) {
        setState(() => _showEmailValidation = true);
      }
    });

    _passwordFocus.addListener(() {
      if (!_passwordFocus.hasFocus && _passwordController.text.isNotEmpty) {
        setState(() => _showPasswordValidation = true);
      }
    });

    _confirmPasswordFocus.addListener(() {
      if (!_confirmPasswordFocus.hasFocus &&
          _confirmPasswordController.text.isNotEmpty) {
        setState(() => _showConfirmPasswordValidation = true);
      }
    });
  }

  // Validation methods
  bool _isValidFullName(String name) {
    return name.trim().length >= 2 && name.trim().contains(' ');
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email);
  }

  bool _isValidPassword(String password) {
    return password.length >= 8 &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[0-9]'));
  }

  bool _isValidConfirmPassword(String confirmPassword) {
    return confirmPassword == _passwordController.text &&
        confirmPassword.isNotEmpty;
  }

  String? _getFullNameError() {
    if (!_showFullNameValidation) return null;
    final name = _fullNameController.text.trim();
    if (name.isEmpty) return 'Full name is required';
    if (name.length < 2) return 'Name must be at least 2 characters';
    if (!name.contains(' ')) return 'Please enter your full name';
    return null;
  }

  String? _getEmailError() {
    if (!_showEmailValidation) return null;
    final email = _emailController.text.trim();
    if (email.isEmpty) return 'Email is required';
    if (!_isValidEmail(email)) return 'Please enter a valid email address';
    return null;
  }

  String? _getPasswordError() {
    if (!_showPasswordValidation) return null;
    final password = _passwordController.text;
    if (password.isEmpty) return 'Password is required';
    if (password.length < 8) return 'Password must be at least 8 characters';
    if (!password.contains(RegExp(r'[a-z]')))
      return 'Password must contain lowercase letters';
    if (!password.contains(RegExp(r'[A-Z]')))
      return 'Password must contain uppercase letters';
    if (!password.contains(RegExp(r'[0-9]')))
      return 'Password must contain numbers';
    return null;
  }

  String? _getConfirmPasswordError() {
    if (!_showConfirmPasswordValidation) return null;
    final confirmPassword = _confirmPasswordController.text;
    if (confirmPassword.isEmpty) return 'Please confirm your password';
    if (confirmPassword != _passwordController.text)
      return 'Passwords do not match';
    return null;
  }

  bool _isFormValid() {
    return _isValidFullName(_fullNameController.text) &&
        _isValidEmail(_emailController.text) &&
        _isValidPassword(_passwordController.text) &&
        _isValidConfirmPassword(_confirmPasswordController.text) &&
        _isTermsAccepted;
  }

  Future<void> _handleRegistration() async {
    if (!_isFormValid()) return;

    setState(() => _isLoading = true);

    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Account created successfully! Welcome to MADG28 Learning.'),
          backgroundColor: AppTheme.successGreen,
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Navigate to home dashboard
      Navigator.pushReplacementNamed(context, '/home-dashboard');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed. Please try again.'),
          backgroundColor: AppTheme.errorRed,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _handleSocialRegistration(String provider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$provider registration will be available soon!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _openTermsOfService() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Terms of Service'),
        content: SingleChildScrollView(
          child: Text(
            'Welcome to MADG28 Learning. By creating an account, you agree to our terms and conditions for using this educational platform...',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _openPrivacyPolicy() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Privacy Policy'),
        content: SingleChildScrollView(
          child: Text(
            'Your privacy is important to us. This policy explains how we collect, use, and protect your personal information...',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4.h),

                // Header
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: AppTheme.lightTheme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:
                                AppTheme.neutralMedium.withValues(alpha: 0.2),
                          ),
                        ),
                        child: CustomIconWidget(
                          iconName: 'arrow_back_ios',
                          color: AppTheme.neutralDark,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 4.h),

                // Title and subtitle
                Text(
                  'Create Account',
                  style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppTheme.neutralDark,
                  ),
                ),

                SizedBox(height: 1.h),

                Text(
                  'Join MADG28 Learning and start your educational journey with thousands of courses.',
                  style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                    color: AppTheme.neutralMedium,
                    height: 1.5,
                  ),
                ),

                SizedBox(height: 4.h),

                // Profile Photo Section
                Center(
                  child: ProfilePhotoWidget(
                    onPhotoSelected: (photo) {
                      setState(() {
                        _selectedProfilePhoto = photo;
                      });
                    },
                  ),
                ),

                SizedBox(height: 4.h),

                // Full Name Field
                Text(
                  'Full Name',
                  style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                    color: AppTheme.neutralDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 1.h),

                TextFormField(
                  controller: _fullNameController,
                  focusNode: _fullNameFocus,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  onChanged: (value) {
                    if (_showFullNameValidation) {
                      setState(() {});
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your full name',
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: CustomIconWidget(
                        iconName: 'person_outline',
                        color: AppTheme.neutralMedium,
                        size: 20,
                      ),
                    ),
                  ),
                ),

                FormValidationWidget(
                  errorMessage: _getFullNameError(),
                  isValid: _showFullNameValidation &&
                      _isValidFullName(_fullNameController.text),
                  showValidation: _showFullNameValidation,
                ),

                SizedBox(height: 3.h),

                // Email Field
                Text(
                  'Email Address',
                  style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                    color: AppTheme.neutralDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 1.h),

                TextFormField(
                  controller: _emailController,
                  focusNode: _emailFocus,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    if (_showEmailValidation) {
                      setState(() {});
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your email address',
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: CustomIconWidget(
                        iconName: 'email_outlined',
                        color: AppTheme.neutralMedium,
                        size: 20,
                      ),
                    ),
                  ),
                ),

                FormValidationWidget(
                  errorMessage: _getEmailError(),
                  isValid: _showEmailValidation &&
                      _isValidEmail(_emailController.text),
                  showValidation: _showEmailValidation,
                ),

                SizedBox(height: 3.h),

                // Password Field
                Text(
                  'Password',
                  style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                    color: AppTheme.neutralDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 1.h),

                TextFormField(
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  textInputAction: TextInputAction.next,
                  obscureText: !_isPasswordVisible,
                  onChanged: (value) {
                    setState(() {
                      if (_showPasswordValidation) {}
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Create a strong password',
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: CustomIconWidget(
                        iconName: 'lock_outline',
                        color: AppTheme.neutralMedium,
                        size: 20,
                      ),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(3.w),
                        child: CustomIconWidget(
                          iconName: _isPasswordVisible
                              ? 'visibility_off'
                              : 'visibility',
                          color: AppTheme.neutralMedium,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),

                PasswordStrengthWidget(password: _passwordController.text),

                FormValidationWidget(
                  errorMessage: _getPasswordError(),
                  isValid: _showPasswordValidation &&
                      _isValidPassword(_passwordController.text),
                  showValidation: _showPasswordValidation,
                ),

                SizedBox(height: 3.h),

                // Confirm Password Field
                Text(
                  'Confirm Password',
                  style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                    color: AppTheme.neutralDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 1.h),

                TextFormField(
                  controller: _confirmPasswordController,
                  focusNode: _confirmPasswordFocus,
                  textInputAction: TextInputAction.done,
                  obscureText: !_isConfirmPasswordVisible,
                  onChanged: (value) {
                    if (_showConfirmPasswordValidation) {
                      setState(() {});
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Confirm your password',
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: CustomIconWidget(
                        iconName: 'lock_outline',
                        color: AppTheme.neutralMedium,
                        size: 20,
                      ),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(3.w),
                        child: CustomIconWidget(
                          iconName: _isConfirmPasswordVisible
                              ? 'visibility_off'
                              : 'visibility',
                          color: AppTheme.neutralMedium,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),

                FormValidationWidget(
                  errorMessage: _getConfirmPasswordError(),
                  isValid: _showConfirmPasswordValidation &&
                      _isValidConfirmPassword(_confirmPasswordController.text),
                  showValidation: _showConfirmPasswordValidation,
                ),

                SizedBox(height: 4.h),

                // Terms and Conditions
                TermsCheckboxWidget(
                  isAccepted: _isTermsAccepted,
                  onChanged: (value) {
                    setState(() {
                      _isTermsAccepted = value ?? false;
                    });
                  },
                  onTermsTap: _openTermsOfService,
                  onPrivacyTap: _openPrivacyPolicy,
                ),

                SizedBox(height: 4.h),

                // Create Account Button
                SizedBox(
                  width: double.infinity,
                  height: 7.h,
                  child: ElevatedButton(
                    onPressed: _isFormValid() && !_isLoading
                        ? _handleRegistration
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isFormValid()
                          ? AppTheme.primaryOrange
                          : AppTheme.neutralMedium.withValues(alpha: 0.3),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor:
                          AppTheme.neutralMedium.withValues(alpha: 0.3),
                      disabledForegroundColor: AppTheme.neutralMedium,
                    ),
                    child: _isLoading
                        ? SizedBox(
                            width: 6.w,
                            height: 6.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            'Create Account',
                            style: AppTheme.lightTheme.textTheme.labelLarge
                                ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),

                SizedBox(height: 4.h),

                // Social Registration
                SocialRegistrationWidget(
                  onGoogleTap: () => _handleSocialRegistration('Google'),
                  onAppleTap: () => _handleSocialRegistration('Apple'),
                  onFacebookTap: () => _handleSocialRegistration('Facebook'),
                ),

                SizedBox(height: 4.h),

                // Login Link
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.neutralMedium,
                      ),
                      children: [
                        TextSpan(text: 'Already have an account? '),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () => Navigator.pushReplacementNamed(
                                context, '/login-screen'),
                            child: Text(
                              'Sign In',
                              style: AppTheme.lightTheme.textTheme.bodyMedium
                                  ?.copyWith(
                                color: AppTheme.primaryOrange,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
