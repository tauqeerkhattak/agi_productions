import 'package:agi_productions/routes/app_routes.dart';
import 'package:agi_productions/services/auth_service.dart';
import 'package:agi_productions/services/service_locator.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 3), () {
        final bool isLoggedIn = locator<AuthService>().currentUser != null;
        final String route = isLoggedIn
            ? AppRoutes.home
            : AppRoutes.loginScreen;
        Navigator.of(context).pushReplacementNamed(route);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
