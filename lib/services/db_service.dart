import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_data.dart';
import 'base_service.dart';

class DbService extends BaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _usersCollection = 'users';

  Future<void> setUserData({
    required String uid,
    required String email,
    required String name,
  }) async {
    await performSafeAction(() async {
      var now = DateTime.now();
      final UserData data = UserData(
        email: email,
        name: name,
        uid: uid,
        createdAt: now,
        updatedAt: now,
      );
      await _db.collection(_usersCollection).doc(uid).set(data.toJson());
    });
  }

  Future<UserData?> getUserData(String uid) async {
    return await performSafeAction(() async {
      final doc = await _db.collection(_usersCollection).doc(uid).get();
      if (!doc.exists) {
        throw Exception('User not found');
      }
      return UserData.fromJson(doc.data()!);
    });
  }
}
