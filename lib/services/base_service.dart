import 'dart:developer';

import 'package:agi_productions/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class BaseService {
  Future<T?> performSafeAction<T>(AsyncValueGetter<T> callback) async {
    try {
      return await callback.call();
    } on FirebaseAuthException catch (e, s) {
      log(e.message!, stackTrace: s);
      _showError(e.message);
      return null;
    } on FirebaseException catch (e, s) {
      log(e.message!, stackTrace: s);
      _showError(e.message);
      return null;
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      _showError(e.toString());
      return null;
    }
  }

  void _showError(String? message) async {
    late ScaffoldFeatureController controller;
    controller = ScaffoldMessenger.of(navigatorKey.currentState!.context)
        .showMaterialBanner(
          MaterialBanner(
            backgroundColor: Colors.red,
            content: Text(
              message ?? 'Something went wrong!',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  controller.close();
                },
                child: Text('Dismiss', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
  }
}
