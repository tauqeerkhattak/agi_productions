import 'package:agi_productions/ui/auth/login_page.dart';
import 'package:agi_productions/ui/auth/splash_page.dart';
import 'package:flutter/material.dart';

import '../ui/home/home_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String loginScreen = '/login_screen';
  static const String signupScreen = '/signup_screen';
  static const String forgotPasswordScreen = '/forgot_password_screen';
  static const String resetPasswordScreen = '/reset_password_screen';
  static const String emailVerificationScreen = '/email_verification_screen';
  static const String home = '/home';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => SplashPage(),
    loginScreen: (context) => LoginPage(),
    home: (_) => HomePage(),
    // signupScreen: (context) => SignupScreen(),
    // forgotPasswordScreen: (context) => ForgotPasswordScreen(),
    // resetPasswordScreen: (context) => ResetPasswordScreen(),
    // emailVerificationScreen: (context) => EmailVerificationScreen(),
  };
}
