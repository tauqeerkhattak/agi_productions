import 'dart:developer';

import 'package:agi_productions/services/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'base_service.dart';
import 'db_service.dart';

class AuthService extends BaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createUser({
    required String email,
    required String password,
    required String name,
  }) async {
    await performSafeAction(() async {
      final credentials = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = credentials.user;
      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload();
        await locator<DbService>().setUserData(
          uid: user.uid,
          email: email,
          name: name,
        );
      }
    });
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await performSafeAction(() async {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      log('Signed In Successfully!');
    });
  }

  /// Signs out the current user.
  Future<void> signOut() async {
    await performSafeAction(() async {
      await _auth.signOut();
    });
  }

  User? get currentUser => _auth.currentUser;
}
