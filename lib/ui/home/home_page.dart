import 'package:agi_productions/services/auth_service.dart';
import 'package:agi_productions/services/service_locator.dart';
import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _onLogoutPressed(BuildContext context) {
    locator<AuthService>().signOut(
      onSuccess: () => Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.loginScreen,
        (_) => false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              if (result == 'logout') {
                _onLogoutPressed(context);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: const Center(child: Text('Welcome to the Home Page!')),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, AppRoutes.newForm),
      ),
    );
  }
}
